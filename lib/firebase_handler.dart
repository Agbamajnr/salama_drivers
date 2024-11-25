import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/notifications/local_notification.dart';
import 'package:salama_users/core/routes/router_names.dart';
import 'package:salama_users/domain/entities/subscriptions/booking.dart';
import 'package:salama_users/domain/entities/subscriptions/push_notification.dart';
import 'package:salama_users/main.dart';
import 'package:salama_users/presentation/screens/home/booking_details_page.dart';
import 'firebase_options.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseHandler {
  Future<void> init() async {
    await Firebase.initializeApp(
      name: "salama_drivers",
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    final fcmToken = await FirebaseMessaging.instance.getToken().then((value) {
      logger.wtf(value);
      final prefs = FlutterSecureStorage();
      prefs.write(key: "firebaseToken", value: value);
    }).catchError((e) => logger.e(e));
    // debugPrint("FCMToken $fcmToken");
    logger.wtf(fcmToken);
    // await getIt<DBService>().saveFirebaseToken(fcmToken.toString());
  }
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  BuildContext? _context;

  Future initialize(BuildContext context) async {
    _context = context;
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message?.notification != null) {
        final Map<String, dynamic> data;
        data = message!.data;
        logger.wtf(data);

        // Convert data to PushNotificationModel
        final PushNotificationModel pushNotificationModel =
            PushNotificationModel.fromJson(data);
        if (pushNotificationModel.tripId == null) return;
        context.subsription.fetchBooking();

        //TODO: REMOVE DUMMY TRIP ID
        // pushNotificationModel.tripId = "503c17bf-1812-4191-aa3c-88bdaaf909e9";
        context.subsription.fetchSingleBooking(
            bookingId: pushNotificationModel.tripId.toString());
        final item = context.subsription.booking.value;
        showNotificationModal(
            context,
            pushNotificationModel.title ?? "Alert",
            false,
            item,
            pushNotificationModel.body,
            pushNotificationModel.tripId);
        await playSoundAndVibrate();

        // Log or use the PushNotificationModel instance
        logger.wtf(pushNotificationModel);
        logger.wtf(data);
        LocalNotificationService().showLocalNotification(message);
      }
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final Map<String, dynamic> data;
      data = message.data;
      logger.wtf(data);
      _handleForegroundMessage(message);
    });

    // Handle when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationOpen(message);
    });
  }

  bool _isLoading = false;

  void _handleForegroundMessage(RemoteMessage message) {
    if (_context != null && _context!.mounted) {
      final Map<String, dynamic> data;
      data = message.data;
      logger.wtf(data);
      LocalNotificationService().showLocalNotification(message);
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    // Handle navigation when notification is tapped
    if (_context != null && _context!.mounted) {
      // Add your navigation logic here
      print("Notification tapped: ${message.notification?.title}");
    }

    Future<String?> getToken() async {
      String? token = await _fcm.getToken();
      final prefs = FlutterSecureStorage();
      prefs.write(key: "firebaseToken", value: token);
      return token;
    }

    Future<void> backgroundHandler(RemoteMessage message) async {}
  }

  void showNotificationModal(
      BuildContext context, String title, bool _isProcessing,
      [Booking? booking, String? body, String? tripId]) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(10),
            child: AbsorbPointer(
              absorbing: _isProcessing,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: Colors.red,
                                size: 40,
                              ),
                              Gap(10),
                              Text(
                                title,
                                style: TextStyle(
                                  // fontFamily: AppFonts.mulishRegular,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  // color: AppColors.black,
                                ),
                              ),
                              Gap(18),
                              Text(
                                booking != null
                                    ? 'A user: ${booking.user['name']} has booked you for a trip to ${booking.riderToAddress}'
                                    : "",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: TextStyle(
                                  color: Color(0xff6D6D6D),
                                  // fontFamily: AppFonts.mulishRegular,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  // color: AppColors.textColor,
                                ),
                              ),
                              const Gap(16),
                            ],
                          ),
                          const Gap(24),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  nav.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: SizedBox(
                                    height: 15,
                                    child: Center(
                                      child: Text(
                                        "Dismiss",
                                        style: TextStyle(
                                            // fontFamily: AppFonts.mulishRegular,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(10),
                              // Consumer<AuthNotifier>(
                              //     builder: (context, AuthNotifier user, child) {
                              InkWell(
                                onTap: () async {
                                  if (booking != null && booking.id != null) {
                                    Navigator.of(context).pushNamed(
                                      Routes.abookingDetails,
                                      arguments: ABookingDetailScreenParams(
                                          booking: booking),
                                    );
                                  } else {
                                    context.nav.pushNamedAndRemoveUntil(
                                        Routes.home,
                                        (Route<dynamic> route) => false);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor
                                        // width: 1, color: AppColors.secondary,
                                        ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: SizedBox(
                                    height: 15,
                                    child: Center(
                                      child: _isProcessing
                                          ? SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: AppColors.primaryColor,
                                              ))
                                          : Text(
                                              booking != null &&
                                                      booking.id != null
                                                  ? "View Trip"
                                                  : "View Active Trips",
                                              style: TextStyle(
                                                // fontFamily: AppFonts.manRope,
                                                color: AppColors.primaryColor,
                                                // fontFamily: AppFonts.mulishRegular,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800,
                                                // color: AppColors.secondary
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> playSoundAndVibrate() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/sample_ringtone.mp3'));
    await Future.delayed(Duration(minutes: 1));
    await player.stop();
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 6000); // Vibrates for 1 second
    }
  }
}
