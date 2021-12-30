import 'package:ataa/APICallers/AchievementApiCaller.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrizesContainer extends StatelessWidget {
  static late double w, h;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final AchievementApiCaller achievementApiCaller = new AchievementApiCaller();
  final MemoryCache memoryCache = new MemoryCache();

  cacheData(Map<String, dynamic> data) {
    memoryCache.setData('ataaPrizes', data);
  }

  @override
  Widget build(BuildContext context) {
    memoryCache.removeData('ataaPrizes');
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return memoryCache.hasData('ataaPrizes')
        ? getSuccessBody(memoryCache.getData('ataaPrizes'))
        : FutureBuilder<Map<String, dynamic>>(
            future: achievementApiCaller.getAtaaPrizes(appLanguage.language),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                if (snapshot.data!['Err_Flag'])
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: h / 100),
                    child: ErrorMessage(message: snapshot.data!['Err_Desc']),
                  );
                cacheData(snapshot.data!);
                return getSuccessBody(snapshot.data!);
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
                    CustomSpacing(value: 50),
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

  getSuccessBody(Map<String, dynamic> prizes) {
    switch (prizes['data'].length) {
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
          children: [1, 2, 3, 4, 5, 6, 7, 8]
              .map((e) => Card(
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
                        children: [
                          Text(
                            'Level ' + e.toString(),
                            style:
                                appTheme.themeData.primaryTextTheme.headline6,
                          ),
                          Image.asset(
                            'assets/images/winner-trophy-cup-prize-award-best-first-achievement-29309.png',
                            height: h / 6,
                          ),
                          Text(
                            'Completed',
                            style: appTheme
                                .themeData.primaryTextTheme.headline3!
                                .apply(color: Colors.amber),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
    }
  }
}
