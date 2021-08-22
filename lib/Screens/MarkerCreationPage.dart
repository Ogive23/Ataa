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
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class MarkerCreationPage extends StatefulWidget {
  @override
  _MarkerCreationPageState createState() => _MarkerCreationPageState();
}

class _MarkerCreationPageState extends State<MarkerCreationPage> {
  late double w,h;
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
        // backgroundColor: appTheme.themeData.backgroundColor,
        //   appBar: AppBar(
        //     backgroundColor: appTheme.themeData.appBarTheme.color,
        //     title: Text(appLanguage.words['MarkerCreationTitle'],style: TextStyle(color: appTheme.themeData.accentColor)),
        //     leading: BackButton(
        //       color: appTheme.themeData.accentColor,
        //     ),
        //     actions: <Widget>[
        //
        //     ],
        //   ),
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          decoration: BoxDecoration(
            color: appTheme.themeData.backgroundColor,
            // color: Colors.white
          ),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.info,
                        color: appTheme.themeData.accentColor, size: 30),
                    onPressed: () async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text(
                              appLanguage.words['InfoTitle']!,
                              textDirection: appLanguage.textDirection,
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    appLanguage.words['InfoSubtitle']!,
                                    textDirection: appLanguage.textDirection,
                                  ),
                                  Text(
                                    appLanguage.words['InfoOne']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    appLanguage.words['InfoTwo']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Text(
                                    appLanguage.words['InfoThree']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                  Text(
                                    appLanguage.words['InfoFour']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  Text(
                                    appLanguage.words['InfoFive']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    appLanguage.words['InfoNoteTitle']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.cyan),
                                  ),
                                  Text(
                                    appLanguage.words['InfoNoteOne']!,
                                    textDirection: appLanguage.textDirection,
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                  RichText(
                                    textDirection: appLanguage.textDirection,
                                    text: TextSpan(
                                        text: appLanguage
                                            .words['InfoNoteTwoPartOne'],
                                        children: [
                                          TextSpan(
                                              text: appLanguage
                                                  .words['InfoNoteTwoPartTwo'],
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  decoration:
                                                      TextDecoration.none),
                                              children: [
                                                TextSpan(
                                                    text: appLanguage.words[
                                                        'InfoNoteTwoPartThree'],
                                                    style: TextStyle(
                                                        color: Colors.purple))
                                              ])
                                        ],
                                        style: TextStyle(
                                            color: Colors.blue.withOpacity(0.5),
                                            decoration:
                                                TextDecoration.lineThrough)),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(appLanguage.words['InfoOkButton']!),
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
                appLanguage.words['MarkerCreationTitle']!,
                style: appTheme.themeData.textTheme.subtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: description,
                  label: appLanguage.words['MarkerCreationDescription']!,
                  selectedColor: appTheme.themeData.accentColor,
                  borderColor: appTheme.themeData.accentColor,
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  hint: appLanguage.words['MarkerCreationDescriptionDetails']!,
                  error: null,
                  width: w,
                  enableFormatters: false),
              CustomSpacing(
                value: 100,
              ),
              Text(
                appLanguage.words['MarkerCreationPriority']!,
                // appTheme.themeData.accentColor, 16.0, 1.5, FontWeight.normal
              ),
              SizedBox(
                height: 5,
              ),
              ToggleButtons(
                color: appTheme.themeData.accentColor.withOpacity(0.7),
                selectedColor: Colors.amber,
                splashColor: Colors.green,
                fillColor: Colors.red[400],
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
              SizedBox(
                height: 10,
              ),
              Text(appLanguage.words['MarkerCreationType']!,
                  // appTheme.themeData.accentColor, 16.0, 1.5, FontWeight.normal
              ),
              SizedBox(
                height: 5,
              ),
              ToggleButtons(
                color: appTheme.themeData.accentColor.withOpacity(0.5),
                selectedColor: Colors.amber,
                splashColor: Colors.green,
                fillColor: Colors.red[400],
                selectedBorderColor: appTheme.themeData.accentColor,
                borderColor: appTheme.themeData.accentColor,
                children: [
                  Column(
                    children: <Widget>[
                      Icon(Icons.cake),
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
              SizedBox(
                height: 10,
              ),
              Text(appLanguage.words['MarkerCreationQuantity']!,
                  // appTheme.themeData.accentColor, 16.0, 1.5, FontWeight.normal
              ),
              Slider(
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
                inactiveColor: appTheme.themeData.accentColor.withOpacity(0.5),
              ),
              RaisedButton(
                child:
                    Text(appLanguage.words['MarkerCreationCreateMarkerButton']!),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: Colors.amber,
                onPressed: () async {
                  UserLocation userLocation = new UserLocation();
                  if (userLocation.getLatLng() == null)
                    await userLocation.getUserLocation();
                  MarkerApiCaller markerApiCaller = new MarkerApiCaller();
                  markerApiCaller.initialize();
                  bool status = await markerApiCaller.create(
                    userLocation.getLatLng().latitude,
                    userLocation.getLatLng().longitude,
                    description.value.text,
                    priority,
                    type,
                    quantity,
                  );
                  if (status) {
                    // Toast.show('Thank You!', context, duration: 7);
                    Navigator.pop(context);
                  } else {
                    // Toast.show('Please fill all the required Data', context);
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
