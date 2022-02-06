import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:ataa/APICallers/MarkerApiCaller.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/GeneralInfo.dart';
import 'package:ataa/Models/UserLocation.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/CommonData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;
import 'package:ataa/Shared%20Data/AppLanguage.dart';
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
  final UserLocation userLocation = new UserLocation();
  List<Marker> markers = [];
  bool following = false;
  SessionManager sessionManager = new SessionManager();
  final MarkerApiCaller markerApiCaller = new MarkerApiCaller();
  GoogleMapController? _controller;
  LatLng initialLocation = LatLng(29.9832678, 31.2282846);
  Helper helper = new Helper();

  void onMarkerTapped(MarkerId markerId) {
    Marker tappedMarker = markers.firstWhere((marker) => marker.markerId == markerId);
    showAlertDialog(tappedMarker);
  }

  showAlertDialog(Marker tappedMarker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appTheme.themeData.cardColor,
          title: Text(
            "${tappedMarker.infoWindow.title}",
            style: appTheme.themeData.primaryTextTheme.headline4,
          ),
          content: Text(
            '${(helper.calculateDistance(userLocation.currentLocation!, tappedMarker.position) * 1000).toStringAsFixed(2)} ' +
                appLanguage.words['AtaaMainAcquiringDialogOne']! +
                '\n${tappedMarker.infoWindow.snippet}',
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
                  markers.clear();
                  markers.add(tappedMarker);
                  following = true;
                });
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
          return Center(
              child: CupertinoActivityIndicator(
            radius: 50,
          ));
        }
      },
    );
  }

  Future<Widget> thanksMessage() async {
    if (!await userLocation.canLocateUserLocation()) {
      return thanksMessage();
    }
    while (helper.calculateDistance(userLocation.currentLocation!,
                    markerData.selectedMarker!.position) *
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
            ' ${num.parse((helper.calculateDistance(userLocation.currentLocation!, markerData.selectedMarker!.position) * 1000).toStringAsFixed(2))} ' +
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
  void initState() {
    super.initState();
    initMarkers();
  }

  Future<void> initMarkers() async {
    print('initing');
    if (await userLocation.canLocateUserLocation()) {
      initialLocation = LatLng(userLocation.currentLocation!.latitude,
          userLocation.currentLocation!.longitude);
      print(initialLocation);
      if (_controller != null) {
        await _controller!.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(target: initialLocation, zoom: 18.00)));
        Map<String, dynamic> status = await markerApiCaller.getAll(
            appLanguage.language,
            userLocation.currentLocation!.latitude,
            userLocation.currentLocation!.longitude);
        if (status['Err_Flag'] && !following)
          return await Future.delayed(
              Duration(seconds: 5), () => initMarkers());
        DataMapper dataMapper = new DataMapper();
        markers = dataMapper.getMarkersFromJson(status['data']);
        for (int i = 0; i < markers.length; i++) {
          markers[i] = markers.elementAt(i).copyWith(onTapParam: () {
            onMarkerTapped(markers.elementAt(i).markerId);
          });
        }
        setState(() {});
      }
    }
    if (mounted && !following)
      await Future.delayed(Duration(seconds: 5), () => initMarkers());
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
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: initialLocation, zoom: 18),
                markers: Set.of(markers),
                onMapCreated: (GoogleMapController controller) async {
                  if (appTheme.isDark) {
                    String value = await DefaultAssetBundle.of(context)
                        .loadString('assets/dark.json');
                    controller.setMapStyle(value);
                  }
                  _controller = controller;
                },
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                mapToolbarEnabled: true,
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
