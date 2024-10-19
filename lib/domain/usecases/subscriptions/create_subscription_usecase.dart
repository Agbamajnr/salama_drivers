import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/core/exception/__export.dart';
import '../../../core/usecase/usecase.dart';
import '../../repositories/subscriptions/subscriptions_repository.dart';


@lazySingleton
class CreateSubscriptionUsecase extends Usecase<void, Map<String, dynamic>> {
  CreateSubscriptionUsecase({
    required this.repository,
  });

   final SubscriptionsRepository repository;

  @override
  Future<Either<Failure, void>> call(
    Map<String, dynamic> params,
  ) =>
      repository.createSubscription(data: params);
}
