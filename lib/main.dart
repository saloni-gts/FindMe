import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:find_me/components/globalnavigatorkey.dart';
import 'package:find_me/firebase_options.dart';
import 'package:find_me/monish/provider/mapProvider.dart';
import 'package:find_me/provider/achievement_provider.dart';
import 'package:find_me/provider/authprovider.dart';
import 'package:find_me/provider/petprovider.dart';
import 'package:find_me/provider/purchase_provider.dart';
import 'package:find_me/services/hive_handler.dart';
import 'package:find_me/util/app_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'chat_controller/firebase_provider.dart';
import 'monish/provider/myProvider.dart';

// final Future<FirebaseApp> initialization = Firebase.initializeApp();

// final Future<FirebaseApp> initialization = Firebase.initializeApp();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    print("**************** firebase initialization *************");
  });
  // await Firebase.initializeApp();

  runZonedGuarded<Future<void>>(() async {
    await HiveHandler.hiveRegisterAdapter().then((value) {
      print("**************** hive register initialization *************");
    });

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
          Locale('es', 'ES'),
          Locale('de', 'DE'),
          Locale('uk', 'UA'),
        ],
        fallbackLocale: const Locale('en', 'US'),
        path: 'resources/langs',
        child: const MyApp()));
  }, (error, stack) {
    print("error is >>> $error");
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });

// FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//   runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("calling main building function");
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(
          create: (context) => PurChaseProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => Myprovider()),
        ChangeNotifierProvider(
          create: (context) => PetProvider(),
        ),

        ChangeNotifierProvider(create: (context) => MapProvider()),
        ChangeNotifierProvider(create: (context) => AchievementProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenrator.generateRoute,
        // home: SizedBox(),
        initialRoute: '/',
        navigatorKey: GlobalVariable.navState,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        builder: EasyLoading.init(),
        title: 'Find Me',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
