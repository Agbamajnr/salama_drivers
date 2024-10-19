import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class DeleteUserUsecase extends Usecase<void, NoParams> {
  DeleteUserUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call(
    NoParams params,
  ) =>
      authRepository.deleteUser();
}
