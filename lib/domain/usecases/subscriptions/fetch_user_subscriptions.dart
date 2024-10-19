import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class FetchUserSubscriptionUsecase
    extends Usecase<List<Subscription>, FetchUserSubscriptionUsecaseParams> {
  FetchUserSubscriptionUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, List<Subscription>>> call(
    FetchUserSubscriptionUsecaseParams params,
  ) =>
      repository.fetchUserSubscriptions(
        page: params.page,
        perPage: params.perPage,
      );
}

class FetchUserSubscriptionUsecaseParams {
  FetchUserSubscriptionUsecaseParams({
    this.page,
    this.perPage,
  });

  final int? page;
  final int? perPage;
}
