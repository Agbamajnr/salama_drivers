import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/data/models/subscriptions/subscribe_model.dart';
import 'package:salama_users/domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../../core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';

@lazySingleton
class SubscribeUsecase extends Usecase<PaystackData, SubscribeUsecaseParams> {
  SubscribeUsecase({
    required this.repository,
  });

  final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, PaystackData>> call(
    SubscribeUsecaseParams params,
  ) =>
      repository.subscribe(planId: params.planId);
}

class SubscribeUsecaseParams {
  final String planId;

  SubscribeUsecaseParams({required this.planId});
}
