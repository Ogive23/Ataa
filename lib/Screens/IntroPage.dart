// ignore_for_file: file_names

import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/UserAchievementContainer.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/CommonData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../GeneralInfo.dart';

class IntroPage extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final SessionManager sessionManager = SessionManager();

  IntroPage({Key? key}) : super(key: key);
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
      decoration: const BoxDecoration(
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
                color: appTheme.themeData.primaryColor.withOpacity(0.2),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: UserAchievementContainer()),
            const CustomSpacing(
              value: 10,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(10.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                commonData.changeStep(Pages.AtaaMainPage.index);
              },
              icon: const Icon(
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
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
              onPressed: () {
                commonData.changeStep(Pages.MarkerCreationPage.index);
              },
              icon: const Icon(
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
            const CustomSpacing(
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
