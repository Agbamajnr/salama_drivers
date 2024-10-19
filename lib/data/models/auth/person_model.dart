import 'package:json_annotation/json_annotation.dart';
import 'package:salama_users/domain/entities/auth/person.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel extends Person {
  const PersonModel({
   required super.userId,
   required super.firstName,
   required super.lastName,
   required super.middleName,
   required super.email,
   required super.phone,
   required super.firebaseToken,
   required super.isVerified,
   required super.longitude,
   required super.country,
   required super.profileImage,
   required super.rideStatus,
   required super.isActive,
   required super.createdAt
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      _$PersonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
