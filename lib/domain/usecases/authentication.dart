import 'package:dartz/dartz.dart';

import '../entities/entities.dart';
import '../failures/failures.dart';

abstract class Authentication {
  Future<Either<AuthenticationFailure, AccountEntity>> auth({
    required String email,
    required String password,
  });
}
