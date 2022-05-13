import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../failures/failures.dart';

abstract class Authentication {
  Future<Either<AuthenticationFailure, AccountEntity>> auth({
    required AuthenticationParams params,
  });
}

class AuthenticationParams {
  final String email;
  final String secret;

  const AuthenticationParams({required this.email, required this.secret});
}