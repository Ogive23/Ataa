// ignore_for_file: file_names

import 'dart:async';
import 'package:ataa/Helpers/Helper.dart';
import 'package:ataa/Helpers/NavigationService.dart';
import 'package:ataa/Helpers/Pusher.dart';
import 'package:ataa/Shared%20Data/MarkerData.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import '../Helpers/DataMapper.dart';

class AtaaMainPage extends StatefulWidget {
  const AtaaMainPage({Key? key}) : super(key: key);

  @override
  _AtaaMainPageState createState() => _AtaaMainPageState();
}

class _AtaaMainPageState extends State<AtaaMainPage> {
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  final UserLocation userLocation = UserLocation();
  static late MarkerData markerData;
  SessionManager sessionManager = SessionManager();
  final MarkerApiCaller markerApiCaller = MarkerApiCaller();
  GoogleMapController? _controller;
  LatLng initialLocation = const LatLng(29.9832678, 31.2282846);
  Pusher pusher = Pusher();
  Helper helper = Helper();

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
          return const Center(
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
        markerData.following &&
        commonData.step == Pages.AtaaMainPage.index) {
      return thanksMessage();
    }
    if (helper.calculateDistance(userLocation.currentLocation!,
                    markerData.selectedMarker!.position) *
                1000 <
            20 &&
        markerData.following &&
        commonData.step == Pages.AtaaMainPage.index) {
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
              onPressed: () async {
                await markerApiCaller.delete(appLanguage.language,
                    markerData.selectedMarker!.markerId.value);
                markerData.finishFollowing();
                commonData.back();
                return CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    lottieAsset: 'assets/animations/6951-success.json',
                    text: appLanguage.words['AtaaMainFinishingDialogFive']!,
                    confirmBtnColor: const Color(0xff1c9691),
                    title: '');
              }),
          TextButton(
            child: Text(
              appLanguage.words['AtaaMainFinishingDialogSix']!,
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              await markerApiCaller.delete(appLanguage.language,
                  markerData.selectedMarker!.markerId.value);
              markerData.finishFollowing();
              commonData.back();
              return CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  lottieAsset: 'assets/animations/6951-success.json',
                  text: appLanguage.words['AtaaMainFinishingDialogSeven']!,
                  confirmBtnColor: const Color(0xff1c9691),
                  title: '');
            },
          )
        ],
      );
    }
    return SizedBox();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      markerData = Provider.of<MarkerData>(context, listen: false);
      initMarkers();
      pusher.initPusher(markerData: markerData);
    });
  }

  Future<void> initMarkers() async {
    print('initing');
    if (await userLocation.canLocateUserLocation()) {
      initialLocation = LatLng(userLocation.currentLocation!.latitude,
          userLocation.currentLocation!.longitude);
      print(initialLocation);
      if (_controller != null) {
        await _controller!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: initialLocation, zoom: 18.00)));
        Map<String, dynamic> status = await markerApiCaller.getAll(
            appLanguage.language,
            userLocation.currentLocation!.latitude,
            userLocation.currentLocation!.longitude);
        DataMapper dataMapper = DataMapper();
        markerData.setMarkers(dataMapper.getMarkersFromJson(status['data']));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    markerData = Provider.of<MarkerData>(context);
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      home: Scaffold(
          backgroundColor: appTheme.themeData.primaryColor,
          appBar: AppBar(
            backgroundColor: appTheme.themeData.primaryColor,
            title: Text(appLanguage.words['AtaaMainTitle']!,
                style: appTheme.themeData.primaryTextTheme.headline2),
            actions: [
              IconButton(
                icon:
                    Icon(Icons.info, color: appTheme.themeData.iconTheme.color),
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
          body: SizedBox(
            height: h,
            width: w,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition:
                      CameraPosition(target: initialLocation, zoom: 18),
                  markers: markerData.following
                      ? {markerData.selectedMarker!}
                      : Set.of(markerData.markers),
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
                markerData.following
                    ? Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () {
                            setState(() {
                              markerData.finishFollowing();
                            });
                            // markerData.clear();
                          },
                          child: Text(
                            appLanguage.words['AtaaMainCancelButton']!,
                            style: appTheme
                                .themeData.primaryTextTheme.headline4!
                                .apply(color: Colors.white),
                          ),
                        ),
                      )
                    : Container(),
                markerData.following
                    ? Align(
                        alignment: Alignment.center,
                        child: getAcquiringWidget(),
                      )
                    : Container(),
              ],
            ),
          )),
    );
  }
}
