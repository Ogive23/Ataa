import 'dart:ui';
import 'package:ataa_lite/CustomWidgets/CustomSpacing.dart';
import 'package:ataa_lite/Session/session_manager.dart';
import 'package:ataa_lite/Shared%20Data/app_language.dart';
import 'package:ataa_lite/Shared%20Data/app_theme.dart';
import 'package:ataa_lite/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../GeneralInfo.dart';

class IntroPage extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final SessionManager sessionManager = new SessionManager();
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        body: Container(
      height: h,
      width: w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/giving.png'),
        fit: BoxFit.cover,
      )),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
                margin: EdgeInsets.symmetric(
                  horizontal: w / 20,
                ),
                color: Colors.transparent.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: h / 70),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    appLanguage.words['AchievementCenterOne']!,
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline4,
                                    textAlign: TextAlign.center,
                                    textDirection: appLanguage.textDirection,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '123',
                                            style: appTheme.themeData
                                                .primaryTextTheme.headline4,
                                            textAlign: TextAlign.center,
                                            textDirection:
                                                appLanguage.textDirection,
                                          ),
                                          Text(
                                              appLanguage.words['AchievementCenterTwo']!,
                                              style: appTheme.themeData
                                                  .primaryTextTheme.headline4!
                                                  .apply(fontSizeFactor: 0.5),
                                              textAlign: TextAlign.center,
                                              textDirection:
                                                  appLanguage.textDirection)
                                        ],
                                      ),
                                      Text(
                                        appLanguage.words['AchievementCenterThree']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(fontSizeFactor: 1.5),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '123',
                                            style: appTheme.themeData
                                                .primaryTextTheme.headline4,
                                            textAlign: TextAlign.center,
                                            textDirection:
                                                appLanguage.textDirection,
                                          ),
                                          Text(
                                            appLanguage.words['AchievementCenterThree']!,

                                            style: appTheme.themeData
                                                .primaryTextTheme.headline4!
                                                .apply(fontSizeFactor: 0.5),
                                            textAlign: TextAlign.center,
                                            textDirection:
                                                appLanguage.textDirection,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    appLanguage.words['AchievementCenterFive']!,
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline4,
                                    textAlign: TextAlign.center,
                                    textDirection: appLanguage.textDirection,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w / 50),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: LinearProgressIndicator(
                                        value: 0.3,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    appLanguage.words['AchievementCenterSix']!,
                                    style: appTheme
                                        .themeData.primaryTextTheme.headline4!
                                        .apply(
                                            fontSizeFactor: 0.7,
                                            heightFactor: 1.5),
                                    textAlign: TextAlign.center,
                                    textDirection: appLanguage.textDirection,
                                  ),
                                ],
                              ),
                            ),
                            BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                child: Text(
                                  appLanguage
                                      .words['AtaaIntroAchievementCenter']!,
                                  textAlign: TextAlign.center,
                                  textDirection: appLanguage.textDirection,
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline2!
                                      .apply(color: Colors.amber[100]),
                                ))
                          ],
                        )))),
            CustomSpacing(
              value: 10,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                commonData.changeStep(Pages.AtaaMainPage.index);
              },
              icon: Icon(
                Icons.flash_on,
                color: Colors.redAccent,
              ),
              label: Text(
                appLanguage.words['AtaaIntroSecondButton']!,
                textAlign: TextAlign.center,
                textDirection: appLanguage.textDirection,
                style: appTheme.themeData.primaryTextTheme.headline5!
                    .apply(color: Colors.white),
              ),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                commonData.changeStep(Pages.MarkerCreationPage.index);
              },
              icon: Icon(
                Icons.flag,
                color: Colors.white,
              ),
              label: Text(
                appLanguage.words['AtaaIntroFirstButton']!,
                textAlign: TextAlign.center,
                textDirection: appLanguage.textDirection,
                style: appTheme.themeData.primaryTextTheme.headline5!
                    .apply(color: Colors.white),
              ),
            ),
            CustomSpacing(
              value: 40,
            ),
            Text(
              appLanguage.words['AtaaIntroWord']!,
              textAlign: TextAlign.center,
              textDirection: appLanguage.textDirection,
              style: appTheme.themeData.primaryTextTheme.headline4!
                  .apply(color: Colors.white),
            ),
          ],
        ),
      ),
    ));
  }
}
