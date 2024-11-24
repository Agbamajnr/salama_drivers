import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/local_storage/__export.dart';

class LocalNotificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const String _badgeCountKey = 'notification_badge_count';

  Future<void> setup() async {
    const androidInitializationSetting =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void showLocalNotification(RemoteMessage message) {
    var notification = message.notification;
    AndroidNotificationDetails androidNotificationDetail = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      silent: false,
        icon: '@mipmap/ic_launcher',
      sound: UriAndroidNotificationSound('asset:///raw/notification_sound.mp3')
    );
    const iosNotificatonDetail = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        notificationDetails
    );

    _incrementBadgeCount();
  }

  Future<void> _incrementBadgeCount() async {
    final prefs = await FlutterSecureStorage();
    int currentCount = int.parse("${await prefs.read(key: _badgeCountKey) ?? "0"}");
    await prefs.write(key: _badgeCountKey, value: "${currentCount + 1}");
  }

  Future<void> clearBadgeCount() async {
    final prefs = await FlutterSecureStorage();
    await prefs.write(key: _badgeCountKey, value:  "0");
  }

  Future<int> getBadgeCount() async {
    final prefs = await FlutterSecureStorage();
    return await int.parse("${prefs.read(key: _badgeCountKey)}");
  }
}