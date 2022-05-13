import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/data/usecases/usecases.dart';
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
//void mockRequestError(HttpError error) => this.mockRequestCall().thenThrow(error);
}

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;

  setUp(() {
    httpClient = HttpClientSpy();
    httpClient.mockRequest();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    await sut.auth(params);

    verify(
      () => httpClient.request(url: url, method: 'post', body: params.toJson()),
    );
  });
}
