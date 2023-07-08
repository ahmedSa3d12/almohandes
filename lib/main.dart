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



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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


final locator = GetIt.instance;






