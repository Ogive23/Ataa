import 'package:feedme/API_Callers/marker_api_caller.dart';
import 'package:feedme/Custom_Widgets/text.dart';
import 'package:feedme/Custom_Widgets/text_field.dart';
import 'package:feedme/Models/user_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:toast/toast.dart';

class MarkerCreation extends StatefulWidget {
  @override
  _MarkerCreationState createState() => _MarkerCreationState();
}

class _MarkerCreationState extends State<MarkerCreation> {
  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  NumberPicker integerNumberPicker;
  List<DropdownMenuItem<int>> dropDownMenuItems;
  double quantity = 1.0;
  int priority = 1;
  List<int> priorities = [1, 3, 5, 7, 10];
  List<bool> chosenPriority = [true] + List.filled(4, false);
  String type = 'Food';
  List<String> types = ['Food', 'Drink', 'Both of them'];
  List<bool> chosenType = [true] + List.filled(2, false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Marker Creation'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info, color: Colors.white, size: 30),
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Info'),
                      content: SingleChildScrollView(child: Column(
                        children: <Widget>[
                          Text('Priorities'),
                          Text('1 : Means it won\'t get rotten (Usually Banana, honey, uncooked rice, beans, Lentil).\n'),
                          Text('3 : Means it can waits for about 5 Days before it gets rotten(Usually Bread).\n'),
                          Text('5 : Means it can waits for about 3 Days before it gets rotten(Usually Fruits).\n'),
                          Text('7 : Means it can waits for about 24 hours before it gets rotten (Usually corn).\n'),
                          Text('10 : Means it must be taken immediately & can\'t really waits for 3 hours (Usually meats, chickens, fish, milk & eggs or even cooked food).\n'),
                          // ToDo: To add notes about bag color, etc...
                          Text('Notes'),
                          Text('Note 1'),
                          Text('Note 2')
                        ],
                      ),),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('I Got it'),
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
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 20, left: 20, top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                textField(description, 'Description', Colors.black, false, null,
                    'Describe it “E.g. it\s 4 bags of meat & one cup of cooked rice”'),
                SizedBox(
                  height: 10,
                ),
                text('Priority', Colors.black, 16.0, 1.5, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                ToggleButtons(
                  color: Colors.black.withOpacity(0.5),
                  selectedColor: Colors.amber,
                  splashColor: Colors.green,
                  fillColor: Colors.red[400],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                text('Type', Colors.black, 16.0, 1.5, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                ToggleButtons(
                  color: Colors.black.withOpacity(0.5),
                  selectedColor: Colors.amber,
                  splashColor: Colors.green,
                  fillColor: Colors.red[400],
                  children: [
                    Column(
                      children: <Widget>[
                        Icon(Icons.cake),
                        Text(' Food '),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.local_drink),
                        Text(' Drink '),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.fastfood),
                        Text(' Both of them '),
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
                text('Quantity (Bags)', Colors.black, 16.0, 1.5, FontWeight.normal),
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
                  inactiveColor: Colors.black.withOpacity(0.5),
                ),
                RaisedButton(
                  child: Text('Create Marker'),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
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
                        quantity,);
                    if (status) {
                      Toast.show('Thank You!', context, duration: 7);
                      Navigator.pop(context);
                    } else {
                      Toast.show('Please fill all the required Data', context);
                    }
                  },
                ),
                SizedBox(height: 10,)
              ],
            ),
          )),
        ));
  }
}
