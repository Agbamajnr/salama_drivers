import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchActivebookingUsecase
    extends Usecase<Booking, FetchActiveBookingUsecaseParams> {
  FetchActivebookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, Booking>> call(
    FetchActiveBookingUsecaseParams params,
  ) =>
      repository.fetchActiveBooking(rideStatus: params.rideStatus);
}

class FetchActiveBookingUsecaseParams {
  FetchActiveBookingUsecaseParams({
    required this.rideStatus,
  });

  final String rideStatus;
}
