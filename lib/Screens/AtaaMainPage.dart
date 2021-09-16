import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:ataa/APICallers/MarkerApiCaller.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/GeneralInfo.dart';
import 'package:ataa/Models/UserLocation.dart';
import 'package:ataa/Session/session_manager.dart';
import 'package:ataa/Shared%20Data/app_theme.dart';
import 'package:ataa/Shared%20Data/common_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;
import 'package:ataa/Shared%20Data/app_language.dart';

import '../Helpers/DataMapper.dart';
import '../Helpers/DataMapper.dart';

class AtaaMainPage extends StatefulWidget {
  @override
  _AtaaMainPageState createState() => _AtaaMainPageState();
}

class _AtaaMainPageState extends State<AtaaMainPage> {
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  static late GoogleMap googleMap;
  final UserLocation userLocation = new UserLocation();
  late List<Marker> markers;
  bool following = false;
  static late Marker chosenMarker;
  SessionManager sessionManager = new SessionManager();
  final MarkerApiCaller markerApiCaller = new MarkerApiCaller();

  double calculateDistance(Position userLocation, LatLng endPoint) {
    int radius = 6371; // radius of earth in Km
    double dLat = math.radians(endPoint.latitude - userLocation.latitude);
    double dLon = math.radians(endPoint.longitude - userLocation.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(math.radians(userLocation.latitude)) *
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appTheme.themeData.cardColor,
          title: Text(
            "${markers[index].infoWindow.title}",
            style: appTheme.themeData.primaryTextTheme.headline4,
          ),
          content: Text(
            '${(calculateDistance(userLocation.currentLocation!, markers[index].position) * 1000).toStringAsFixed(2)} ' +
                appLanguage.words['AtaaMainAcquiringDialogOne']! +
                '\n${markers[index].infoWindow.snippet}',
            style: appTheme.themeData.primaryTextTheme.headline4,
            textDirection: appLanguage.textDirection,
          ),
          actions: [
            TextButton(
              child: Text(
                appLanguage.words['AtaaMainAcquiringActionOne']!,
                style: appTheme.themeData.primaryTextTheme.headline4!
                    .apply(color: Colors.green),
              ),
              onPressed: () {
                setState(() {
                  chosenMarker = markers[index];
                  markers.clear();
                });
                markers.add(chosenMarker);
                following = true;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                appLanguage.words['AtaaMainAcquiringActionTwo']!,
                style: appTheme.themeData.primaryTextTheme.headline4!
                    .apply(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> getGoogleMap() async {
    Completer<GoogleMapController> _controller = Completer();
    if (!await userLocation.canLocateUserLocation()) {
      return {
        "Err_Flag": true,
        "Err_Desc": appLanguage.words['AtaaMainAcquiringErrorOne']!
      };
    }
    if (!following) {
      Map<String, dynamic> status =
          await markerApiCaller.getAll(appLanguage.language);
      if (status['Err_Flag']) return status;
      DataMapper dataMapper = new DataMapper();
      markers = dataMapper.getMarkersFromJson(status['data']);
    }
    for (int i = 0; i < markers.length; i++) {
      markers[i] = markers.elementAt(i).copyWith(onTapParam: () {
        onMarkerTapped(markers.elementAt(i).markerId);
      });
    }
    return {
      "Err_Flag": false,
      "Value": googleMap = GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(userLocation.currentLocation!.latitude,
                userLocation.currentLocation!.longitude),
            zoom: 18),
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        mapToolbarEnabled: true,
      )
    };
  }

  Widget showGoogleMap() {
    return FutureBuilder<Map<String, dynamic>>(
      future: getGoogleMap(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!['Err_Flag'])
            return Container(
              alignment: Alignment.center,
              child: ErrorMessage(message: snapshot.data!['Err_Desc']),
            );
          return googleMap;
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: ErrorMessage(
                message: appLanguage.words['AtaaMainAcquiringErrorTwo']!),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CupertinoActionSheet(
              title: Text(appLanguage.words['loading']!),
              actions: [
                CupertinoActivityIndicator(
                  radius: w/10,
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
            child: ErrorMessage(message: appLanguage.words['AtaaMainError']!),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CupertinoActionSheet(
              title: Text(appLanguage.words['loading']!),
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

  Future<Widget> thanksMessage() async {
    if (!await userLocation.canLocateUserLocation()) {
      return thanksMessage();
    }
    while (calculateDistance(userLocation.currentLocation!,
                    markers.elementAt(0).position) *
                1000 >
            20 &&
        following &&
        commonData.step == Pages.AtaaMainPage.index) {
      return thanksMessage();
    }
    return AlertDialog(
      backgroundColor: appTheme.themeData.cardColor,
      title: Text(
        appLanguage.words['AtaaMainFinishingDialogOne']!,
        style: appTheme.themeData.primaryTextTheme.headline3,
      ),
      content: Text(
        appLanguage.words['AtaaMainFinishingDialogTwo']! +
            ' ${num.parse((calculateDistance(userLocation.currentLocation!, markers[0].position) * 1000).toStringAsFixed(2))} ' +
            appLanguage.words['AtaaMainFinishingDialogThree']!,
        style: appTheme.themeData.primaryTextTheme.headline4,
        textDirection: appLanguage.textDirection,
      ),
      actions: [
        TextButton(
            child: Text(appLanguage.words['AtaaMainFinishingDialogFour']!),
            onPressed: () {
              setState(() async {
                await markerApiCaller.delete(
                    appLanguage.language, markers[0].markerId.value);
                following = !following;
                commonData.back();
                return CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    lottieAsset: 'assets/animations/6951-success.json',
                    text: appLanguage.words['AtaaMainFinishingDialogFive']!,
                    confirmBtnColor: Color(0xff1c9691),
                    title: '');
              });
            }),
        TextButton(
          child: Text(
            appLanguage.words['AtaaMainFinishingDialogSix']!,
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            await markerApiCaller.delete(
                appLanguage.language, markers[0].markerId.value);
            following = !following;
            commonData.back();
            return CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                lottieAsset: 'assets/animations/6951-success.json',
                text: appLanguage.words['AtaaMainFinishingDialogSeven']!,
                confirmBtnColor: Color(0xff1c9691),
                title: '');
          },
        )
      ],
    );
  }

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
          title: Text(appLanguage.words['AtaaMainTitle']!,
              style: appTheme.themeData.primaryTextTheme.headline2),
          actions: [
            IconButton(
              icon: Icon(Icons.info, color: appTheme.themeData.iconTheme.color),
              onPressed: () async {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      backgroundColor: appTheme.themeData.cardColor,
                      title: Text(
                        appLanguage.words['VolunteerInfoTitle']!,
                        style: appTheme.themeData.primaryTextTheme.headline4!
                            .apply(fontSizeFactor: 2.0),
                        textAlign: TextAlign.center,
                        textDirection: appLanguage.textDirection,
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                              appLanguage.words['VolunteerInfoOne']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.green),
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            ),
                            Text(
                              appLanguage.words['VolunteerInfoTwo']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.blue),
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            ),
                            Text(
                              appLanguage.words['VolunteerInfoThree']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            ),
                            Text(
                              appLanguage.words['VolunteerInfoFour']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.orange),
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            ),
                            Text(
                              appLanguage.words['VolunteerInfoFive']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.headline4!
                                  .apply(color: Colors.red),
                              textAlign: TextAlign.center,
                              textDirection: appLanguage.textDirection,
                            ),
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
            )
          ],
          elevation: 0.0,
        ),
        body: Container(
          height: h,
          width: w,
          child: Stack(
            children: <Widget>[
              Container(
                child: showGoogleMap(),
              ),
              following
                  ? Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: () {
                          setState(() {
                            following = !following;
                            markers.clear();
                          });
                        },
                        child: Text(
                          appLanguage.words['AtaaMainCancelButton']!,
                          style: appTheme.themeData.primaryTextTheme.headline4!
                              .apply(color: Colors.white),
                        ),
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
          ),
        ));
  }
}
