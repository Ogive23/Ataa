
import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Themes/app_language.dart';
import 'package:feedme/Themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'stay_in_touch_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:feedme/common_data.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {}

class Background extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static AppTheme appTheme;
  static AppLanguage appLanguage;
  final CommonData commonData = new CommonData();
  @override
  Widget build(BuildContext context) {
    appTheme = new AppTheme(sessionManager.loadPreferredTheme());
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage());
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
    )
    ],
    child: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageOption = [StayInTouchPage(), HomeScreen(), SettingsScreen()];
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    initNotification();
  }
  initNotification(){
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //Do Nothing
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        navigateToHome(message);
      },
      onResume: (Map<String, dynamic> message) async {
        navigateToHome(message);
      },
    );
  }

  void navigateToHome(Map<String, dynamic> message) {
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    Navigator.pushNamed(context, "Background");
  }

  void onItemTapped(int index) {
    commonData.changeStep(index);
  }

  final SessionManager sessionManager = new SessionManager();
  static AppTheme appTheme;
  static AppLanguage appLanguage;
  static CommonData commonData;
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    AppLanguage appLanguage = Provider.of<AppLanguage>(context);
    commonData = Provider.of<CommonData>(context);
    return Scaffold(
      backgroundColor: appTheme.themeData.backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text(appLanguage.words['bottomNavigationItemFirst'])),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(appLanguage.words['bottomNavigationItemSecond'])),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text(appLanguage.words['bottomNavigationItemThird'])),
          ],
          currentIndex: commonData.step,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: appTheme.themeData.iconTheme.color,
          onTap: onItemTapped,
          backgroundColor: appTheme.themeData.appBarTheme.color,
        ),
        body: pageOption[commonData.step],
    );
  }
}
