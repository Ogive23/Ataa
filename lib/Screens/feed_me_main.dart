import 'dart:async';
import 'package:feedme/API_Callers/marker_api_caller.dart';
import 'package:feedme/Models/user_location.dart';
import 'package:feedme/Session/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;

class FeedMe extends StatefulWidget {
  @override
  _FeedMeState createState() => _FeedMeState();
}

class _FeedMeState extends State<FeedMe> {
  GoogleMap googleMap;
  UserLocation userLocation;
  List<Marker> markers;
  bool following = false;
  Marker chosenMarker;
  SessionManager sessionManager = new SessionManager();
  MarkerApiCaller markerApiCaller = new MarkerApiCaller();
  @override
  void initState() {
    super.initState();
    userLocation = new UserLocation();
    markerApiCaller.initialize();
  }

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
    Marker tappedMarker;
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

    following
        ? 1
        : markers = await markerApiCaller.getAll();
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
          return snapshot.data;
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error ${snapshot.error}'),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text('Loading'),
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
                Toast.show(
                    'Thank You for making the world a better place!', context,
                    duration: 7, backgroundColor: Colors.green);
                await markerApiCaller.delete(markers[0].markerId.value);
                following = !following;
                Navigator.popAndPushNamed(context, 'FeedMe');
              });
            }),
        FlatButton(
          child: Text(
            "it's not found!",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() async {
              Toast.show(
                  'Sorry for wasting your time, but consider that it has gone to its place, Thank you!',
                  context,
                  duration: 7,
                  backgroundColor: Colors.green);
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
        appBar: AppBar(title: Text('Volunteering'),actions: <Widget>[IconButton(
          icon: Icon(Icons.info, color: Colors.white, size: 30),
          onPressed: () {
            return showDialog<void>(
              context: context,
              barrierDismissible: true,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('Priorities'),
                  content: SingleChildScrollView(child: Column(
                    children: <Widget>[
                      Text('Green : Means it won\'t get rotten.\n',style: TextStyle(color: Colors.green),),
                      Text('Blue : Means it can waits for about 5 Days before it gets rotten.\n',style: TextStyle(color: Colors.blue),),
                      Text('Azure : Means it can waits for about 3 Days before it gets rotten.\n',style: TextStyle(color: Colors.blueAccent),),
                      Text('Orange : Means it can waits for about 24 hours before it gets rotten.\n',style: TextStyle(color: Colors.orange),),
                      Text('Red : Means it must be taken immediately & can\'t really waits for 3 hours.\n',style: TextStyle(color: Colors.red),),
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
        )],),
        body: Stack(
          children: <Widget>[
            Container(
              child: showGoogleMap(),
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
