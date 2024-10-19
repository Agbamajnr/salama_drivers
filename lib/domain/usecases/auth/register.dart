import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/auth/person.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class RegisterUsecase extends Usecase<Person, Map<String, dynamic>> {
  RegisterUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Person>> call(
    Map<String, dynamic> params,
  ) =>
      authRepository.register(data: params);
}
