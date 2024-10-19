// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'],
      riderId: json['riderId'],
      driverId: json['driverId'],
      riderFromAddress: json['riderFromAddress'],
      riderToAddress: json['riderToAddress'],
      riderToLong: json['riderToLong'],
      riderFromLong: json['riderFromLong'],
      rideStatus: json['rideStatus'],
      driverLongitude: json['driverLongitude'],
      amount: json['amount'],
      driverLatitude: json['driverLatitude'],
      user: json['user'],
      driver: json['driver'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'riderId': instance.riderId,
      'driverId': instance.driverId,
      'riderFromAddress': instance.riderFromAddress,
      'riderToAddress': instance.riderToAddress,
      'riderToLong': instance.riderToLong,
      'riderFromLong': instance.riderFromLong,
      'rideStatus': instance.rideStatus,
      'driverLongitude': instance.driverLongitude,
      'amount': instance.amount,
      'driverLatitude': instance.driverLatitude,
      'user': instance.user,
      'driver': instance.driver,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
