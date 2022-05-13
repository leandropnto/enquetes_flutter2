import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required String url});
}

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall() => when(() => request(
      url: any(named: 'url'),
     /* method: any(named: 'method'),
      body: any(named: 'body'),
      headers: any(named: 'headers')*/
  ));
  void mockRequest() => mockRequestCall().thenAnswer((invocation) async {});
  //void mockRequest(dynamic data) => mockRequestCall().thenAnswer((_) async => data);
  //void mockRequestError(HttpError error) => this.mockRequestCall().thenThrow(error);
}

void main() {
  test('Should call HttpClient with correct URL', () async {
    final httpClient = HttpClientSpy();
    httpClient.mockRequest();
    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();
    
    verify(() => httpClient.request(url: url));
  });
}
