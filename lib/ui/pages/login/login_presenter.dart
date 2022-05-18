abstract class LoginPresenter {
  Stream<String> get emailErrorStream;

  Stream<String> get passwordErrorStream;

  Stream<String> get mainErrorStream;

  Stream<bool> get isFormValidStream;

  Stream<bool> get isLoadingStream;

  void validateEmail(String value);

  void validatePassword(String value);

  void auth();

  void dispose();
}
