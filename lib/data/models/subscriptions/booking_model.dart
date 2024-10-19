import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/subscriptions/booking.dart';


part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.riderId,
    required super.driverId,
    required super.riderFromAddress,
    required super.riderToAddress,
    required super.riderToLong,
    required super.riderFromLong,
    required super.rideStatus,
    required super.driverLongitude,
    required super.amount,
    required super.driverLatitude,
    required super.user,
    required super.driver,
    required super.startTime,
    required super.endTime,
    required super.createdAt,
    required super.updatedAt,

  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
