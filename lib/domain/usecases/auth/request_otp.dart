import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class RequestOTPUsecase extends Usecase<String, String> {
  RequestOTPUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(
    String params,
  ) =>
      authRepository.requestOTP(email: params);
}
