import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/data/models/subscriptions/subscribe_model.dart';
import 'package:salama_users/domain/entities/auth/location.dart';
import 'package:salama_users/domain/entities/subscriptions/address.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/entities/subscriptions/report.dart';
import 'package:salama_users/domain/entities/subscriptions/subscription.dart';
import 'package:salama_users/domain/usecases/subscriptions/accept_ride.dart';
import 'package:salama_users/domain/usecases/subscriptions/create_subscription_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/fetch_active_booking_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/fetch_address_coordinate_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/fetch_report_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/fetch_single_post_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/fetch_user_subscriptions.dart';
import 'package:salama_users/domain/usecases/subscriptions/report_booking_usecase.dart';
import 'package:salama_users/domain/usecases/subscriptions/subscribe_usecase.dart';
import 'package:salama_users/presentation/screens/home/paystack_webview.dart';
import '../../core/alerts/__export.dart';
import '../../core/exception/__export.dart';
import '../../core/local_storage/__export.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/usecases/auth/get_current_position.dart';
import '../../domain/usecases/subscriptions/cancel_booking.dart';
import '../../domain/usecases/subscriptions/complete_booking_usecase.dart';
import '../../domain/usecases/subscriptions/fetch_bookings_usecase.dart';
import '../../domain/usecases/subscriptions/fetch_subscriptions_usecase.dart';
import '../../domain/usecases/subscriptions/start_booking_usecase.dart';
import '../../main.dart';
import '../widgets/loader_popup.dart';

@lazySingleton
class SubscriptionsNotifier extends ChangeNotifier {
  SubscriptionsNotifier(
      {required this.createSubscriptionUsecase,
      required this.currentPositionUsecase,
      required this.fetchSubscriptionUsecase,
      required this.fetchUserSubscriptionUsecase,
      required this.acceptRideUsecase,
      required this.fetchBookingUsecase,
      required this.fetchSinglebookingUsecase,
      required this.fetchActivebookingUsecase,
      required this.cancelBookingUsecase,
      required this.startBookingUsecase,
      required this.completeBookingUsecase,
      required this.reportBookingUsecase,
      required this.fetchReportUsecase,
      required this.fetchAddressCoordinateUsecase,
      required this.subscribeUsecase});
  final GetCurrentPositionUsecase currentPositionUsecase;
  final CreateSubscriptionUsecase createSubscriptionUsecase;
  final FetchSubscriptionUsecase fetchSubscriptionUsecase;
  final FetchUserSubscriptionUsecase fetchUserSubscriptionUsecase;
  final FetchBookingUsecase fetchBookingUsecase;
  final AcceptRideUsecase acceptRideUsecase;
  final CancelBookingUsecase cancelBookingUsecase;
  final StartBookingUsecase startBookingUsecase;
  final CompleteBookingUsecase completeBookingUsecase;
  final ReportBookingUsecase reportBookingUsecase;
  final FetchReportUsecase fetchReportUsecase;
  final FetchAddressCoordinateUsecase fetchAddressCoordinateUsecase;
  final FetchSinglebookingUsecase fetchSinglebookingUsecase;
  final FetchActivebookingUsecase fetchActivebookingUsecase;
  final SubscribeUsecase subscribeUsecase;

  final currentPosition = GenericStore<Location?>(null);
  final subscriptions = GenericStore<List<Subscription>?>(null);
  final userSubscriptions = GenericStore<List<Subscription>?>(null);
  final userBookings = GenericStore<List<Booking>?>(null);
  final booking = GenericStore<Booking?>(null);
  final reports = GenericStore<List<Report>?>(null);
  final address = GenericStore<List<Address>?>(null);

  Future<void> getCurentPosition() async {
    final position = await currentPositionUsecase(NoParams());
    if (position != null) {
      currentPosition
          .emit(Location(lat: position.latitude, lng: position.longitude));
    }
  }

