import 'dart:ui';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/CommonData.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class HomeScreen extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final SessionManager sessionManager = new SessionManager();
  final MemoryCache memoryCache = new MemoryCache();

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
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      // appBar: AppBar(
      //   backgroundColor: appTheme.themeData.primaryColor,
      //   // title: ,
      //   leading: ,
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: Stack(
        children: [
          Container(
            height: h,
            width: w,
            child: CachedNetworkImage(
              imageUrl:
                  'https://cdni.iconscout.com/illustration/premium/thumb/geometry-shapes-seamless-pattern-2873562-2391991.png',
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) {
                print(error);
                return Container();
              },
              fit: BoxFit.cover,
              width: w,
              height: h,
            ),
          ),
          GestureDetector(
            onTap: () {
              commonData.changeStep(Pages.IntroPage.index);
              // loadInterstitial();
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(vertical: h / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () =>
                              commonData.changeStep(Pages.ProfileScreen.index),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w / 50, vertical: h / 100),
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: appTheme.themeData.accentColor,
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: PopupMenuButton(
                                  color: appTheme.themeData.accentColor,
                                  child: CircleAvatar(
                                    radius: h / 50,
                                    backgroundColor: appTheme.themeData.accentColor,
                                    foregroundColor: appTheme.themeData.accentColor,
                                    child: ClipOval(
                                      child:
                                          sessionManager.user!.profileImage !=
                                                  'N/A'
                                              ? CachedNetworkImage(
                                                  imageUrl: sessionManager
                                                      .user!.profileImage!,
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
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
                                      return commonData.changeStep(
                                          Pages.ProfileScreen.index);
                                    else if (value == 'Logout') {
                                      sessionManager.logout();
                                      Navigator.popUntil(
                                          context, (route) => false);
                                      Navigator.pushNamed(
                                          context, "LoginScreen");
                                      memoryCache.clear();
                                      return;
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text(
                                          'الملف الشخصي',
                                          style: appTheme.themeData
                                              .primaryTextTheme.headline4,
                                        ),
                                        value: 'Profile',
                                      ),
                                      PopupMenuItem(
                                        child: Text(
                                          'تسجيل الخروج',
                                          style: appTheme.themeData
                                              .primaryTextTheme.headline4,
                                        ),
                                        value: 'Logout',
                                      ),
                                    ];
                                  },
                                ),
                              )),
                        ),
                      ),
                      Center(
                          child: Image.asset(
                        'assets/images/Ataa.png',
                        height: h / 15,
                      ))
                    ],
                  )),
                  Container(
                    child: Column(
                      children: [
                        CustomSpacing(value: 50),
                        Container(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://cdni.iconscout.com/illustration/premium/thumb/two-girls-jumping-out-of-joy-in-autumn-season-2791069-2324024.png',
                                height: h / 10,
                              ),
                              Text(
                                'Ataa Helps about 500 Human/Day to secure their main source of clean, human & free food.',
                                textAlign: TextAlign.center,
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        CustomSpacing(value: 50),
                        Container(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://blog.forgood.co.za/wp-content/uploads/2018/02/Volunteer.png',
                                height: h / 10,
                              ),
                              Text(
                                'With more than about 40 volunteers.',
                                textAlign: TextAlign.center,
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        CustomSpacing(value: 20),
                        Text(
                          'It\'s worth to keep going.',
                          style: appTheme.themeData.primaryTextTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                        CustomSpacing(value: 20),
                      ],
                    ),
                  ),
                  Text(
                    appLanguage.words['HomeSubtitle']!,
                    style: appTheme.themeData.primaryTextTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
