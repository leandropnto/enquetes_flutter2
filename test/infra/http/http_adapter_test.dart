import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {
  When mockPostCall() => when(() => this
      .post(any(), body: any(named: 'body'), headers: any(named: 'headers')));

  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => Response(body, statusCode));
}

class HttpAdapter {
  final Client client;

  HttpAdapter({required this.client});

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

    client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );
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
  });
}
