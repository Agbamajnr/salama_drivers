import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/subscriptions/subscription.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel extends Subscription {
  const SubscriptionModel({
    required super.id,
    required super.title,
    required super.description,
    required super.amount,
    required super.tenor,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}
