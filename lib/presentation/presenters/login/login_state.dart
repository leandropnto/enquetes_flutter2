import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? email;
  final String? password;

  final String? emailError;
  final String? passwordError;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;

  const LoginState({
    this.emailError,
    this.passwordError,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [emailError, isFormValid, passwordError];

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
