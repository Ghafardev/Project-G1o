import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(settings: settings);
  }

  static Future showNotification({String? title, String? body}) async {
    await _notifications.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id', 
          'Emergency', 
          importance: Importance.max, 
          priority: Priority.high
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}