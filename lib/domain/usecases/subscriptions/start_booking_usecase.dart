import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';


@lazySingleton
class StartBookingUsecase extends Usecase<void, StartBookingUsecaseParams> {
  StartBookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    StartBookingUsecaseParams params,
  ) =>
      repository.startBooking(bookingId: params.bookingId);
}

class StartBookingUsecaseParams {
  final String bookingId;

  StartBookingUsecaseParams({required this.bookingId});
}
