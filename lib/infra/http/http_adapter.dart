import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final http.Client client;

  HttpAdapter({required this.client});

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    try {
      final headers = {
        "content-type": "application/json",
        "accept": "application/json",
      };

      final jsonBody = body != null ? jsonEncode(body) : null;

      final response = await _handleMethod(
          method: method, url: url, headers: headers, body: jsonBody);

      return _handleResponse(response);
    } on Exception catch (_) {
      throw HttpError.serverError;
    }
  }

  Future<http.Response> _handleMethod(
      {required String method,
      required String url,
      required Map<String, String> headers,
      String? body}) async {
    switch (method) {
      case 'post':
        return await client.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
      default:
        return http.Response('', 500);
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 500:
        throw HttpError.serverError;
      default:
        throw HttpError.serverError;
    }
  }
}
