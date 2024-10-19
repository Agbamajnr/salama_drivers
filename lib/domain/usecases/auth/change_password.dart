import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

@lazySingleton
class ChangePasswordUsecase
    extends Usecase<String, ChangePasswordUsecaseParams> {
  ChangePasswordUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(
    ChangePasswordUsecaseParams params,
  ) =>
      repository.changePassword(
          password: params.password,
          rePassword: params.rePassword,
          otp: params.otp);
}

class ChangePasswordUsecaseParams {
  ChangePasswordUsecaseParams(
      {required this.password, required this.rePassword, required this.otp});

  final String password;
  final String rePassword;
  final String otp;
}
