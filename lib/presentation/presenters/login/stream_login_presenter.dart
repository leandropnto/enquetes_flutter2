import 'dart:async';

import '../../protocols/protocols.dart';
import '../login/login.dart';

class StreamLoginPresenter {
  final Validation _validation;
  final StreamController<LoginState> _controller =
      StreamController<LoginState>.broadcast();

  var _state = const LoginState(emailError: null);

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({required Validation validation})
      : _validation = validation;

  void validateEmail(String email) {
    _state = LoginState(
      emailError: _validation.validate(field: 'email', value: email),
    );

    _controller.add(_state);
  }

  void dispose() {
    _controller.close();
  }
}
