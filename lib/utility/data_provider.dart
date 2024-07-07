import 'dart:convert';
import 'package:http/http.dart' as http;

class DataProvider {
  static Future<http.Response> getRequest({required String endpoint}) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> putRequest({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
