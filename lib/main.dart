import 'dart:async';
import 'dart:isolate';
import 'package:ataa/Screens/FirstTimeScreens/WelcomeScreen.dart';
import 'package:ataa/Screens/SplashScreen.dart';
import 'package:ataa/Shared%20Data/MarkerData.dart';
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
    return const Text('حدث خطأ ما');
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

// ignore: use_key_in_widget_constructors
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
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        "SplashScreen": (BuildContext context) => const SplashScreen(),
        "WelcomeScreen": (BuildContext context) => const WelcomeScreen(),
        "MainScreen": (BuildContext context) => MainScreen(),
        "LoginScreen": (BuildContext context) => const LoginScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final CommonData commonData = CommonData();
  final MarkerData markerData = MarkerData();

  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    appTheme = AppTheme(sessionManager.loadPreferredTheme(), context);
    appLanguage = AppLanguage(sessionManager.loadPreferredLanguage()!);
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
      ChangeNotifierProvider<MarkerData>(
        create: (context) => markerData,
      ),
    ], child: const BackgroundScreen());
  }
}
