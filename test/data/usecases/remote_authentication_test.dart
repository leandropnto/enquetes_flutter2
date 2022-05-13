import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({required String url, required String method});
}

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall() => when(() => request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        /*body: any(named: 'body'),
      headers: any(named: 'headers')*/
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
    await sut.auth();

    verify(() => httpClient.request(url: url, method: 'post'));
  });
}
