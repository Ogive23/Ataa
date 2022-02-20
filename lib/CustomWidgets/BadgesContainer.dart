// ignore_for_file: file_names

import 'package:ataa/APICallers/AchievementApiCaller.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Models/Badge.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgesContainer extends StatelessWidget {
  static late double w, h;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final AchievementApiCaller achievementApiCaller = AchievementApiCaller();
  final MemoryCache memoryCache = MemoryCache();

  BadgesContainer({Key? key}) : super(key: key);

  cacheData(List<Badge> badges) {
    memoryCache.setData('ataaBadges', badges);
  }

  @override
  Widget build(BuildContext context) {
    //ToDo: Remove
    memoryCache.removeData('ataaBadges');
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return memoryCache.hasData('ataaBadges')
        ? getSuccessBody(context, memoryCache.getData('ataaBadges'))
        : FutureBuilder<Map<String, dynamic>>(
            future: achievementApiCaller.getAtaaBadges(appLanguage.language),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                if (snapshot.data!['Err_Flag']) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: h / 100),
                    child: ErrorMessage(message: snapshot.data!['Err_Desc']),
                  );
                }
                DataMapper dataMapper = DataMapper();
                List<Badge> badges =
                    dataMapper.getBadgesFromJson(snapshot.data!['data']);
                cacheData(badges);
                return getSuccessBody(context, badges);
              } else if (snapshot.error != null) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: h / 100),
                  child: ErrorMessage(
                      message: appLanguage.words['AtaaMainAcquiringErrorTwo']!),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      radius: w / 10,
                    ),
                    const CustomSpacing(value: 50),
                    Text(
                      'جاري تحميل الشارات',
                      style: appTheme.themeData.primaryTextTheme.headline3,
                    )
                  ],
                );
              }
            },
          );
  }

  getSuccessBody(BuildContext context, List<Badge> badges) {
    switch (badges.length) {
      case 0:
        return Center(
          child: Text(
            'لا توجد شارات حالياً',
            style: appTheme.themeData.primaryTextTheme.headline3,
          ),
        );
      default:
        return GridView.count(
          crossAxisCount: 2,
          addRepaintBoundaries: true,
          children: badges
              .map((badge) => GestureDetector(
                    onTap: () {
                      showBadgeDialog(context, badge);
                    },
                    child: Card(
                      shape: Border.all(),
                      elevation: 1.0,
                      color: Colors.transparent,
                      shadowColor: appTheme.themeData.shadowColor,
                      child: Container(
                        height: h / 5,
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              badge.name.toString(),
                              style:
                                  appTheme.themeData.primaryTextTheme.headline6,
                            ),
                            CachedNetworkImage(
                              imageUrl: badge.image,
                              height: h / 7,
                              color: badge.acquired
                                  ? null
                                  : Colors.transparent.withOpacity(0.3),
                            ),
                            Text(
                              badge.active
                                  ? badge.acquired
                                      ? 'Acquired'
                                      : 'On going'
                                  : 'Inactive',
                              style: appTheme
                                  .themeData.primaryTextTheme.headline3!
                                  .apply(color: Colors.amber),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        );
    }
  }

  Future<void> showBadgeDialog(context, Badge badge) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Directionality(
          textDirection: appLanguage.textDirection,
          child: AlertDialog(
            backgroundColor: appTheme.themeData.primaryColor,
            insetPadding:
                EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 10),
            contentPadding: EdgeInsets.zero,
            title: Text(
              badge.name,
              style: appTheme.themeData.primaryTextTheme.headline4,
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: badge.image,
                      height: h / 6,
                      color:
                          badge.acquired ? null : Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("حسناً",
                    textDirection: appLanguage.textDirection,
                    style: appTheme.themeData.primaryTextTheme.headline4),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        appTheme.themeData.colorScheme.secondary)),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
