import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  late bool isDark;
  late ThemeData themeData;
  AppTheme(bool isDark, context) {
    this.isDark = isDark;
    themeData = getCurrentTheme(context);
  }
  largeTextSize(context) {
    return MediaQuery.of(context).size.height / 40;
  }

  mediumTextSize(context) {
    return MediaQuery.of(context).size.height / 50;
  }

  smallTextSize(context) {
    return MediaQuery.of(context).size.height / 60;
  }

  static getTextStyle(
      height, color, fontSize, fontWeight, spacing, decoration, family,
      [shadows]) {
    return TextStyle(
        height: height,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: spacing,
        decoration: decoration,
        fontFamily: family,
        shadows: shadows);
  }

  nonStaticGetTextStyle(
      height, color, fontSize, fontWeight, spacing, decoration, family,
      [shadows]) {
    return getTextStyle(height, color, fontSize, fontWeight, spacing,
        decoration, family, shadows);
  }

  changeTheme(bool value, context) {
    this.isDark = value;
    themeData = getCurrentTheme(context);
    print('changed');
    notifyListeners();
  }

  ThemeData getCurrentTheme(context) {
    return this.isDark ? getDarkTheme(context) : getLightTheme(context);
  }

  ThemeData getDarkTheme(context) {
    return ThemeData(
        primaryColor: Color.fromRGBO(25, 36, 40, 1.0),
        accentColor: Color.fromRGBO(55, 66, 70, 1.0),
        shadowColor: Colors.white.withOpacity(0.5),
        primaryTextTheme: TextTheme(
          headline1: getTextStyle(
              1.0,
              Color.fromRGBO(247, 148, 29, 1.0),
              largeTextSize(context) * 2,
              FontWeight.bold,
              1.0,
              TextDecoration.none,
              "OpenSans"),
          headline2: getTextStyle(
              1.0,
              Color.fromRGBO(247, 148, 29, 1.0),
              largeTextSize(context) * 1.5,
              FontWeight.w600,
              1.0,
              TextDecoration.none,
              'Delius'),
          headline3: getTextStyle(
              1.0,
              Color.fromRGBO(247, 148, 29, 1.0),
              largeTextSize(context),
              FontWeight.bold,
              1.0,
              TextDecoration.none,
              "Delius"),
          headline4: getTextStyle(1.0, Colors.white, largeTextSize(context),
              FontWeight.normal, 1.0, TextDecoration.none, "Delius"),
          headline5: getTextStyle(
              1.0,
              Color.fromRGBO(38, 92, 126, 1.0),
              mediumTextSize(context),
              FontWeight.w400,
              1.0,
              TextDecoration.none,
              "Delius"),
          bodyText1: getTextStyle(
              1.0,
              Color.fromRGBO(247, 148, 29, 1.0),
              mediumTextSize(context),
              FontWeight.normal,
              1.0,
              TextDecoration.none,
              "Delius"),
          bodyText2: getTextStyle(1.0, Colors.white, mediumTextSize(context),
              FontWeight.normal, 1.0, TextDecoration.none, "Delius"),
          subtitle1: getTextStyle(1.0, Colors.grey, smallTextSize(context),
              FontWeight.w300, 1.0, TextDecoration.none, "Delius"),
          subtitle2: getTextStyle(
              1.0,
              Colors.grey.withOpacity(0.5),
              smallTextSize(context),
              FontWeight.w300,
              1.0,
              TextDecoration.none,
              "Delius"),
        ),
        appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(247, 148, 29, 1.0),
            titleTextStyle: getTextStyle(
                1.0,
                Color.fromRGBO(255, 255, 255, 1.0),
                20.0,
                FontWeight.normal,
                1.0,
                TextDecoration.none,
                "OpenSans"),
            iconTheme: IconThemeData(color: Color.fromRGBO(247, 148, 29, 1.0))),
        cardColor: Color.fromRGBO(45, 56, 60, 1.0),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toggleableActiveColor: Colors.green,
        toggleButtonsTheme: ToggleButtonsThemeData(
            disabledColor: Colors.grey, selectedColor: Colors.amber),
        buttonColor: Colors.white);
  }

  ThemeData getLightTheme(context) {
    return ThemeData(
        primaryColor: Color.fromRGBO(246, 246, 252, 1.0),
        accentColor: Color.fromRGBO(240, 227, 202, 1.0),
        shadowColor: Colors.black.withOpacity(0.5),
        primaryTextTheme: TextTheme(
          headline1: getTextStyle(
              1.0,
              Colors.amber[300],
              largeTextSize(context) * 2,
              FontWeight.bold,
              1.0,
              TextDecoration.none,
              "OpenSans"),
          headline2: getTextStyle(
              1.0,
              Colors.amber[300],
              largeTextSize(context) * 1.5,
              FontWeight.w600,
              1.0,
              TextDecoration.none,
              'Delius'),
          headline3: getTextStyle(
              1.0,
              Colors.amber[300],
              largeTextSize(context),
              FontWeight.bold,
              1.0,
              TextDecoration.none,
              "Delius"),
          headline4: getTextStyle(1.0, Colors.black, largeTextSize(context),
              FontWeight.normal, 1.0, TextDecoration.none, "Delius"),
          headline5: getTextStyle(
              1.0,
              Color.fromRGBO(38, 92, 126, 1.0),
              mediumTextSize(context),
              FontWeight.w400,
              1.0,
              TextDecoration.none,
              "Delius"),
          bodyText1: getTextStyle(
              1.0,
              Colors.amber[300],
              mediumTextSize(context),
              FontWeight.normal,
              1.0,
              TextDecoration.none,
              "Delius"),
          bodyText2: getTextStyle(1.0, Colors.white, mediumTextSize(context),
              FontWeight.normal, 1.0, TextDecoration.none, "Delius"),
          subtitle1: getTextStyle(1.0, Colors.grey, smallTextSize(context),
              FontWeight.w300, 1.0, TextDecoration.none, "Delius"),
          subtitle2: getTextStyle(
              1.0,
              Colors.grey.withOpacity(0.5),
              smallTextSize(context),
              FontWeight.w300,
              1.0,
              TextDecoration.none,
              "Delius"),
        ),
        appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(247, 148, 29, 1.0),
            titleTextStyle: getTextStyle(
                1.0,
                Color.fromRGBO(255, 255, 255, 1.0),
                20.0,
                FontWeight.normal,
                1.0,
                TextDecoration.none,
                "OpenSans"),
            iconTheme: IconThemeData(color: Colors.amber[300])),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        cardColor: Colors.white,
        toggleableActiveColor: Colors.green,
        toggleButtonsTheme: ToggleButtonsThemeData(
            disabledColor: Colors.grey[400], selectedColor: Colors.amber),
        buttonColor: Colors.white);
  }
}
