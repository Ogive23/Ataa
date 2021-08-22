import 'package:feedme/Shared%20Data/app_language.dart';
import 'package:feedme/Shared%20Data/app_theme.dart';
import 'package:feedme/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class BackgroundScreen extends StatefulWidget {
  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  static late TabController tabController;

  Future<bool> _onWillPop(context) async {
    return commonData.lastStep()
        ? (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('هل أت متأكد؟'),
              content: new Text('هل  تريد إغلاق التطبيق'),
              actions: <Widget>[
                new TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('لا'),
                ),
                new TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('نعم'),
                ),
              ],
            ),
          ))
        : commonData.back();
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    print(commonData.step);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: pageOptions[commonData.step],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: commonData.step > Pages.SettingsScreen.index
              ? SizedBox()
              : BottomNavigationBar(
                  backgroundColor: appTheme.themeData.primaryColor,
                  selectedItemColor:
                      appTheme.themeData.toggleButtonsTheme.selectedColor,
                  unselectedItemColor:
                      appTheme.themeData.toggleButtonsTheme.disabledColor,
                  onTap: (value) => commonData.changeStep(value),
                  currentIndex: commonData.step,
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.people),
                        label: appLanguage.words['bottomNavigationItemFirst']!),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label:
                            appLanguage.words['bottomNavigationItemSecond']!),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: appLanguage.words['bottomNavigationItemThird']!),
                  ],
                  unselectedLabelStyle:
                      appTheme.themeData.primaryTextTheme.subtitle1,
                  selectedLabelStyle:
                      appTheme.themeData.primaryTextTheme.headline4,
                ),
        ),
      ),
    );
  }
}
