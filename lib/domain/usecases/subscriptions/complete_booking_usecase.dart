import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';


@lazySingleton
class CompleteBookingUsecase extends Usecase<void, CompleteBookingUsecaseParams> {
  CompleteBookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    CompleteBookingUsecaseParams params,
  ) =>
      repository.completeBooking(bookingId: params.bookingId);
}

class CompleteBookingUsecaseParams {
  final String bookingId;

  CompleteBookingUsecaseParams({required this.bookingId});
}
