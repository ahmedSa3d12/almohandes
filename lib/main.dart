import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:engwheels/injector.dart' as injector;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app.dart';

import 'app_bloc_observer.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/restart_app_class.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: IOSInitializationSettings(),
    ),
  );
  await requestPermissions();
  NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );
  Future<void> showNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'payload',
    );
  }
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    showNotification(message.data['title'], message.data['body']);

  }
// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);

  });
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE).then((value) {
  //
  //   print('************************************************');
  //   print(value);
  //   print('************************************************');
  //
  // });

  await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);


  await injector.setup();
  Bloc.observer = AppBlocObserver();

  runApp(
  EasyLocalization(
  supportedLocales: [Locale('ar', ''), Locale('en', '')],
  path: 'assets/lang',
  saveLocale: true,
  startLocale: Locale('ar', ''),
  fallbackLocale: Locale('ar', ''),
  child: HotRestartController(child: const Engwheels()),
  ),
  );


}

Future<void> requestPermissions() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      MacOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}



final locator = GetIt.instance;









