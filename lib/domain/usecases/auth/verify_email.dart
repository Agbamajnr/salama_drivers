import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

@lazySingleton
class VerifyEmailUsecase extends Usecase<void, VerifyEmailUsecaseParams> {
  VerifyEmailUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(
    VerifyEmailUsecaseParams params,
  ) =>
      authRepository.verifyEmail(otp: params.otp, email: params.email);
}

class VerifyEmailUsecaseParams {
  final String otp;
  final String email;

  VerifyEmailUsecaseParams({
    required this.otp,
    required this.email,
  });
}
