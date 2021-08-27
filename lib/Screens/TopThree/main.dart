import 'dart:async';
import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../RegistrationScreens/login_screen.dart';
import 'BackgroundScreen.dart';
import '../splash_screen.dart';
import '../first_time_screens.dart';
import '../../Session/session_manager.dart';
import '../../Shared Data/app_language.dart';
import '../../Shared Data/app_theme.dart';
import '../../Shared Data/common_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(FeedMeMain());
}

class FeedMeMain extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'FeedMe',
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
    appTheme = new AppTheme(sessionManager.loadPreferredTheme(),context);
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage()!);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppTheme>(
            create: (context) => appTheme,
          ),
          ChangeNotifierProvider<AppLanguage>(
            create: (context) => appLanguage,
          ),
          ChangeNotifierProvider<CommonData>(
            create: (context) => commonData,
          ),
        ],
        child: BackgroundScreen());
  }
}
