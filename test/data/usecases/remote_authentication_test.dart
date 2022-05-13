import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/domain/helpers/helpers.dart';
import 'package:enquetes/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        /*headers: any(named: 'headers')*/
      ));

  void mockRequest() => mockRequestCall().thenAnswer((invocation) async {});

//void mockRequest(dynamic data) => mockRequestCall().thenAnswer((_) async => data);
  void mockRequestError(HttpError error) => mockRequestCall().thenThrow(error);
}

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;
  late AuthenticationParams params;

  setUp(() {
    httpClient = HttpClientSpy();
    httpClient.mockRequest();

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

}
