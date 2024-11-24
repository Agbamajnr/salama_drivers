import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/constants/constants.dart';
import 'package:salama_users/core/notifications/local_notification.dart';
import 'package:salama_users/core/service_locator/sl_container.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/firebase_handler.dart';
import 'package:salama_users/presentation/notifiers/subscription_notifier.dart';
import 'package:salama_users/provider.dart';
import 'package:salama_users/core/routes/router.dart';

import 'core/routes/router_names.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  logger.d('Handling a background message ${message.notification?.title}');
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
final nav = Navigator.of(navKey.currentContext!);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseHandler().init();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await LocalNotificationService().setup();
  if (environment == Environment.staging) {
    await dotenv.load(fileName: '.env.staging');
  }
  if (environment == Environment.production) {
    await dotenv.load();
  }
  configureDependencies();
  unawaited(sl<SubscriptionsNotifier>().getCurentPosition());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          navigatorKey: navKey,
          initialRoute: Routes.startUp,
          onGenerateRoute: generateRoute),
    );
  }
}
