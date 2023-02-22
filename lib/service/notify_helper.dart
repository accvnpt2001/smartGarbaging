import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/service/firebase_messing.dart';

class NotificationHelper {
  static RemoteMessage? fcmMessage;
  static bool fCmByBackGround = true;

  static void init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
    const DarwinInitializationSettings initializationSettingsMacOS = DarwinInitializationSettings(
        requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('high_importance_channel', 'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              //color: defaultColor,
              enableLights: true,
              largeIcon: DrawableResourceAndroidBitmap('launch_background'),
              ticker: 'ticker');
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
    } catch (e) {
      print("Không show được thông báo roy .-.$e");
    }
  }

  static void configFCM() {
    NotificationHelper.init();
    foregroundReceiveFCM();
  }

  static void foregroundReceiveFCM() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => {handleClickFCM(value, from: 'foregroundReceiveFCM')});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      handelFcmMessageForeground(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('handleClickFCM_onMessageOpenedApp: ${message.data}');
    });
  }

  static void handleClickFCM(RemoteMessage? message, {String from = '', bool isBackGround = true}) async {
    print('handleClickFCM_$from:_$isBackGround | ${message?.data}');
    fCmByBackGround = isBackGround;
    fcmMessage = message;
  }

  static void handelFcmMessageForeground(RemoteMessage message) async {
    //showNotification(message.notification!.title!, message.notification!.body!);
    Get.snackbar(
      message.notification?.title ?? "",
      message.notification?.body ?? "no content",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      isDismissible: false,
      duration: const Duration(seconds: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      borderColor: Colors.red,
      borderWidth: 2,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
    showNotification(message.notification?.title ?? "", message.notification?.body ?? "no content");
  }
}
