import 'dart:async';
import 'package:feedme/APICallers/MarkerApiCaller.dart';
import 'package:feedme/Models/UserLocation.dart';
import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Shared%20Data/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;
import 'package:feedme/Shared%20Data/app_language.dart';

class FeedMeMainPage extends StatefulWidget {
  @override
  _FeedMeMainPageState createState() => _FeedMeMainPageState();
}

class _FeedMeMainPageState extends State<FeedMeMainPage> {
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  static late GoogleMap googleMap;
  final UserLocation userLocation = new UserLocation();
  static late List<Marker> markers;
  bool following = false;
  static late Marker chosenMarker;
  SessionManager sessionManager = new SessionManager();
  final MarkerApiCaller markerApiCaller = new MarkerApiCaller();

  double calculateDistance(LatLng startPoint, LatLng endPoint) {
    int radius = 6371; // radius of earth in Km
    double dLat = math.radians(endPoint.latitude - startPoint.latitude);
    double dLon = math.radians(endPoint.longitude - startPoint.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(math.radians(startPoint.latitude)) *
            cos(math.radians(endPoint.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * asin(sqrt(a));
    return radius * c;
  }

  void onMarkerTapped(MarkerId markerId) {
    late Marker? tappedMarker;
    int i = 0;
    for (; i < markers.length; i++) {
      if (markerId == markers.elementAt(i).markerId) {
        tappedMarker = markers.elementAt(i);
        break;
      }
    }
    if (tappedMarker != null) {
      showAlertDialog(i);
    }
  }

  showAlertDialog(index) {
    // set up the buttons
    Widget launchButton = FlatButton(
      child: Text("Go And Get IT!"),
      onPressed: () {
        setState(() {
          chosenMarker = markers[index];
          markers.clear();
        });
        markers.add(chosenMarker);
        following = true;
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("${markers[index].infoWindow.title}"),
      content: Text(
        '${(calculateDistance(userLocation.getLatLng(), markers[index].position) * 1000).toStringAsFixed(2)} meter to get it' +
            '\n${markers[index].infoWindow.snippet}',
      ),
      actions: [
        launchButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<GoogleMap> getGoogleMap() async {
    Completer<GoogleMapController> _controller = Completer();
    if (userLocation.getLatLng() == null) {
      await userLocation.getUserLocation();
    }

    following ? 1 : markers = await markerApiCaller.getAll();
    for (int i = 0; i < markers.length; i++) {
      markers[i] = markers.elementAt(i).copyWith(onTapParam: () {
        onMarkerTapped(markers.elementAt(i).markerId);
      });
    }
    return googleMap = GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(userLocation.getLatLng().latitude,
              userLocation.getLatLng().longitude),
          zoom: 18),
      markers: Set<Marker>.of(markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
      mapToolbarEnabled: true,
    );
  }

  Widget showGoogleMap() {
    return FutureBuilder<GoogleMap>(
      future: getGoogleMap(),
      builder: (BuildContext context, AsyncSnapshot<GoogleMap> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return googleMap;
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                'Error Showing Google map, Please Restart ${snapshot.error}'),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CupertinoActionSheet(
              title: Text('Loading'),
              actions: [
                CupertinoActivityIndicator(
                  radius: 50,
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget getAcquiringWidget() {
    return FutureBuilder<Widget>(
      future: thanksMessage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Container(child: snapshot.data);
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error ${snapshot.error}'),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text(''),
          );
        }
      },
    );
  }

  Future<Widget> thanksMessage() async {
    if (userLocation.getLatLng() == null) {
      await userLocation.getUserLocation();
    }
    while (calculateDistance(
                userLocation.getLatLng(), markers.elementAt(0).position) *
            1000 >
        20) {
      await userLocation.getUserLocation();
    }
    return AlertDialog(
      title: Text("Did you got it?"),
      content: Text(
          'it seems that you are ${num.parse((calculateDistance(userLocation.getLatLng(), markers[0].position) * 1000).toStringAsFixed(2))} Meter away from.'),
      actions: [
        FlatButton(
            child: Text("Yes i got it!"),
            onPressed: () {
              setState(() async {
                // Toast.show(
                //     'Thank You for making the world a better place!', context,
                //     duration: 7, backgroundColor: Colors.green);
                await markerApiCaller.delete(markers[0].markerId.value);
                following = !following;
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route is PageRoute);
                Navigator.pushNamed(context, "Background");
              });
            }),
        FlatButton(
          child: Text(
            "it's not found!",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() async {
              // Toast.show(
              //     'Sorry for wasting your time, but consider that it has gone to its place, Thank you!',
              //     context,
              //     duration: 7,
              //     backgroundColor: Colors.green);
              await markerApiCaller.delete(markers[0].markerId.value);
              following = !following;
              Navigator.popAndPushNamed(context, 'FeedMe');
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('Volunteering'),actions: <Widget>[
        //   ],),
        body: Stack(
      children: <Widget>[
        Container(
          child: showGoogleMap(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.info, color: Colors.black, size: 30),
            onPressed: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: true,
                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(
                      appLanguage.words['VolunteerInfoTitle']!,
                      textDirection: appLanguage.textDirection,
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            appLanguage.words['VolunteerInfoOne']!,
                            style: TextStyle(color: Colors.green),
                            textDirection: appLanguage.textDirection,
                          ),
                          Text(
                            appLanguage.words['VolunteerInfoTwo']!,
                            style: TextStyle(color: Colors.blue),
                            textDirection: appLanguage.textDirection,
                          ),
                          Text(
                            appLanguage.words['VolunteerInfoThree']!,
                            style: TextStyle(color: Colors.blueAccent),
                            textDirection: appLanguage.textDirection,
                          ),
                          Text(
                            appLanguage.words['VolunteerInfoFour']!,
                            style: TextStyle(color: Colors.orange),
                            textDirection: appLanguage.textDirection,
                          ),
                          Text(
                            appLanguage.words['VolunteerInfoFive']!,
                            style: TextStyle(color: Colors.red),
                            textDirection: appLanguage.textDirection,
                          ),
                        ],
                      ),
                    ),
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
          ),
        ),
        following
            ? Align(
                alignment: Alignment.topRight,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      following = !following;
                      markers.clear();
                    });
                  },
                  child: Text('Cancel'),
                ),
              )
            : Container(),
        following
            ? Align(
                alignment: Alignment.center,
                child: getAcquiringWidget(),
              )
            : Container(),
      ],
    ));
  }
}
