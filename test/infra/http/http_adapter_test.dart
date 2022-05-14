import 'dart:convert';

import 'package:enquetes/data/http/http.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements http.Client {
  When mockPostCall() => when(() =>
      post(any(), body: any(named: 'body'), headers: any(named: 'headers')));

  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => http.Response(body, statusCode));
}

class HttpAdapter implements HttpClient {
  final http.Client client;

  HttpAdapter({required this.client});

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    final headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    switch (response.statusCode) {
      case 200:
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      case 204:
        return null;
      default:
        return response.body;
    }
  }
}

main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });
  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client: client);
  });

  group('post', () {
    test('Should call post with correct values', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(200);

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        () => client.post(
          Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: '{"any_key":"any_value"}',
        ),
      );
    });

    test('Should call post without body', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(200);

      await sut.request(url: url, method: 'post');

      verify(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
        ),
      );
    });

    test('Should return data if post returns 200', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(200);

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if posts returns 200 without data', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('Should return null if posts returns 204 with data', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
