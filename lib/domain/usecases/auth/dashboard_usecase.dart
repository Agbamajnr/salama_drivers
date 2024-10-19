import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

@lazySingleton
class DashboardUsecase
    extends Usecase<String, DashboardUsecaseParams> {
  DashboardUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(
    DashboardUsecaseParams params,
  ) =>
      repository.dashboard(
          isActive: params.isActive,
          firebaseToken: params.firebaseToken,
          longitude: params.longitude,
          latitude: params.latitude);
}

class DashboardUsecaseParams {
  DashboardUsecaseParams(
      {required this.isActive,
      required this.firebaseToken,
      required this.longitude,
      required this.latitude});

  final bool isActive;
  final String firebaseToken;
  final double longitude;
  final double latitude;
}
