import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';


@lazySingleton
class CancelBookingUsecase extends Usecase<void, CancelBookingUsecaseParams> {
  CancelBookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    CancelBookingUsecaseParams params,
  ) =>
      repository.cancelBooking(bookingId: params.bookingId);
}

class CancelBookingUsecaseParams {
  final String bookingId;

  CancelBookingUsecaseParams({required this.bookingId});
}
