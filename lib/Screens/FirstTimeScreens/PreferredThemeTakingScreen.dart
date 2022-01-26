import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/Screens/FirstTimeScreens/PreferredLanguageTakingScreen.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';

class PreferredThemeTakingScreen extends StatelessWidget {
  static late double w, h;
  static late AppTheme appTheme;
  final SessionManager sessionManager = new SessionManager();

  void finishedChoosing(context, bool theme) {
    sessionManager.createPreferredTheme(theme);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreferredLanguageTakingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = AppTheme(false, context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            height: h,
            width: w,
            padding: EdgeInsets.symmetric(horizontal: w / 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Now Tell us which theme do you prefer?\n'
                    'الآن أخبرنا ما الشكل الذي تفضله؟',
                    style: appTheme.nonStaticGetTextStyle(
                        1.5,
                        Colors.black,
                        appTheme.largeTextSize(context),
                        FontWeight.normal,
                        1.0,
                        TextDecoration.none,
                        'OpenSans'),
                    textAlign: TextAlign.center,
                  ),
                  CustomSpacing(value: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          'White Theme\n'
                          'الوضع الأبيض',
                          style: appTheme.nonStaticGetTextStyle(
                              1.5,
                              Colors.black,
                              appTheme.mediumTextSize(context),
                              FontWeight.normal,
                              1.0,
                              TextDecoration.none,
                              'OpenSans'),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          finishedChoosing(context, false);
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Text(
                          'Black Theme\n'
                          'الوضع المظلم',
                          style: appTheme.nonStaticGetTextStyle(
                              1.5,
                              Colors.white,
                              appTheme.mediumTextSize(context),
                              FontWeight.normal,
                              1.0,
                              TextDecoration.none,
                              'OpenSans'),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          finishedChoosing(context, true);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
