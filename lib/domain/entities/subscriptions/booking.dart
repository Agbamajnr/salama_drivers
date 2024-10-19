import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final dynamic id;
  final dynamic riderId;
  final dynamic driverId;
  final dynamic riderFromAddress;
  final dynamic riderToAddress;
  final dynamic riderToLong;
  final dynamic riderFromLong;
  final dynamic rideStatus;
  final dynamic driverLongitude;
  final dynamic amount;
  final dynamic driverLatitude;
  final dynamic user;
  final dynamic driver;
  final dynamic startTime;
  final dynamic endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Booking({
    required this.id,
    required this.riderId,
    required this.driverId,
    required this.riderFromAddress,
    required this.riderToAddress,
    required this.riderToLong,
    required this.riderFromLong,
    required this.rideStatus,
    required this.driverLongitude,
    required this.amount,
    required this.driverLatitude,
    required this.user,
    required this.driver,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        riderId,
        driverId,
        riderFromAddress,
        riderToAddress,
        riderToLong,
        riderFromLong,
        rideStatus,
        driverLongitude,
        amount,
        driverLatitude,
        startTime,
        endTime,
        createdAt,
        updatedAt
      ];
}
