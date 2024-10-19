import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:salama_users/data/models/subscriptions/address_model.dart';
import 'package:salama_users/data/models/subscriptions/booking_model.dart';
import 'package:salama_users/data/models/subscriptions/report_model.dart';
import 'package:salama_users/data/models/subscriptions/subscription_model.dart';
import '../../../core/exception/__export.dart';
import '../../../core/local_storage/__export.dart';
import '../../../domain/repositories/subscriptions/subscriptions_repository.dart';
import '../../datasources/subscriptions/subscriptions_remote_datasource.dart';

@LazySingleton(as: SubscriptionsRepository)
class SubscriptionRepositoryImpl implements SubscriptionsRepository {
  final SecureStorage secureStorage;
  final SubscriptionsRemoteDatasource remoteDatasource;

  SubscriptionRepositoryImpl({
    required this.secureStorage,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, void>> createSubscription(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await remoteDatasource.createSubscription(data: data);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionModel>>> fetchSubscriptions({
    required int? page,
    required int? perPage,
  }) async {
    try {
      final response = await remoteDatasource.fetchSubscriptions(
        page: page,
        perPage: perPage,
      );

      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionModel>>> fetchUserSubscriptions({
    required int? page,
    required int? perPage,
  }) async {
    try {
      final response = await remoteDatasource.fetchUserSubscriptions(
        page: page,
        perPage: perPage,
      );

      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> acceptRide(
      {required String bookingId}) async {
    try {
      final response = await remoteDatasource.acceptRide(bookingId: bookingId);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> fetchBookings({
    required int? page,
    required int? perPage,
  }) async {
    try {
      final response = await remoteDatasource.fetchBookings(
        page: page,
        perPage: perPage,
      );

      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, BookingModel>> fetchSingleBooking(
      {required String bookingId}) async {
    try {
      final response =
          await remoteDatasource.fetchSingleBooking(bookingId: bookingId);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }
  @override
  Future<Either<Failure, BookingModel>> fetchActiveBooking(
      {required String rideStatus}) async {
    try {
      final response =
          await remoteDatasource.fetchActiveBooking(rideStatus: rideStatus);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }
  @override
  Future<Either<Failure, void>> cancelBooking({
    required String bookingId,
  }) async {
    try {
      final response =
          await remoteDatasource.cancelBooking(bookingId: bookingId);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> startBooking({
    required String bookingId,
  }) async {
    try {
      final response =
          await remoteDatasource.startBooking(bookingId: bookingId);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> completeBooking({
    required String bookingId,
  }) async {
    try {
      final response =
          await remoteDatasource.completeBooking(bookingId: bookingId);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reportBooking(
      {required String bookingId, required String message}) async {
    try {
      final response = await remoteDatasource.reportBooking(
          bookingId: bookingId, message: message);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateReport(
      {required String bookingId, required String status}) async {
    try {
      final response = await remoteDatasource.updateReport(
          bookingId: bookingId, status: status);
      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, List<ReportModel>>> fetchReport({
    required int? page,
    required int? perPage,
  }) async {
    try {
      final response = await remoteDatasource.fetchReport(
        page: page,
        perPage: perPage,
      );

      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> fetchAddressFromCoordinate(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    try {
      final response = await remoteDatasource.fetchAddressFromCoordinate(
          longitude: longitude, latitude: latitude, radius: radius);

      return Right(response);
    } catch (e) {
      return Left(
        ExceptionHandler.networkError(e),
      );
    }
  }
}
