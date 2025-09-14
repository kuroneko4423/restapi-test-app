package com.example.restapitester.controller;

import com.example.restapitester.service.ApiTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class ApiTestController {

    @Autowired
    private ApiTestService apiTestService;

    @PostMapping("/test")
    public ResponseEntity<Map<String, Object>> testApi(@RequestBody Map<String, Object> request) {
        String endpoint = (String) request.get("endpoint");
        String method = (String) request.get("method");
        @SuppressWarnings("unchecked")
        Map<String, String> parameters = (Map<String, String>) request.get("parameters");

        Map<String, Object> response = apiTestService.makeApiRequest(endpoint, method, parameters);
        return ResponseEntity.ok(response);
    }
}