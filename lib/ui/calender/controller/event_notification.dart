import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class EventNotification {
  EventNotification._();
  static EventNotification en = EventNotification._();
  static BuildContext context;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelID = "tfp.studenthub.studenthub2";

  static const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(threadIdentifier: channelID);

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(channelID, channelID, 'TFP Smart campus',
          importance: Importance.max, priority: Priority.high, showWhen: false);
  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);

  initNotification() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);
  }

  cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<NotificationAppLaunchDetails> notificationDetails() async {
    return await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  showNotification(
      {@required String title,
      @required String body,
      @required int id,
      @required payload}) async {
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  scheduleNotification(
      {@required String title,
      @required String body,
      @required int id,
      @required payload,
      @required Duration duration}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.now(tz.local).add(duration), platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future<List<ActiveNotification>> getAndroidActiveNotifications() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
  }

  Future<bool> iosNotificationPermission() async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Parent(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => Parent()),
    );
  }
}
