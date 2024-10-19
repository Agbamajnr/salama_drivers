import 'package:injectable/injectable.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class LogoutUsecase extends Usecase<void, NoParams> {
  LogoutUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> call(
    NoParams params,
  ) =>
      authRepository.logout();
}
