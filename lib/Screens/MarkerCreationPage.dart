import 'package:cool_alert/cool_alert.dart';
import 'package:feedme/APICallers/MarkerApiCaller.dart';
import 'package:feedme/CustomWidgets/CustomSpacing.dart';
import 'package:feedme/CustomWidgets/CustomTextField.dart';
import 'package:feedme/Models/UserLocation.dart';
import 'package:feedme/Shared%20Data/app_language.dart';
import 'package:feedme/Shared%20Data/app_theme.dart';
import 'package:feedme/Shared%20Data/common_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class MarkerCreationPage extends StatefulWidget {
  @override
  _MarkerCreationPageState createState() => _MarkerCreationPageState();
}

class _MarkerCreationPageState extends State<MarkerCreationPage> {
  late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;

  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  late NumberPicker integerNumberPicker;
  late List<DropdownMenuItem<int>> dropDownMenuItems;
  double quantity = 1.0;
  int priority = 1;
  List<int> priorities = [1, 3, 5, 7, 10];
  List<bool> chosenPriority = [true] + List.filled(4, false);
  String type = 'Food';
  List<String> types = ['Food', 'Drink', 'Both of them'];
  List<bool> chosenType = [true] + List.filled(2, false);

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        backgroundColor: appTheme.themeData.primaryColor,
        appBar: AppBar(
          backgroundColor: appTheme.themeData.primaryColor,
          title: Text(appLanguage.words['MarkerCreationTitle']!,
              style: appTheme.themeData.primaryTextTheme.headline2),
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: w / 25),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.info,
                            color: appTheme.themeData.iconTheme.color),
                        onPressed: () async {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                backgroundColor: appTheme.themeData.cardColor,
                                title: Text(
                                  appLanguage.words['InfoTitle']!,
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline4!
                                      .apply(fontSizeFactor: 2.0),
                                  textAlign: TextAlign.center,
                                  textDirection: appLanguage.textDirection,
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        appLanguage.words['InfoSubtitle']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(fontSizeFactor: 1.5),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoOne']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.green),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoTwo']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.blue),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoThree']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.blueAccent),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoFour']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.orange),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoFive']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.red),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoNoteTitle']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.cyan),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      Text(
                                        appLanguage.words['InfoNoteOne']!,
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.yellow),
                                        textAlign: TextAlign.center,
                                        textDirection:
                                            appLanguage.textDirection,
                                      ),
                                      RichText(
                                        textDirection:
                                            appLanguage.textDirection,
                                        text: TextSpan(
                                            text: appLanguage
                                                .words['InfoNoteTwoPartOne'],
                                            children: [
                                              TextSpan(
                                                  text: appLanguage.words[
                                                      'InfoNoteTwoPartTwo'],
                                                  style: appTheme
                                                      .themeData
                                                      .primaryTextTheme
                                                      .headline4!
                                                      .apply(
                                                          color: Colors.green),
                                                  children: [
                                                    TextSpan(
                                                      text: appLanguage.words[
                                                          'InfoNoteTwoPartThree'],
                                                      style: appTheme
                                                          .themeData
                                                          .primaryTextTheme
                                                          .headline4!
                                                          .apply(
                                                              color: Colors
                                                                  .purple),
                                                    )
                                                  ])
                                            ],
                                            style: appTheme.themeData
                                                .primaryTextTheme.headline4!
                                                .apply(
                                                    color: Colors.blue
                                                        .withOpacity(0.5),
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                      )
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                        appLanguage.words['InfoOkButton']!),
                                    onPressed: () {
                                      Navigator.of(dialogContext)
                                          .pop(); // Dismiss alert dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )),
                  Text(
                    appLanguage.words['MarkerCreationSubtitle']!,
                    style: appTheme.themeData.primaryTextTheme.headline4,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                  ),
                  CustomSpacing(
                    value: 50,
                  ),
                  CustomTextField(
                      controller: description,
                      label: appLanguage.words['MarkerCreationDescription']!,
                      selectedColor: appTheme.themeData.accentColor,
                      borderColor: appTheme.themeData.accentColor,
                      obscureText: false,
                      keyboardType: TextInputType.multiline,
                      hint: appLanguage
                          .words['MarkerCreationDescriptionDetails']!,
                      error: null,
                      width: w,
                      maxLines: 3,
                      enableFormatters: false),
                  CustomSpacing(
                    value: 100,
                  ),
                  Text(
                    appLanguage.words['MarkerCreationPriority']!,
                    style: appTheme.themeData.primaryTextTheme.headline3,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                    // appTheme.themeData.accentColor, 16.0, 1.5, FontWeight.normal
                  ),
                  CustomSpacing(
                    value: 200,
                  ),
                  ToggleButtons(
                    color:
                        appTheme.themeData.primaryTextTheme.subtitle1!.color!,
                    selectedColor: Colors.amber,
                    splashColor: Colors.green,
                    fillColor: appTheme.themeData.accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderColor: appTheme.themeData.accentColor,
                    selectedBorderColor: appTheme.themeData.accentColor,
                    children: List.generate(priorities.length,
                        (index) => Text(priorities[index].toString())),
                    isSelected: chosenPriority,
                    onPressed: (index) {
                      setState(() {
                        chosenPriority = List.filled(5, false);
                        priority = priorities[index];
                        chosenPriority[index] = true;
                      });
                    },
                  ),
                  CustomSpacing(
                    value: 100,
                  ),
                  Text(
                    appLanguage.words['MarkerCreationType']!,
                    style: appTheme.themeData.primaryTextTheme.headline3,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                  ),
                  CustomSpacing(
                    value: 200,
                  ),
                  ToggleButtons(
                    color:
                        appTheme.themeData.primaryTextTheme.subtitle1!.color!,
                    selectedColor: Colors.amber,
                    splashColor: Colors.green,
                    fillColor: appTheme.themeData.accentColor,
                    selectedBorderColor: appTheme.themeData.accentColor,
                    borderColor: appTheme.themeData.accentColor,
                    children: [
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.hamburger),
                          Text(appLanguage.words['MarkerCreationFood']!),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.local_drink),
                          Text(appLanguage.words['MarkerCreationDrink']!),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.fastfood),
                          Text(appLanguage.words['MarkerCreationBoth']!),
                        ],
                      ),
                    ],
                    isSelected: chosenType,
                    onPressed: (index) {
                      setState(() {
                        chosenType = List.filled(3, false);
                        type = types[index];
                        chosenType[index] = true;
                      });
                    },
                  ),
                  CustomSpacing(
                    value: 100,
                  ),
                  Text(
                    appLanguage.words['MarkerCreationQuantity']!,
                    style: appTheme.themeData.primaryTextTheme.headline3,
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Slider(
                      value: quantity,
                      min: 1.0,
                      max: 10,
                      onChanged: (double value) {
                        setState(() {
                          quantity = value;
                        });
                      },
                      divisions: 9,
                      label: '${quantity.toInt()}',
                      activeColor: Colors.amber,
                      inactiveColor:
                          appTheme.themeData.accentColor.withOpacity(0.5),
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                        appLanguage.words['MarkerCreationCreateMarkerButton']!),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                    onPressed: () async {
                      UserLocation userLocation = new UserLocation();
                      if (!await userLocation.canLocateUserLocation())
                        return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            lottieAsset: 'assets/animations/38213-error.json',
                            text: appLanguage
                                .words['MarkerCreationLocationError'],
                            confirmBtnColor: Color(0xff1c9691),
                            title: '');
                      MarkerApiCaller markerApiCaller = new MarkerApiCaller();
                      markerApiCaller.initialize();
                      bool status = await markerApiCaller.create(
                        userLocation.currentLocation!.latitude,
                        userLocation.currentLocation!.longitude,
                        description.value.text,
                        priority,
                        type,
                        quantity,
                      );
                      if (status) {
                        commonData.back();
                        return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            lottieAsset: 'assets/animations/6951-success.json',
                            text:
                                appLanguage.words['MarkerCreationSuccessText'],
                            confirmBtnColor: Color(0xff1c9691),
                            title: '');
                      } else {
                        commonData.back();
                        return CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            lottieAsset: 'assets/animations/38213-error.json',
                            text: appLanguage.words['MarkerCreationFailText'],
                            confirmBtnColor: Color(0xff1c9691),
                            title: '');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ))),
        ));
  }
}
