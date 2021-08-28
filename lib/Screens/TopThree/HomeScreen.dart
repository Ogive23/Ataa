import 'package:ataa_lite/Shared%20Data/app_language.dart';
import 'package:ataa_lite/Shared%20Data/app_theme.dart';
import 'package:ataa_lite/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class HomeScreen extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  static late List<Color> gradientColors;

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

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    loadGradientColors();
    return GestureDetector(
        onTap: () {
          commonData.changeStep(Pages.IntroPage.index);
          loadInterstitial();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: w/25),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  appLanguage.words['HomeTitle']!,
                  style: appTheme.themeData.primaryTextTheme.headline1!.apply(
                    shadows: [
                      Shadow(
                          color: appTheme.themeData.accentColor,
                          offset: Offset.fromDirection(1, 3))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: h / 25),
                  child: Image.asset(
                    'assets/images/food.png',
                  ),
                ),
                Text(
                  appLanguage.words['HomeBody']!,
                  style: appTheme.themeData.primaryTextTheme.headline4!.apply(color: Colors.white),
                  textAlign: TextAlign.center,
                  textDirection: appLanguage.textDirection,
                ),
                Padding(
                    padding: EdgeInsets.only(top: h/50),
                    child: Text(
                      appLanguage.words['HomeSubtitle']!,
                      style: appTheme.themeData.primaryTextTheme.subtitle1,
                      textAlign: TextAlign.center,
                      textDirection: appLanguage.textDirection,
                    )),
              ],
            ),
          ),
        ));
  }
}
