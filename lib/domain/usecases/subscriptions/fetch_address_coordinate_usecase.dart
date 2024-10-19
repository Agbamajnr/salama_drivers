import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/address.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchAddressCoordinateUsecase
    extends Usecase<List<Address>, FetchAddressCoordinateUsecaseParams> {
  FetchAddressCoordinateUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, List<Address>>> call(
    FetchAddressCoordinateUsecaseParams params,
  ) =>
      repository.fetchAddressFromCoordinate(
        latitude: params.latitude,
        longitude: params.longitude,
        radius: params.radius
      );
}

class FetchAddressCoordinateUsecaseParams {
  FetchAddressCoordinateUsecaseParams({
    required this.latitude,
    required this.longitude,
    required this.radius
  });

  final double longitude;
  final double latitude;
  final double radius;
}
