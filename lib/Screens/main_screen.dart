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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;
  final pageOption = [StayInTouchPage(), HomeScreen(), SettingsScreen()];
  BannerAd bannerAd;

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
                title: Text(appLanguage.language == 'En'
                    ? 'Stay in touch'
                    : 'أبقي علي تواصل')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(appLanguage.language == 'En'
                    ? 'Home'
                    : 'الرئيسية')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text(appLanguage.language == 'En'
                    ? 'Settings'
                    : 'إعدادات')),
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
