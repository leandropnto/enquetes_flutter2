import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/infra/http/http.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements http.Client {
  When mockPostCall() => when(() =>
      post(any(), body: any(named: 'body'), headers: any(named: 'headers')));

  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => http.Response(body, statusCode));

  void mockPostError() => when(() => mockPostCall().thenThrow(Exception()));
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

  group('shared', () {
    test('Should throws ServerError if invalid method is provided', () async {
      final url = faker.internet.httpUrl();

      final future = sut.request(url: url, method: 'invalid_method');

      expect(future, throwsA(HttpError.serverError));
    });
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

    test('Should return BadRequestError if posts returns 400', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return ServerError if posts returns 500', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(500);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return unauthorized if posts returns 401', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(401);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return forbidden if posts returns 403', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(403);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return not found if posts returns 404', () async {
      final url = faker.internet.httpUrl();
      client.mockPost(404);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return server error if post throws', () async {
      final url = faker.internet.httpUrl();
      client.mockPostError();

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
