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
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;
  final pageOption = [StayInTouchPage(), HomeScreen(), SettingsScreen()];
  BannerAd bannerAd;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      content: Text("Item has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }
  void _navigateToItemDetail(Map<String, dynamic> message) {
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
