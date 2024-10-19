import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';


@lazySingleton
class GetCurrentPositionUsecase extends Usecase<Position?, NoParams> {
  GetCurrentPositionUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<Position?> call(
    NoParams params,
  ) =>
      authRepository.getCurrentPosition();
}
