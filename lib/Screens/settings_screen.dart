import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Themes/app_language.dart';
import 'package:feedme/Themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    AppLanguage appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLanguage.words['SettingsTitle'],
          style: appTheme.themeData.textTheme.title,
        ),
        backgroundColor: appTheme.themeData.appBarTheme.color,
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
                    applicationName: 'FeedMe',
                    applicationVersion: '1.0.0',
                    children: <Widget>[
                      Text('Animations rights reserved to Lottie'),
                      Text('Fonts rights reserved to Google Fonts'),
                      Text('OGIVE ©2020')
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
        decoration: BoxDecoration(color: appTheme.themeData.backgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: appLanguage.language == 'En'
                    ? <Widget>[
                        Text(appLanguage.words['SettingsDarkMode'],
                            style: appTheme.themeData.textTheme.body1),
                        Switch(
                          value: appTheme.isDark,
                          activeColor: appTheme.themeData.toggleableActiveColor,
                          onChanged: (value) {
                            sessionManager.createPreferredTheme(value);
                            appTheme.changeTheme(value);
                          },
                        ),
                      ]
                    : [
                        Switch(
                          value: appTheme.isDark,
                          activeColor: appTheme.themeData.toggleableActiveColor,
                          onChanged: (value) {
                            sessionManager.createPreferredTheme(value);
                            appTheme.changeTheme(value);
                          },
                        ),
                        Text(appLanguage.words['SettingsDarkMode'],
                            style: appTheme.themeData.textTheme.body1),
                      ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: appLanguage.language == 'En'
                    ? <Widget>[
                        Text(appLanguage.words['SettingsLanguage'],
                            style: appTheme.themeData.textTheme.body1),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  'العربية',
                                  style: appTheme.themeData.textTheme.body1,
                                ),
                                value: 'Ar',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'En',
                                  style: appTheme.themeData.textTheme.body1,
                                ),
                                value: 'En',
                              )
                            ],
                            value: appLanguage.language,
                            dropdownColor: Colors.amber,
                            icon: Icon(Icons.language),
                            // style: appTheme.themeData.textTheme.body1,
                            onChanged: (value) {
                              sessionManager.createPreferredLanguage(value);
                              appLanguage.changeLanguage(value);
                            }),
                      ]
                    : <Widget>[
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  'العربية',
                                  style: appTheme.themeData.textTheme.body1,
                                ),
                                value: 'Ar',
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  'En',
                                  style: appTheme.themeData.textTheme.body1,
                                ),
                                value: 'En',
                              )
                            ],
                            value: appLanguage.language,
                            dropdownColor: Colors.amber,
                            icon: Icon(Icons.language),
                            // style: appTheme.themeData.textTheme.body1,
                            onChanged: (value) {
                              sessionManager.createPreferredLanguage(value);
                              appLanguage.changeLanguage(value);
                            }),
                        Text(appLanguage.words['SettingsLanguage'],
                            style: appTheme.themeData.textTheme.body1),
                      ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
