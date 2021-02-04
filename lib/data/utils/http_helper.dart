import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sleep_seek_mobile/data/exceptions/api_exception.dart';

class HttpHelper {
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type,
      {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    Map<String, dynamic> responseBody;
    try {
      response = await _invoke(url, type,
          headers: headers, body: body, encoding: encoding);
    } catch (error) {
      rethrow;
    }
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type,
      {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    List<dynamic> responseBody;
    try {
      response = await _invoke(url, type,
          headers: headers, body: body, encoding: encoding);
    } on APIException {
      rethrow;
    } on SocketException {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<String> invokeHttp3(dynamic url, RequestType type,
      {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;
    String responseBody;
    try {
      response = await _invoke(url, type,
          headers: headers, body: body, encoding: encoding);
    } on APIException {
      rethrow;
    } on SocketException {
      rethrow;
    }

    responseBody = response.body;
    return responseBody;
  }

  static Future<http.Response> _invoke(dynamic url, RequestType type,
      {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['debugMessage']);
      }

      return response;
    } on http.ClientException {
      rethrow;
    } on SocketException catch (e) {
      throw Exception(e.osError.message);
    } catch (error) {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete }
