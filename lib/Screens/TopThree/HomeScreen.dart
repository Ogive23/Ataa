import 'package:feedme/Shared%20Data/app_language.dart';
import 'package:feedme/Shared%20Data/app_theme.dart';
import 'package:feedme/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class HomeScreen extends StatelessWidget {
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  // InterstitialAd myInterstitial;
  // Future<void> initAdMob() {
  //   return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  // }
  // void loadInterstitial(){
  //   InterstitialAd.
  //     ..load()
  //     ..show(
  //       anchorType: AnchorType.bottom,
  //       anchorOffset: 0.0,
  //       horizontalCenterOffset: 0.0,
  //     );
  // }
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    // myInterstitial = InterstitialAd(
    //   adUnitId: InterstitialAd.testAdUnitId,
    //   listener: (MobileAdEvent event) {
    //     print("InterstitialAd event is $event");
    //   },
    // );
    return GestureDetector(
        onTap: () {
          commonData.changeStep(Pages.IntroPage.index);
          // loadInterstitial();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue[900]!,
            Colors.blue[800]!,
            Colors.blue[700]!,
            Colors.blue[600]!,
            Colors.blue[500]!,
            Colors.blue[400]!,
            Colors.blue[300]!,
            Colors.blue[200]!,
            Colors.blue[100]!,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 10, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      appLanguage.words['HomeTitle']!,
                      style: TextStyle(
                        color: appTheme.themeData.backgroundColor,
                        fontSize: 70,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                        letterSpacing: 1.4,
                        shadows: [
                          Shadow(
                              color: appTheme.themeData.accentColor,
                              offset: Offset.fromDirection(1, 3))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                  child: Image.asset(
                    'assets/images/food.png',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      appLanguage.words['HomeBody']!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                      textDirection: appLanguage.language == 'En'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      appLanguage.words['HomeSubtitle']!,
                    )),
              ],
            ),
          ),
        ));
  }
}
