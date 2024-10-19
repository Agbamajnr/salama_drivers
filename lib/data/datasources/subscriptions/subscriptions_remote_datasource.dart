import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:salama_users/data/models/subscriptions/address_model.dart';
import 'package:salama_users/data/models/subscriptions/booking_model.dart';
import 'package:salama_users/data/models/subscriptions/report_model.dart';
import 'package:salama_users/data/models/subscriptions/subscription_model.dart';

import '../../../core/exception/__export.dart';
import '../../../core/local_storage/__export.dart';
import '../../../core/network/__export.dart';

abstract class SubscriptionsRemoteDatasource {
  Future<void> createSubscription({required Map<String, dynamic> data});
  Future<List<SubscriptionModel>> fetchSubscriptions({
    required int? page,
    required int? perPage,
  });
  Future<List<SubscriptionModel>> fetchUserSubscriptions({
    required int? page,
    required int? perPage,
  });
  Future<void> acceptRide({required String bookingId});
  Future<List<BookingModel>> fetchBookings({
    required int? page,
    required int? perPage,
  });
  Future<BookingModel> fetchSingleBooking({required String bookingId});
   Future<BookingModel> fetchActiveBooking({required String rideStatus});
  Future<void> cancelBooking({
    required String bookingId,
  });
  Future<void> startBooking({
    required String bookingId,
  });
  Future<void> completeBooking({
    required String bookingId,
  });
  Future<void> reportBooking(
      {required String bookingId, required String message});
  Future<void> updateReport(
      {required String bookingId, required String status});
  Future<List<ReportModel>> fetchReport({
    required int? page,
    required int? perPage,
  });
  Future<List<AddressModel>> fetchAddressFromCoordinate({
    required double longitude,
    required double latitude,
    required double radius,
  });
}

