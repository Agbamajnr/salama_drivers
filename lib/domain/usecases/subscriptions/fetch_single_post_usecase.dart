import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';

import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';


@lazySingleton
class FetchSinglebookingUsecase extends Usecase<Booking, FetchSingleBookingUsecaseParams> {
  FetchSinglebookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, Booking>> call(
    FetchSingleBookingUsecaseParams params,
  ) =>
      repository.fetchSingleBooking(
  
bookingId: params.bookingId
      );
}

class FetchSingleBookingUsecaseParams {
  FetchSingleBookingUsecaseParams({
  
   required this.bookingId,
  });


  final String bookingId;
}