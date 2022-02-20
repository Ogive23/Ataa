// ignore_for_file: file_names

import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/CommonData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../GeneralInfo.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({Key? key}) : super(key: key);

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
            builder: (context) => AlertDialog(
              backgroundColor: appTheme.themeData.cardColor,
              //ToDo: Support English
              title: Text(
                appLanguage.words['QuitDialogTitle']!,
                style: appTheme.themeData.primaryTextTheme.headline5,
              ),
              content: Text(
                appLanguage.words['QuitDialogSubtitle']!,
                style: appTheme.themeData.primaryTextTheme.headline5,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    appLanguage.words['QuitActionButtonTwo']!,
                    style: appTheme.themeData.primaryTextTheme.headline5,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
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
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: commonData.step > Pages.SettingsScreen.index
                  ? const SizedBox()
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
                            icon: const Icon(Icons.people),
                            label: appLanguage
                                .words['bottomNavigationItemFirst']!),
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.home),
                            label: appLanguage
                                .words['bottomNavigationItemSecond']!),
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.settings),
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
