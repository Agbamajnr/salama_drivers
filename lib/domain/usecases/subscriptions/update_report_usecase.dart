import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class UpdateReportUsecase extends Usecase<void, UpdateReportUsecaseParams> {
  UpdateReportUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    UpdateReportUsecaseParams params,
  ) =>
      repository.updateReport(bookingId: params.bookingId, status: params.status);
}

class UpdateReportUsecaseParams {
  final String bookingId;
  final String status;

  UpdateReportUsecaseParams({required this.bookingId, required this.status});
}
