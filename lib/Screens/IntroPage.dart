import 'dart:ui';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/UserAchievementContainer.dart';
import 'package:ataa/Session/session_manager.dart';
import 'package:ataa/Shared%20Data/app_language.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:ataa/Shared%20Data/common_data.dart';
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
                child: UserAchievementContainer()),
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
