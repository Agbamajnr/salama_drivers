import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchBookingUsecase
    extends Usecase<List<Booking>, FetchBookingUsecaseParams> {
  FetchBookingUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, List<Booking>>> call(
    FetchBookingUsecaseParams params,
  ) =>
      repository.fetchBookings(
        page: params.page,
        perPage: params.perPage,
      );
}

class FetchBookingUsecaseParams {
  FetchBookingUsecaseParams({
    this.page,
    this.perPage,
  });

  final int? page;
  final int? perPage;
}
