import 'package:injectable/injectable.dart';

import '../../../core/usecase/usecase.dart';
import '../../entities/auth/person.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class GetSavedUserUsecase extends Usecase<Person, NoParams> {
  GetSavedUserUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Person?> call(
    NoParams params,
  ) =>
      authRepository.getSavedUser();
}
