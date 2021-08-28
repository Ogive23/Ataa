import 'package:ataa_lite/Shared%20Data/app_language.dart';
import 'package:ataa_lite/Shared%20Data/app_theme.dart';
import 'package:ataa_lite/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class BackgroundScreen extends StatefulWidget {
  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;

  Future<bool> _onWillPop(context) async {
    return commonData.lastStep()
        ? (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              backgroundColor: appTheme.themeData.cardColor,
              //ToDo: Support English
              title: new Text(
                appLanguage.words['QuitDialogTitle']!,
                style: appTheme.themeData.primaryTextTheme.headline5,
              ),
              content: new Text(
                appLanguage.words['QuitDialogSubtitle']!,
                style: appTheme.themeData.primaryTextTheme.headline5,
              ),
              actions: <Widget>[
                new TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    appLanguage.words['QuitActionButtonTwo']!,
                    style: appTheme.themeData.primaryTextTheme.headline5,
                  ),
                ),
                new TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text(
                    appLanguage.words['QuitActionButtonOne']!,
                    style: appTheme.themeData.primaryTextTheme.headline5!
                        .apply(color: Colors.red),
                  ),
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
    appLanguage = Provider.of<AppLanguage>(context);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Directionality(
          textDirection: appLanguage.textDirection,
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
                      selectedFontSize: appTheme
                          .themeData.primaryTextTheme.headline4!.fontSize!,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.people),
                            label: appLanguage
                                .words['bottomNavigationItemFirst']!),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: appLanguage
                                .words['bottomNavigationItemSecond']!),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings),
                            label: appLanguage
                                .words['bottomNavigationItemThird']!),
                      ],
                      unselectedLabelStyle:
                          appTheme.themeData.primaryTextTheme.subtitle1,
                      selectedLabelStyle:
                          appTheme.themeData.primaryTextTheme.headline4,
                    ),
            ),
          )),
    );
  }
}
