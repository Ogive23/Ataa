// ignore_for_file: file_names

import 'package:ataa/APICallers/AchievementApiCaller.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/CustomWidgets/PrizeContainerRow.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/Prize.dart';

class PrizesContainer extends StatelessWidget {
  static late double w, h;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final AchievementApiCaller achievementApiCaller = AchievementApiCaller();
  final MemoryCache memoryCache = MemoryCache();

  PrizesContainer({Key? key}) : super(key: key);

  cacheData(List<Prize> prizes) {
    memoryCache.setData('ataaPrizes', prizes);
  }

  @override
  Widget build(BuildContext context) {
    //ToDo: Remove
    memoryCache.removeData('ataaPrizes');
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return memoryCache.hasData('ataaPrizes')
        ? getSuccessBody(context, memoryCache.getData('ataaPrizes'))
        : FutureBuilder<Map<String, dynamic>>(
            future: achievementApiCaller.getAtaaPrizes(appLanguage.language),
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
                List<Prize> prizes =
                    dataMapper.getPrizesFromJson(snapshot.data!['data']);
                cacheData(prizes);
                return getSuccessBody(context, prizes);
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
                      'جاري تحميل الجوائز',
                      style: appTheme.themeData.primaryTextTheme.headline3,
                    )
                  ],
                );
              }
            },
          );
  }

  getSuccessBody(BuildContext context, List<Prize> prizes) {
    switch (prizes.length) {
      case 0:
        return Center(
          child: Text(
            'لا توجد جوائز حالياً',
            style: appTheme.themeData.primaryTextTheme.headline3,
          ),
        );
      default:
        return GridView.count(
          crossAxisCount: 2,
          addRepaintBoundaries: true,
          // childAspectRatio: 0.5,
          children: prizes
              .map((prize) => GestureDetector(
                    onTap: () {
                      showPrizeDialog(context, prize);
                    },
                    child: Card(
                      shape: Border.all(),
                      elevation: 1.0,
                      color: Colors.transparent,
                      shadowColor: appTheme.themeData.shadowColor,
                      // margin: EdgeInsets.symmetric(
                      //     vertical: h / 100, horizontal: w / 50),
                      child: Container(
                        height: h / 5,
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 50),
                        // color: Color.fromRGBO(20, 32, 67, 1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Level ' + prize.level.toString(),
                              style:
                                  appTheme.themeData.primaryTextTheme.headline6,
                            ),
                            if (prize.image != null)
                              CachedNetworkImage(
                                imageUrl: prize.image!,
                                height: h / 6,
                                color: prize.acquired
                                    ? null
                                    : Colors.transparent.withOpacity(0.3),
                              )
                            else
                              Image.asset(
                                'assets/images/winner-trophy-cup-prize-award-best-first-achievement-29309.png',
                                height: h / 6,
                                color: prize.acquired
                                    ? null
                                    : Colors.transparent.withOpacity(0.3),
                              ),
                            Text(
                              prize.active
                                  ? prize.acquired
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

  Future<void> showPrizeDialog(context, Prize prize) {
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
              prize.name,
              style: appTheme.themeData.primaryTextTheme.headline4,
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (prize.image != null)
                      CachedNetworkImage(
                        imageUrl: prize.image!,
                        height: h / 6,
                        color: prize.acquired
                            ? null
                            : Colors.white.withOpacity(0.8),
                      )
                    else
                      Image.asset(
                        'assets/images/winner-trophy-cup-prize-award-best-first-achievement-29309.png',
                        height: h / 6,
                        color: prize.acquired
                            ? null
                            : Colors.white.withOpacity(0.3),
                      ),
                    PrizeContainerRow(
                      firstWord: 'Required Markers Collected',
                      secondWord: prize.requiredMarkersCollected.toString(),
                    ),
                    PrizeContainerRow(
                      firstWord: 'Required Markers Posted',
                      secondWord: prize.requiredMarkersPosted.toString(),
                    ),
                    PrizeContainerRow(
                      firstWord: 'From',
                      secondWord: prize.from != null
                          ? DateFormat('yyyy-MM-dd').format(prize.from!)
                          : 'N/A',
                    ),
                    PrizeContainerRow(
                      firstWord: 'To',
                      secondWord: prize.to != null
                          ? DateFormat('yyyy-MM-dd').format(prize.to!)
                          : 'N/A',
                    ),
                    PrizeContainerRow(
                      firstWord: 'Status',
                      secondWord: prize.active ? 'Active' : 'Not Active',
                    ),
                    PrizeContainerRow(
                      firstWord: 'Acquired',
                      secondWord: prize.acquired
                          ? 'Acquired ' +
                              DateFormat('yyyy-MM-dd').format(prize.acquiredAt!)
                          : 'Not Acquired',
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
