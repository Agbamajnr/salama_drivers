import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/auth/person.dart';
import '../../repositories/auth/auth_repository.dart';

@lazySingleton
class LoginUsecase extends Usecase<Person, LoginUsecaseParams> {
  LoginUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Person>> call(
    LoginUsecaseParams params,
  ) =>
      authRepository.login(
          email: params.email, password: params.password, device: params.device);
}

class LoginUsecaseParams {
  LoginUsecaseParams({
    required this.email,
    required this.password,
    required this.device
  });

  final String email;
  final String password;
  final String device;
}
