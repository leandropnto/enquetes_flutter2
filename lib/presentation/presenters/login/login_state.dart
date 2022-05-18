import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? emailError;

  const LoginState({this.emailError});

  @override
  List<Object?> get props => [emailError];
}
