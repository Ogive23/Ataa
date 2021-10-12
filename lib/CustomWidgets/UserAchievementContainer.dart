import 'dart:ui';

import 'package:ataa/APICallers/UserApiCaller.dart';
import 'package:ataa/Session/session_manager.dart';
import 'package:ataa/Shared%20Data/app_language.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:ataa/Shared%20Data/common_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CustomSpacing.dart';
import 'ErrorMessage.dart';

class UserAchievementContainer extends StatelessWidget {
  static late double w, h;
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final UserApiCaller userApiCaller = new UserApiCaller();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return FutureBuilder<Map<String, dynamic>>(
      future: userApiCaller.getAchievements(appLanguage.language),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!['Err_Flag'])
            return Container(
              alignment: Alignment.center,
              child: ErrorMessage(message: snapshot.data!['Err_Desc']),
            );
          return getSuccessBody(snapshot.data);
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: ErrorMessage(
                message: appLanguage.words['AtaaMainAcquiringErrorTwo']!),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CupertinoActionSheet(
              title: Text(appLanguage.words['loading']!),
              actions: [
                CupertinoActivityIndicator(
                  radius: w / 10,
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget getSuccessBody(Map<String, dynamic>? achievements) {
    return ClipRRect(
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
                        style: appTheme.themeData.primaryTextTheme.headline4,
                        textAlign: TextAlign.center,
                        textDirection: appLanguage.textDirection,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                achievements!['data']['markers_collected'],
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4,
                                textAlign: TextAlign.center,
                                textDirection: appLanguage.textDirection,
                              ),
                              Text(appLanguage.words['AchievementCenterTwo']!,
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline4!
                                      .apply(fontSizeFactor: 0.5),
                                  textAlign: TextAlign.center,
                                  textDirection: appLanguage.textDirection)
                            ],
                          ),
                          Text(
                            appLanguage.words['AchievementCenterThree']!,
                            style: appTheme
                                .themeData.primaryTextTheme.headline4!
                                .apply(fontSizeFactor: 1.5),
                            textAlign: TextAlign.center,
                            textDirection: appLanguage.textDirection,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                achievements['data']['markers_posted'],
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4,
                                textAlign: TextAlign.center,
                                textDirection: appLanguage.textDirection,
                              ),
                              Text(
                                appLanguage.words['AchievementCenterFour']!,
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4!
                                    .apply(fontSizeFactor: 0.5),
                                textAlign: TextAlign.center,
                                textDirection: appLanguage.textDirection,
                              ),
                            ],
                          ),
                        ],
                      ),
                      CustomSpacing(value: 50),
                      Text.rich(
                        TextSpan(
                            text: appLanguage.words['AchievementCenterFive'],
                            children: [
                              TextSpan(
                                text: achievements['data']['current_level'],
                                style: appTheme
                                    .themeData.primaryTextTheme.headline4!
                                    .apply(color: Colors.green),
                              )
                            ]),
                        style: appTheme.themeData.primaryTextTheme.headline4,
                        textAlign: TextAlign.center,
                        textDirection: appLanguage.textDirection,
                      ),
                      CustomSpacing(value: 50),
                      achievements['data']['latest_badge'] != null
                          ? Text.rich(
                              TextSpan(
                                  text:
                                      appLanguage.words['AchievementCenterSix'],
                                  children: [
                                    TextSpan(
                                      text: achievements['data']
                                          ['latest_badge'],
                                      style: appTheme
                                          .themeData.primaryTextTheme.headline4!
                                          .apply(color: Colors.green),
                                    )
                                  ]),
                              style:
                                  appTheme.themeData.primaryTextTheme.headline4,
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            )
                          : Text(
                              appLanguage.words['AchievementCenterSeven']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.red[300]),
                            ),
                      CustomSpacing(value: 50),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          appLanguage.words['AchievementCenterEight']!,
                          style: appTheme.themeData.primaryTextTheme.headline5!
                              .apply(color: Colors.blue[300]),
                          textAlign: TextAlign.center,
                          textDirection: appLanguage.textDirection,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}