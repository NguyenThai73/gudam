// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
///
import 'dart:convert';

import 'package:http/http.dart' as http;

const String host = 'http://192.168.1.68:8080/api';

class BaseService {
  Future<T?> get<T>({required String route, T Function(Map<String, dynamic>?)? onConvert, Map<String, String>? headers, int? timeout}) async {
    var client = http.Client();
    print("url get: $host/$route");
    Map<String, String> headers123 = {'Content-Type': 'application/json'};
    try {
      var response = await client.get(Uri.parse('$host/$route'), headers: headers123).timeout(Duration(seconds: timeout ?? 10));
      print("response: ${response.statusCode}");
      print("response: ${response.body}");
      if (onConvert == null) return response.statusCode as T;
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return onConvert(decodedResponse);
    } catch (e) {
      print('BaseService get ${route} $e');
    } finally {
      client.close();
    }
    return null;
  }

  Future<T?> post<T>(
      {required String api, T Function(Map<String, dynamic>?)? onConvert, Map<String, String>? headers, int? timeout, required Map body}) async {
    var client = http.Client();
    try {
      print("url post: $host/$api");
      print("request: $body");
      Map<String, String> headers = {'Content-Type': 'application/json'};
      var response = await client
          .post(
            Uri.parse('$host/$api'),
            body: json.encode(body),
            headers: headers,
          )
          .timeout(Duration(seconds: timeout ?? 10));
      print("response: ${response.statusCode}");
      print("response: ${response.body}");

      if (onConvert == null) {
        return (response.statusCode >= 200 && response.statusCode < 300) as T;
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return onConvert(decodedResponse);
    } catch (e) {
      print('BaseService post $e');
    } finally {
      client.close();
    }
    return null;
  }

  Future<T?> delete<T>(
      {required String api, T Function(Map<String, dynamic>?)? onConvert, Map<String, String>? headers, int? timeout, Map? body}) async {
    var client = http.Client();
    try {
      print("url get: $host/$api");
      var response = await client.delete(Uri.parse('$host/$api'), headers: headers).timeout(Duration(seconds: timeout ?? 10));
      print("response: ${response.body}");
      if (onConvert == null) {
        return (response.statusCode >= 200 && response.statusCode < 300) as T;
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return onConvert(decodedResponse);
    } catch (e) {
      print('BaseService post $e');
      rethrow;
    } finally {
      client.close();
    }
  }


  Future<T?> put<T>(
      {required String api, T Function(Map<String, dynamic>?)? onConvert, Map<String, String>? headers, int? timeout, required Map body}) async {
    var client = http.Client();
    try {
      print("url post: $host/$api");
      print("request: $body");
      Map<String, String> headers = {'Content-Type': 'application/json'};
      var response = await client
          .put(
            Uri.parse('$host/$api'),
            body: json.encode(body),
            headers: headers,
          )
          .timeout(Duration(seconds: timeout ?? 10));
      print("response: ${response.statusCode}");
      print("response: ${response.body}");

      if (onConvert == null) {
        return (response.statusCode >= 200 && response.statusCode < 300) as T;
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return onConvert(decodedResponse);
    } catch (e) {
      print('BaseService post $e');
    } finally {
      client.close();
    }
    return null;
  }
}
