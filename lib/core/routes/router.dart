import 'package:flutter/material.dart';
import 'package:salama_users/core/routes/router_names.dart';
import 'package:salama_users/presentation/screens/auth/id_photo_screen.dart';
import 'package:salama_users/presentation/screens/auth/login_screen.dart';
import 'package:salama_users/presentation/screens/auth/phot_camera_screen.dart';
import 'package:salama_users/presentation/screens/auth/photo_consent_screen.dart';
import 'package:salama_users/presentation/screens/auth/profile_photo_consent_screen.dart';
import 'package:salama_users/presentation/screens/auth/registration_confirmed_screen.dart';
import 'package:salama_users/presentation/screens/home/home.dart';
import 'package:salama_users/presentation/screens/others/booking_details_page.dart';
import 'package:salama_users/presentation/screens/splash.dart';

import '../../presentation/screens/home/booking_details_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.startUp:
      return _getPageRoute(
          routeName: settings.name, viewToShow: const SplashScreen());
    case Routes.login:
      return _getPageRoute(routeName: settings.name, viewToShow: LoginScreen());
   case Routes.photoConsentScreen:
      return _getPageRoute(routeName: settings.name, viewToShow: PhotoConsentScreen());
        case Routes.idPage:
      return _getPageRoute(routeName: settings.name, viewToShow: IdPhotoPage());
        case Routes.profilePhotoConsentScreen:
      return _getPageRoute(routeName: settings.name, viewToShow: ProfilePhotoConsentScreen());
        case Routes.profilePhotoCameraScreen:
      return _getPageRoute(routeName: settings.name, viewToShow: ProfilePhotoCameraScreen());
      case Routes.regsitrationConfirmScreen:
      return _getPageRoute(routeName: settings.name, viewToShow: RegistrationConfirmedScreen());
  case Routes.home:
      return _getPageRoute(routeName: settings.name, viewToShow: HomeScreen());
      case Routes.bookingDetails:
      return _getPageRoute(routeName: settings.name, viewToShow: BookingDetails(
        params: settings.arguments as BookingDetailScreenParams,
      ));
       case Routes.abookingDetails:
      return _getPageRoute(routeName: settings.name, viewToShow: ABookingDetails(
        params: settings.arguments as ABookingDetailScreenParams,
      ));
    default:
      return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

// ignore: strict_raw_type
PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute<void>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}
