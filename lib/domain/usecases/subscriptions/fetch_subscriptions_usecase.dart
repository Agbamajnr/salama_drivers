import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchSubscriptionUsecase
    extends Usecase<List<Subscription>, FetchSubscriptionUsecaseParams> {
  FetchSubscriptionUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, List<Subscription>>> call(
    FetchSubscriptionUsecaseParams params,
  ) =>
      repository.fetchSubscriptions(
        page: params.page,
        perPage: params.perPage,
      );
}

class FetchSubscriptionUsecaseParams {
  FetchSubscriptionUsecaseParams({
    this.page,
    this.perPage,
  });

  final int? page;
  final int? perPage;
}
