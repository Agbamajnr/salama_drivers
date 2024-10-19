// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      longitude: json['longitude'],
      latitude: json['latitude'],
      address: json['address'],
      country: json['country'],
      distance: json['distance'],
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'country': instance.country,
      'distance': instance.distance,
    };
