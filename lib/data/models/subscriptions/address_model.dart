import 'package:json_annotation/json_annotation.dart';
import 'package:salama_users/domain/entities/subscriptions/address.dart';


part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Address {
  const AddressModel({
   required super.longitude,
   required super.latitude,
   required super.address,
   required super.country, required super.distance

  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
