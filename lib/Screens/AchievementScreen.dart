import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/Shared%20Data/app_language.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:ataa/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen>
    with SingleTickerProviderStateMixin {
  late CommonData commonData;
  late AppTheme appTheme;
  late AppLanguage appLanguage;
  late double w, h;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
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
                  image: AssetImage('assets/images/1006554.png'),
                  alignment: appLanguage.alignment,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSpacing(value: 25),
                  Text(
                    'My Achievements',
                    style: appTheme.themeData.primaryTextTheme.headline4!
                        .apply(fontSizeFactor: 1.5, fontWeightDelta: 2),
                  ),
                  CustomSpacing(value: 50),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(
                        horizontal: w / 50, vertical: h / 200),
                    child: Text(
                      'Level 3/15',
                      style: appTheme.themeData.primaryTextTheme.headline3!
                          .apply(fontSizeFactor: 0.8),
                    ),
                  ),
                  TabBar(
                    tabs: [
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
                  GridView.count(
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
                                      style: appTheme
                                          .themeData.primaryTextTheme.headline6,
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
                  ),
                  Container(
                    child: Text('Badges'),
                  ),
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
