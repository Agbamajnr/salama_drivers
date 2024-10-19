import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';


@lazySingleton
class AcceptRideUsecase extends Usecase<void, AcceptRideUsecaseParams> {
  AcceptRideUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    AcceptRideUsecaseParams params,
  ) =>
      repository.acceptRide(bookingId: params.bookingId);
}

class AcceptRideUsecaseParams {
  final String bookingId;

  AcceptRideUsecaseParams({required this.bookingId});
}

