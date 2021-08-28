import 'package:ataa/Session/session_manager.dart';
import 'package:ataa/Shared%20Data/app_language.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static late double w, h;
  final SessionManager sessionManager = new SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        elevation: 0.0,
        title: Text(
          appLanguage.words['SettingsTitle']!,
          style: appTheme.themeData.primaryTextTheme.headline2,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info,
              color: appTheme.themeData.iconTheme.color,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AboutDialog(
                    applicationName: 'Ataa',
                    applicationVersion: '1.0.0',
                    //ToDo: Make it Ataa icon
                    applicationIcon: Image.asset(
                      'assets/images/ogive_version_2.png',
                      width: w / 20,
                    ),
                    children: <Widget>[
                      Text('Animations rights reserved to Lottie'),
                      Text('Fonts rights reserved to Google Fonts'),
                      Text('OGIVE ©${DateTime.now().year}')
                    ],
                  );
                },
              );
            },
            tooltip: 'License',
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(appLanguage.words['SettingsDarkMode']!,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                    style: appTheme.themeData.primaryTextTheme.headline4),
                Switch(
                  value: appTheme.isDark,
                  activeColor: appTheme.themeData.toggleableActiveColor,
                  onChanged: (value) {
                    sessionManager.createPreferredTheme(value);
                    appTheme.changeTheme(value, context);
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(appLanguage.words['SettingsLanguage']!,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                    style: appTheme.themeData.primaryTextTheme.headline4),
                DropdownButton(
                    items: [
                      DropdownMenuItem(
                        child: Text('العربية',
                            textAlign: TextAlign.center,
                            textDirection: appLanguage.textDirection,
                            style: appTheme
                                .themeData.primaryTextTheme.headline4!
                                .apply(fontSizeFactor: 0.7)),
                        value: 'Ar',
                      ),
                      DropdownMenuItem(
                        child: Text('English',
                            textAlign: TextAlign.center,
                            textDirection: appLanguage.textDirection,
                            style: appTheme
                                .themeData.primaryTextTheme.headline4!
                                .apply(fontSizeFactor: 0.7)),
                        value: 'En',
                      )
                    ],
                    value: appLanguage.language,
                    dropdownColor: appTheme.themeData.cardColor,
                    // style: appTheme.themeData.textTheme.body1,
                    onChanged: (String? value) {
                      sessionManager.createPreferredLanguage(value!);
                      appLanguage.changeLanguage(value);
                    }),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
