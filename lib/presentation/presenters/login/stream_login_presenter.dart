import 'dart:async';

import '../../protocols/protocols.dart';
import '../login/login.dart';

class StreamLoginPresenter {
  final Validation _validation;
  final StreamController<LoginState> _controller =
      StreamController<LoginState>.broadcast();

  var _state = const LoginState(emailError: null);

  set state(LoginState value) {
    _state = value;
    _controller.add(_state);
  }

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String?> get passwordStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({required Validation validation})
      : _validation = validation;

  void validateEmail(String email) {
    state = _state.copyWith(
      email: email,
      emailError: _validation.validate(
        field: 'email',
        value: email,
      ),
    );
  }

  void validatePassword(String password) {
    state = _state.copyWith(
        password: password,
        passwordError:
            _validation.validate(field: 'password', value: password));
  }

  void dispose() {
    _controller.close();
  }
}
