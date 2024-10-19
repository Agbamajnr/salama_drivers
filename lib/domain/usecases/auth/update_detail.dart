import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/auth/auth_repository.dart';

@lazySingleton
class UpdateUserDetailUsecase
    extends Usecase<String, UpdateUserDetailUsecaseParams> {
  UpdateUserDetailUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(
    UpdateUserDetailUsecaseParams params,
  ) =>
      repository.updateUserDetails(
          firstName: params.firstName,
          lastName: params.lastName,
          middleName: params.middleName,
          firebaseToken: params.firebaseToken,
          longitude: params.longitude,
          latitude: params.latitude);
}

class UpdateUserDetailUsecaseParams {
  UpdateUserDetailUsecaseParams(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.firebaseToken,
      required this.longitude,
      required this.latitude});

  final String firstName;
  final String lastName;
  final String middleName;
  final String firebaseToken;
  final double longitude;
  final double latitude;
}