@LazySingleton(as: SubscriptionsRemoteDatasource)
class SubscriptionRemoteDatasourceImpl
    implements SubscriptionsRemoteDatasource {
  final HttpRequester httpRequester;
  final InternetConnection networkInfo;
  final SecureStorage secureStorage;

  SubscriptionRemoteDatasourceImpl({
    required this.httpRequester,
    required this.networkInfo,
    required this.secureStorage,
  }) {
    _setSessionToken();
  }

  String _sessionToken = '';
  void _setSessionToken() {
    if (_sessionToken.isEmpty) {
      int len = 50;
      var r = Random();
      const chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      _sessionToken =
          List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
    }
  }

  @override
  Future<void> createSubscription({required Map<String, dynamic> data}) async {
    if (await networkInfo.isConnected) {
      final response = await httpRequester.post(
        endpoint: '/taxi/subscriptions',
        body: data,
      );

      Logger().d(response.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<SubscriptionModel>> fetchSubscriptions({
    required int? page,
    required int? perPage,
  }) async {
    final token = await secureStorage.getToken();
    Logger().d(token);
    if (await networkInfo.isConnected) {
      var queryparams = <String, dynamic>{};
      if (page != null) {
        queryparams['page'] = page;
      }
      if (perPage != null) {
        queryparams['perPage'] = perPage;
      }

      final response = await httpRequester.getRequest(
        endpoint: '/taxi/subscriptions',
        token: (await secureStorage.getToken()),
      );

      Logger().d('${response.data} Subscription');
      print("Returned");
      return List<SubscriptionModel>.from((response.data['data'] as List)
          .map((x) => SubscriptionModel.fromJson(x)));
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<SubscriptionModel>> fetchUserSubscriptions({
    required int? page,
    required int? perPage,
  }) async {
    final token = await secureStorage.getToken();
    Logger().d(token);
    if (await networkInfo.isConnected) {
      var queryparams = <String, dynamic>{};
      if (page != null) {
        queryparams['page'] = page;
      }
      if (perPage != null) {
        queryparams['perPage'] = perPage;
      }

      final response = await httpRequester.getRequest(
        endpoint: '/taxi/subscriptions/user',
        token: (await secureStorage.getToken()),
      );

      Logger().d('${response.data} Subscription');
      return List<SubscriptionModel>.from((response.data['data'] as List)
          .map((x) => SubscriptionModel.fromJson(x)));
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<BookingModel>> fetchBookings({
    required int? page,
    required int? perPage,
  }) async {
    final token = await secureStorage.getToken();
    Logger().d(token);
    if (await networkInfo.isConnected) {
      var queryparams = <String, dynamic>{};
      if (page != null) {
        queryparams['page'] = page;
      }
      if (perPage != null) {
        queryparams['perPage'] = perPage;
      }

      final response = await httpRequester.getRequest(
        endpoint: '/taxi/booking',
        token: (await secureStorage.getToken()),
      );

      Logger().d(response.data);
      final data = response.data['data'] as Map<String, dynamic>;
      final rows = data['rows'] as List;
      return rows
          .map((x) => BookingModel.fromJson(x as Map<String, dynamic>))
          .toList();
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BookingModel> fetchSingleBooking({required String bookingId}) async {
    if (await networkInfo.isConnected) {
      final response = await httpRequester.getRequest(
        endpoint: '/taxi/booking/$bookingId',
        token: (await secureStorage.getToken()),
      );
      return BookingModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } else {
      throw NoInternetException();
    }
  }
  @override
  Future<BookingModel> fetchActiveBooking({required String rideStatus}) async {
    if (await networkInfo.isConnected) {
      final response = await httpRequester.getRequest(
        endpoint: '/taxi/booking/active/trip?bookingState=$rideStatus',
        token: (await secureStorage.getToken()),
      );
      return BookingModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> acceptRide({required String bookingId}) async {
    if (await networkInfo.isConnected) {
       final body = {
        "tripId": bookingId,
      };
      final response = await httpRequester.put(
        endpoint: '/taxi/booking/drivers/accept',
        body: body,
      );

      Logger().d(response.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> cancelBooking({
    required String bookingId,
  }) async {
    if (await networkInfo.isConnected) {
      final body = {
        "tripId": bookingId,
      };
      await httpRequester.put(
        endpoint: '/taxi/booking/drivers/decline',
        token: (await secureStorage.getToken()),
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> startBooking({
    required String bookingId,
  }) async {
    if (await networkInfo.isConnected) {
      final body = {
        "tripId": bookingId,
      };
      await httpRequester.put(
        endpoint: '/taxi/booking/drivers/start',
        token: (await secureStorage.getToken()),
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> completeBooking({
    required String bookingId,
  }) async {
    if (await networkInfo.isConnected) {
      final body = {
        "tripId": bookingId,
      };
      await httpRequester.put(
        endpoint: '/taxi/booking/drivers/complete',
        token: (await secureStorage.getToken()),
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> reportBooking(
      {required String bookingId, required String message}) async {
    if (await networkInfo.isConnected) {
      final body = {"tripId": bookingId, "message": message};
      await httpRequester.post(
        endpoint: '/taxi/booking/trip/report',
        token: (await secureStorage.getToken()),
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateReport(
      {required String bookingId, required String status}) async {
    if (await networkInfo.isConnected) {
      final body = {"tripId": bookingId, "status": status};
      await httpRequester.put(
        endpoint: '/taxi/booking/trip/report',
        token: (await secureStorage.getToken()),
        body: body,
      );
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<ReportModel>> fetchReport({
    required int? page,
    required int? perPage,
  }) async {
    final token = await secureStorage.getToken();
    Logger().d(token);
    if (await networkInfo.isConnected) {
      var queryparams = <String, dynamic>{};
      if (page != null) {
        queryparams['page'] = page;
      }
      if (perPage != null) {
        queryparams['perPage'] = perPage;
      }

      final response = await httpRequester.getRequest(
        endpoint: '/taxi/booking/trip/report',
        token: (await secureStorage.getToken()),
      );

      Logger().d(response.data);
      return List<ReportModel>.from(
          (response.data['data'] as List).map((x) => ReportModel.fromJson(x)));
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<AddressModel>> fetchAddressFromCoordinate({
    required double longitude,
    required double latitude,
    required double radius,
  }) async {
    if (await networkInfo.isConnected) {
      final response = await httpRequester.getRequest(
        endpoint:
            '/taxi/location/address?longitude=${longitude}&latitude=${latitude}&radius=${radius}',
        token: (await secureStorage.getToken()),
      );

      Logger().d(response.data);
      return List<AddressModel>.from(
          (response.data['data'] as List).map((x) => AddressModel.fromJson(x)));
    } else {
      throw NoInternetException();
    }
  }
}
