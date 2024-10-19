import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class ReportBookingUsecase extends Usecase<void, ReportBookingUsecaseParams> {
  ReportBookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    ReportBookingUsecaseParams params,
  ) =>
      repository.reportBooking(bookingId: params.bookingId, message: params.message);
}

class ReportBookingUsecaseParams {
  final String bookingId;
  final String message;

  ReportBookingUsecaseParams({required this.bookingId, required this.message});
}
