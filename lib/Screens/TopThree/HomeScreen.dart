import 'dart:ui';

import 'package:ataa/CustomWidgets/CustomLoadingText.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/Session/session_manager.dart';
import 'package:ataa/Shared%20Data/app_language.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:ataa/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class HomeScreen extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;static late List<Color> gradientColors;
  SessionManager sessionManager = new SessionManager();

  void loadInterstitial() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('InterstitialAd success to load: $ad');
            ad.show();
            // Keep a reference to the ad so you can show it later.
            // this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }
  void loadGradientColors() {
    if (appTheme.isDark) {
      gradientColors = [
        Colors.black,
        Colors.grey[800]!,
        Colors.grey[700]!,
        Colors.grey[600]!,
        Colors.grey[500]!,
        Colors.grey[400]!,
        Colors.grey[300]!,
        Colors.grey[200]!,
        Colors.grey[100]!,
      ];
      return;
    }
    gradientColors = [
      Colors.blue[900]!,
      Colors.blue[800]!,
      Colors.blue[700]!,
      Colors.blue[600]!,
      Colors.blue[500]!,
      Colors.blue[400]!,
      Colors.blue[300]!,
      Colors.blue[200]!,
      Colors.blue[100]!,
    ];
  }

  // Future<Map<String, dynamic>> getAtaaRecords() async {
  //   await Future.delayed(Duration(seconds: 5));
  //   return {'Err_Flag': false};
  // }
  //
  // Widget showAtaaRecords() {
  //   return FutureBuilder<Map<String, dynamic>>(
  //     future: getAtaaRecords(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done &&
  //           snapshot.data != null) {
  //         if (snapshot.data!['Err_Flag'])
  //           return Container(
  //             alignment: Alignment.center,
  //             child: ErrorMessage(message: snapshot.data!['Err_Desc']),
  //           );
  //         return Column(
  //           children: [
  //
  //           ],
  //         );
  //       } else if (snapshot.error != null) {
  //         return Container(
  //           alignment: Alignment.center,
  //           child:
  //               Text('حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
  //         );
  //       } else {
  //         return Container(
  //             alignment: Alignment.center,
  //             child:
  //                 CustomLoadingText(text: 'جاري تحميل الإنجازات الخاصة بنا'));
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    loadGradientColors();
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        title: Image.asset(
          'assets/images/Ataa.png',
          height: h / 15,
        ),
        leading: GestureDetector(
          onTap: () => commonData.changeStep(Pages.ProfileScreen.index),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w / 100),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: PopupMenuButton(
                  child: CircleAvatar(
                    radius: h / 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: sessionManager.user!.profileImage != 'N/A'
                          ? Image.network(
                              sessionManager.user!.profileImage!,
                              fit: BoxFit.contain,
                              width: w / 5,
                              height: h / 20,
                            )
                          : Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.cover,
                              width: w / 5,
                              height: h / 20,
                            ),
                    ),
                  ),
                  onSelected: (value) {
                    if (value == 'Profile')
                      return commonData.changeStep(Pages.ProfileScreen.index);
                    else if (value == 'Logout') {
                      sessionManager.logout();
                      Navigator.popUntil(context, (route) => false);
                      Navigator.pushNamed(context, "MainScreen");
                      return;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text(
                          'الملف الشخصي',
                          style: appTheme.themeData.primaryTextTheme.headline4,
                        ),
                        value: 'Profile',
                      ),
                      PopupMenuItem(
                        child: Text(
                          'تسجيل الخروج',
                          style: appTheme.themeData.primaryTextTheme.headline4,
                        ),
                        value: 'Logout',
                      ),
                    ];
                  },
                ),
              )),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () {
          commonData.changeStep(Pages.IntroPage.index);
          loadInterstitial();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: appTheme.themeData.primaryColor,
            image: DecorationImage(image: AssetImage('assets/images/567-5673790_love-food-hate-waste-01-giving-food-clip.png',))
          ),
          padding: EdgeInsets.symmetric(vertical: h / 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Ataa Helps about 500 Poor/Day to find their main source of food.',
                    textAlign: TextAlign.center,
                    style: appTheme.themeData.primaryTextTheme.headline4,
                  ),
                  CustomSpacing(value: 100),
                  Text(
                    'With more than about 40 volunteers.',
                    style: appTheme.themeData.primaryTextTheme.headline4,
                    textAlign: TextAlign.center,
                  ), CustomSpacing(value: 100),
                  Text(
                    'It\'s worth to keep going.',
                    style: appTheme.themeData.primaryTextTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: h / 25),
              //   child: Image.asset(
              //
              //     height: h/3,
              //     width: w,
              //   ),
              // ),
              Text(
                appLanguage.words['HomeSubtitle']!,
                style: appTheme.themeData.primaryTextTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
