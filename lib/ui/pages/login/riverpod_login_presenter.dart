import 'package:enquetes/ui/pages/pages.dart';

class RiverPodLoginPresenter implements LoginPresenter {
  @override
  Future<void> auth() {
    // TODO: implement auth
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement emailErrorStream
  Stream<String> get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  // TODO: implement mainErrorStream
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<String> get passwordErrorStream => throw UnimplementedError();

  @override
  void validateEmail(String value) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String value) {
    // TODO: implement validatePassword
  }

  const RiverPodLoginPresenter();
}
