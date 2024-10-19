import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:salama_users/presentation/notifiers/subscription_notifier.dart';
import 'core/service_locator/__export.dart';
import 'presentation/notifiers/auth_notifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: sl<AuthNotifier>()),
  ChangeNotifierProvider.value(value: sl<SubscriptionsNotifier>()),
];
