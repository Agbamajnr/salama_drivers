// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      userId: json['userId'] as String,
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      email: json['email'],
      phone: json['phone'],
      firebaseToken: json['firebaseToken'],
      isVerified: json['isVerified'],
      longitude: json['longitude'],
      country: json['country'],
      profileImage: json['profileImage'],
      rideStatus: json['rideStatus'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'middleName': instance.middleName,
      'email': instance.email,
      'phone': instance.phone,
      'firebaseToken': instance.firebaseToken,
      'isVerified': instance.isVerified,
      'longitude': instance.longitude,
      'country': instance.country,
      'profileImage': instance.profileImage,
      'rideStatus': instance.rideStatus,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt,
    };
