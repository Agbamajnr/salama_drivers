import 'package:dartz/dartz.dart';
import 'package:salama_users/data/models/subscriptions/subscribe_model.dart';
import 'package:salama_users/domain/entities/subscriptions/address.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/entities/subscriptions/report.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';
import '../../../core/exception/__export.dart';

abstract class SubscriptionsRepository {
  Future<Either<Failure, void>> createSubscription({
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, List<Subscription>>> fetchSubscriptions({
    required int? page,
    required int? perPage,
  });
  Future<Either<Failure, List<Subscription>>> fetchUserSubscriptions({
    required int? page,
    required int? perPage,
  });
  Future<Either<Failure, List<Booking>>> fetchBookings({
    required int? page,
    required int? perPage,
  });
  Future<Either<Failure, Booking>> fetchSingleBooking(
      {required String bookingId});
  Future<Either<Failure, Booking>> fetchActiveBooking(
      {required String rideStatus});
  Future<Either<Failure, void>> acceptRide({required String bookingId});
  Future<Either<Failure, void>> cancelBooking({
    required String bookingId,
  });
  Future<Either<Failure, void>> startBooking({
    required String bookingId,
  });
  Future<Either<Failure, void>> completeBooking({
    required String bookingId,
  });
  Future<Either<Failure, void>> reportBooking(
      {required String bookingId, required String message});

  Future<Either<Failure, void>> updateReport(
      {required String bookingId, required String status});
  Future<Either<Failure, List<Report>>> fetchReport({
    required int? page,
    required int? perPage,
  });
  Future<Either<Failure, List<Address>>> fetchAddressFromCoordinate(
      {required double longitude,
      required double latitude,
      required double radius});

  Future<Either<Failure, PaystackData>> subscribe({required String planId});
}