  Future<bool> createSubscription({
    required String tenor,
    required double title,
    required double description,
    required double amount,
  }) async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final data = {
      "tenor": tenor,
      "title": title,
      "description": description,
      "amount": amount
    };
    final response = await createSubscriptionUsecase(data);
    return response.fold((l) {
      nav.pop();
      AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      return false;
    }, (r) async {
      nav.pop();
      AppFlushbar.show('Subscription Created Successfully');
      return true;
    });
  }

  Future<void> fetchSubscriptions() async {
    final response =
        await fetchSubscriptionUsecase(FetchSubscriptionUsecaseParams());
    response.fold(
      (l) {},
      (r) {
        Logger().d("${r}  subscription");
        subscriptions.emit(r);
      },
    );
  }

  Future<void> fetchUserSubscriptions() async {
    final response = await fetchUserSubscriptionUsecase(
        FetchUserSubscriptionUsecaseParams());
    response.fold(
      (l) {},
      (r) {
        Logger().d("${r} user subscription");
        userSubscriptions.emit(r);
      },
    );
  }

  Future<void> fetchBooking() async {
    final response = await fetchBookingUsecase(FetchBookingUsecaseParams());
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        userBookings.emit(r);
      },
    );
  }

  Future<void> fetchSingleBooking({required String bookingId}) async {
    final response = await fetchSinglebookingUsecase(
        FetchSingleBookingUsecaseParams(bookingId: bookingId));
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        booking.emit(r);
      },
    );
  }

  Future<void> fetchActiveBooking({required String rideStatus}) async {
    final response = await fetchActivebookingUsecase(
        FetchActiveBookingUsecaseParams(rideStatus: rideStatus));
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        booking.emit(r);
      },
    );
  }

  Future<void> acceptRide({
    required String bookingId,
  }) async {
    final response =
        await acceptRideUsecase(AcceptRideUsecaseParams(bookingId: bookingId));
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {},
    );
  }

  Future<void> cancelbooking({
    required String bookingId,
  }) async {
    final response = await cancelBookingUsecase(
      CancelBookingUsecaseParams(bookingId: bookingId),
    );
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        fetchBooking();
      },
    );
  }

  Future<void> startbooking({
    required String bookingId,
  }) async {
    final response = await startBookingUsecase(
      StartBookingUsecaseParams(bookingId: bookingId),
    );
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        fetchBooking();
      },
    );
  }

  Future<void> completebooking({
    required String bookingId,
  }) async {
    final response = await completeBookingUsecase(
      CompleteBookingUsecaseParams(bookingId: bookingId),
    );
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        fetchBooking();
      },
    );
  }

  Future<void> reportbooking({
    required String bookingId,
    required String message,
  }) async {
    final response = await reportBookingUsecase(
      ReportBookingUsecaseParams(bookingId: bookingId, message: message),
    );
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {},
    );
  }

  Future<void> fetchReport() async {
    final response = await fetchReportUsecase(FetchReportUsecaseParams());
    response.fold(
      (l) {},
      (r) {
        reports.emit(r);
      },
    );
  }

  Future<void> fetchAddressCoordinate(
      {required double longitude,
      required double latitude,
      required double radius}) async {
    final response = await fetchAddressCoordinateUsecase(
        FetchAddressCoordinateUsecaseParams(
            latitude: latitude, longitude: longitude, radius: radius));
    response.fold(
      (l) {
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
      },
      (r) {
        address.emit(r);
      },
    );
  }

  Future<PaystackData?> subscribe(
    BuildContext context, {
    required String planId,
  }) async {
    unawaited(PopupLoader().show(navKey.currentContext!));
    final response = await subscribeUsecase(
      SubscribeUsecaseParams(planId: planId),
    );
    logger.d(response);
    response.fold(
      (l) {
        nav.pop();
        AppFlushbar.show(FailureToMessage.mapFailureToMessage(l));
        return null;
      },
      (r) {
        nav.pop();
        logger.d(r.authorizationUrl);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CustomWebView(authorizationUrl: r.authorizationUrl)),
        );
      },
    );
  }
}
