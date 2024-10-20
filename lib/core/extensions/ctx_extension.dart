import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salama_users/presentation/notifiers/subscription_notifier.dart';

import '../../presentation/notifiers/auth_notifier.dart';

extension CxtExtension on BuildContext {
  // theme related
  ThemeData get theme => Theme.of(this);
  AppBarTheme get appbarTheme => AppBarTheme.of(this);
  DialogTheme get dialogTheme => DialogTheme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  TabBarTheme get tabbarTheme => Theme.of(this).tabBarTheme;

  // size related
  Size get size => MediaQuery.of(this).size;
  EdgeInsets get padding => MediaQuery.of(this).padding;

  // navigator related
  NavigatorState get nav => Navigator.of(this);

  // media queries
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // focus scope
  FocusScopeNode get focusScope => FocusScope.of(this);

  // view models
  AuthNotifier get auth => read<AuthNotifier>();
  SubscriptionsNotifier get subsription => read<SubscriptionsNotifier>();

  
  FocusScopeNode get scope => FocusScope.of(this);

  Object? get object => ModalRoute.of(this)?.settings.arguments;

  // ScreenHelper
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}
