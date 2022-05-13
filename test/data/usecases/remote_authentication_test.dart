import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/domain/helpers/helpers.dart';
import 'package:enquetes/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        /*headers: any(named: 'headers')*/
      ));

  //void mockRequest() => mockRequestCall().thenAnswer((invocation) async {});

  void mockRequest(dynamic data) =>
      mockRequestCall().thenAnswer((_) async => data);

  void mockRequestError(HttpError error) => mockRequestCall().thenThrow(error);
}

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;
  late AuthenticationParams params;
  late String token;
  late String name;
  late Map result;

  setUp(() {
    httpClient = HttpClientSpy();
    token = faker.guid.guid();
    name = faker.person.name();
    result = {'accessToken': token, 'name': name};
    httpClient.mockRequest(result);

    params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );

    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {

    await sut.auth(params);

    verify(
      () => httpClient.request(
          url: url,
          method: 'post',
          body: RemoteAuthenticationParams.fromDomain(params).toJson()),
    );
  });

  test('Should throw Unexpected error if httpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));

  });

  test('Should throw Unexpected error if httpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));

  });

  test('Should throw Unexpected error if httpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw Unexpected error if httpClient returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return a account when HttpClient returns 200', () async {
    httpClient.mockRequest(result);

    final account = await sut.auth(params);
    expect(account.token, token);
  });

  test(
      'Should throws UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest({'invalid_key': 'invalid_data'});

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
