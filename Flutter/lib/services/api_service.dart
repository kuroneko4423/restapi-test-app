import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> makeApiRequest({
    required String endpoint,
    required String method,
    required Map<String, String> parameters,
  }) async {
    try {
      Uri uri;
      http.Response response;
      Map<String, String> headers = {
        'Accept': 'application/json',
      };

      if (method.toUpperCase() == 'GET') {
        uri = Uri.parse(endpoint).replace(queryParameters: parameters.isEmpty ? null : parameters);

        switch (method.toUpperCase()) {
          case 'GET':
            response = await http.get(uri, headers: headers);
            break;
          default:
            throw Exception('Invalid method for GET request');
        }
      } else {
        uri = Uri.parse(endpoint);

        if (parameters.isNotEmpty) {
          headers['Content-Type'] = 'application/json';
        }

        String? body = parameters.isEmpty ? null : jsonEncode(parameters);

        switch (method.toUpperCase()) {
          case 'POST':
            response = await http.post(uri, headers: headers, body: body);
            break;
          case 'PUT':
            response = await http.put(uri, headers: headers, body: body);
            break;
          case 'DELETE':
            response = await http.delete(uri, headers: headers, body: body);
            break;
          case 'PATCH':
            response = await http.patch(uri, headers: headers, body: body);
            break;
          default:
            throw Exception('Unsupported HTTP method: $method');
        }
      }

      String formattedBody = response.body;
      try {
        final jsonResponse = jsonDecode(response.body);
        formattedBody = const JsonEncoder.withIndent('  ').convert(jsonResponse);
      } catch (e) {
      }

      return {
        'success': true,
        'statusCode': response.statusCode,
        'headers': response.headers,
        'body': formattedBody,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}