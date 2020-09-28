import 'package:feedme/Ads/ad_manager.dart';
import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Themes/app_language.dart';
import 'package:feedme/Themes/app_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'stay_in_touch_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;
  final pageOption = [StayInTouchPage(), HomeScreen(), SettingsScreen()];
  BannerAd bannerAd;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void loadBannerAd() {
    bannerAd
      ..load()
      ..show(anchorType: AnchorType.top);
  }

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    loadBannerAd();
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
    Navigator.pushNamed(context, "MainScreen");
  }
  Future<void> initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  final SessionManager sessionManager = new SessionManager();
  AppTheme appTheme;
  AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    appTheme = new AppTheme(sessionManager.loadPreferredTheme());
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage());
    return Scaffold(
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
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
          backgroundColor: Colors.indigo[900],
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<AppTheme>(
              create: (context) => appTheme,
            ),
            ChangeNotifierProvider<AppLanguage>(
              create: (context) => appLanguage,
            )
          ],
          child: pageOption[selectedIndex],
        ));
  }
}
