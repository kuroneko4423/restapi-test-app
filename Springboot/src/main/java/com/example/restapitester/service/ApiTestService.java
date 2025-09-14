package com.example.restapitester.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.Map;

@Service
public class ApiTestService {

    private final WebClient webClient;
    private final ObjectMapper objectMapper;

    public ApiTestService() {
        this.webClient = WebClient.builder()
                .codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(10 * 1024 * 1024))
                .build();
        this.objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
    }

    public Map<String, Object> makeApiRequest(String endpoint, String method, Map<String, String> parameters) {
        Map<String, Object> result = new HashMap<>();

        try {
            String url = endpoint;
            WebClient.RequestBodySpec requestSpec = null;
            WebClient.RequestHeadersSpec<?> headersSpec = null;

            if ("GET".equalsIgnoreCase(method)) {
                UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(endpoint);
                if (parameters != null && !parameters.isEmpty()) {
                    parameters.forEach(builder::queryParam);
                }
                url = builder.toUriString();
                headersSpec = webClient.get().uri(url);
            } else {
                switch (method.toUpperCase()) {
                    case "POST":
                        requestSpec = webClient.post().uri(endpoint);
                        break;
                    case "PUT":
                        requestSpec = webClient.put().uri(endpoint);
                        break;
                    case "DELETE":
                        requestSpec = webClient.delete().uri(endpoint).body(Mono.just(parameters), Map.class);
                        headersSpec = requestSpec;
                        break;
                    case "PATCH":
                        requestSpec = webClient.patch().uri(endpoint);
                        break;
                    default:
                        throw new IllegalArgumentException("Unsupported HTTP method: " + method);
                }

                if (requestSpec != null && !"DELETE".equalsIgnoreCase(method)) {
                    if (parameters != null && !parameters.isEmpty()) {
                        requestSpec.contentType(MediaType.APPLICATION_JSON);
                        headersSpec = requestSpec.body(Mono.just(parameters), Map.class);
                    } else {
                        headersSpec = requestSpec;
                    }
                }
            }

            if (headersSpec != null) {
                headersSpec = headersSpec.header(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);
            }

            WebClient.ResponseSpec responseSpec = headersSpec.retrieve();

            Mono<String> responseMono = responseSpec
                    .toEntity(String.class)
                    .map(entity -> {
                        Map<String, Object> response = new HashMap<>();
                        response.put("statusCode", entity.getStatusCode().value());
                        response.put("headers", entity.getHeaders().toSingleValueMap());

                        String body = entity.getBody();
                        try {
                            Object jsonBody = objectMapper.readValue(body, Object.class);
                            body = objectMapper.writeValueAsString(jsonBody);
                        } catch (Exception e) {
                        }
                        response.put("body", body);
                        response.put("success", true);
                        return response;
                    })
                    .onErrorResume(error -> {
                        Map<String, Object> errorResponse = new HashMap<>();
                        errorResponse.put("success", false);
                        errorResponse.put("error", error.getMessage());
                        return Mono.just(errorResponse);
                    })
                    .map(response -> {
                        try {
                            return objectMapper.writeValueAsString(response);
                        } catch (Exception e) {
                            return "{\"error\":\"" + e.getMessage() + "\"}";
                        }
                    });

            String jsonResponse = responseMono.block();
            result = objectMapper.readValue(jsonResponse, Map.class);

        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }
}