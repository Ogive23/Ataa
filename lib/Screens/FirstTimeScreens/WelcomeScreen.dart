import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/Screens/FirstTimeScreens/PreferredThemeTakingScreen.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  static late double w, h;
  static late AppTheme appTheme;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = AppTheme(false, context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            height: h,
            width: w,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Lottie.asset(
                  'assets/animations/7520-welcome.json',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                ),
                CustomSpacing(value: 50),
                Text(
                  'Welcome To Ataa App!\n'
                  'مرحباً بك في تطبيق عطاء',
                  style: appTheme.nonStaticGetTextStyle(
                      1.5,
                      Colors.black,
                      appTheme.largeTextSize(context),
                      FontWeight.bold,
                      1.0,
                      TextDecoration.none,
                      'OpenSans'),
                  textAlign: TextAlign.center,
                ),
                CustomSpacing(value: 50),
                Text(
                  'We gonna help you to change \nTHE WORLD.\n'
                  'ســوف نــســاعــدك لإنــقــاذ\nالــــعـــالـــم',
                  style: appTheme.nonStaticGetTextStyle(
                      1.5,
                      Colors.blue,
                      appTheme.largeTextSize(context),
                      FontWeight.bold,
                      1.0,
                      TextDecoration.none,
                      'OpenSans'),
                  textAlign: TextAlign.center,
                ),
                CustomSpacing(value: 50),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))))),
                    icon: Icon(
                      Icons.fast_forward,
                      color: Colors.green,
                    ),
                    label: Text(
                      'Continue / إستمرار',
                      style: appTheme.nonStaticGetTextStyle(
                          1.0,
                          Colors.green,
                          appTheme.mediumTextSize(context),
                          FontWeight.normal,
                          1.0,
                          TextDecoration.none,
                          'OpenSans'),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreferredThemeTakingScreen()));
                    })
              ],
            ))));
  }
}
