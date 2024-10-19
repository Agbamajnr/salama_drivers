import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/report.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchReportUsecase
    extends Usecase<List<Report>, FetchReportUsecaseParams> {
  FetchReportUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, List<Report>>> call(
    FetchReportUsecaseParams params,
  ) =>
      repository.fetchReport(
        page: params.page,
        perPage: params.perPage,
      );
}

class FetchReportUsecaseParams {
  FetchReportUsecaseParams({
    this.page,
    this.perPage,
  });

  final int? page;
  final int? perPage;
}
