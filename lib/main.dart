import 'dart:async';
import 'dart:isolate';

import 'package:ataa/Screens/FirstTimeScreens/WelcomeScreen.dart';
import 'package:ataa/Screens/SplashScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'Screens/RegistrationScreens/LoginScreen.dart';
import 'Screens/TopThree/BackgroundScreen.dart';
import 'Session/SessionManager.dart';
import 'Shared Data/AppLanguage.dart';
import 'Shared Data/AppTheme.dart';
import 'Shared Data/CommonData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  ErrorWidget.builder = (errorDetails) {
    return Container(child: Text('حدث خطأ ما'));
  };
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
  runApp(AtaaMain());
}

class AtaaMain extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ataa',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "SplashScreen": (BuildContext context) => SplashScreen(),
        "WelcomeScreen": (BuildContext context) => WelcomeScreen(),
        "MainScreen": (BuildContext context) => MainScreen(),
        "LoginScreen": (BuildContext context) => LoginScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final CommonData commonData = new CommonData();
  @override
  Widget build(BuildContext context) {
    appTheme = new AppTheme(sessionManager.loadPreferredTheme(), context);
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage()!);
    return MultiProvider(providers: [
      ChangeNotifierProvider<AppTheme>(
        create: (context) => appTheme,
      ),
      ChangeNotifierProvider<AppLanguage>(
        create: (context) => appLanguage,
      ),
      ChangeNotifierProvider<CommonData>(
        create: (context) => commonData,
      ),
    ], child: BackgroundScreen());
  }
}
