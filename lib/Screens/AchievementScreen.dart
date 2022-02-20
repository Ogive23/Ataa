// ignore_for_file: file_names

import 'package:ataa/CustomWidgets/BadgesContainer.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/PrizesContainer.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen>
    with SingleTickerProviderStateMixin {
  late AppTheme appTheme;
  late AppLanguage appLanguage;
  late double w, h;
  late TabController tabController;
  MemoryCache memoryCache = MemoryCache();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return SafeArea(
      child: Container(
        color: appTheme.themeData.primaryColor,
        child: Column(
          children: [
            Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: w / 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blueAccent,
                  Colors.deepPurpleAccent.withOpacity(0.5),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                image: DecorationImage(
                  image: const AssetImage('assets/images/1006554.png'),
                  alignment: appLanguage.alignment,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomSpacing(value: 25),
                  Text(
                    'My Achievements',
                    style: appTheme.themeData.primaryTextTheme.headline4!
                        .apply(fontSizeFactor: 1.5, fontWeightDelta: 2),
                  ),
                  const CustomSpacing(value: 50),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(
                        horizontal: w / 50, vertical: h / 200),
                    child: memoryCache.hasData('userAchievement')
                        ? Text(
                            'Level ' +
                                memoryCache
                                    .getData('userAchievement')['data']
                                        ['current_level']
                                    .toString(),
                            style: appTheme
                                .themeData.primaryTextTheme.headline3!
                                .apply(fontSizeFactor: 0.8),
                          )
                        : const SizedBox(),
                  ),
                  TabBar(
                    tabs: const [
                      Tab(
                        child: Text('Prizes'),
                      ),
                      Tab(
                        child: Text('Badges'),
                      ),
                    ],
                    controller: tabController,
                    labelStyle: appTheme.themeData.primaryTextTheme.headline5,
                    unselectedLabelStyle:
                        appTheme.themeData.primaryTextTheme.headline6,
                    labelColor: Colors.yellow,
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PrizesContainer(),
                  BadgesContainer(),
                ],
                controller: tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
