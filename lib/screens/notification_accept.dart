import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//NotificationAccept   ضروري بصفحة سديم عند زر القبول احط كلاس , زي ماهو محطوط عند الويلكم
class NotificationAccept {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        //'channel description', هذي اذكر حقت البيلود
        importance: Importance.max,
      ),
      //iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    //String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
}
