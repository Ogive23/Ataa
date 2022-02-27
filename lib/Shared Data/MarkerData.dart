// ignore_for_file: file_names

import 'package:ataa/Helpers/Helper.dart';
import 'package:ataa/Helpers/NavigationService.dart';
import 'package:ataa/Models/UserLocation.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MarkerData extends ChangeNotifier {
  List<Marker> markers = [];
  Marker? selectedMarker;
  bool following = false;
  Helper helper = Helper();
  UserLocation userLocation = UserLocation();

  void setMarkers(List<Marker> markers) {
    for (int i = 0; i < markers.length; i++) {
      markers[i] = markers.elementAt(i).copyWith(onTapParam: () {
        onMarkerTapped(markers.elementAt(i).markerId);
      });
    }
    this.markers = markers;
    notifyListeners();
  }

  void setSelectedMarker(Marker selectedMarker) {
    following = true;
    this.selectedMarker = selectedMarker;
    notifyListeners();
  }

  void finishFollowing() {
    following = false;
  }

  void onMarkerTapped(MarkerId markerId) {
    Marker tappedMarker =
        markers.firstWhere((marker) => marker.markerId == markerId);
    showAlertDialog(
        tappedMarker, NavigationService.navigatorKey.currentContext!);
  }

  showAlertDialog(Marker tappedMarker, BuildContext context) async {
    AppTheme appTheme = Provider.of<AppTheme>(context, listen: false);
    AppLanguage appLanguage = Provider.of<AppLanguage>(context, listen: false);
    if (await userLocation.canLocateUserLocation()) {
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
                  setSelectedMarker(tappedMarker);
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
  }

  Future<void> addMarker(Marker marker) async {
    if (await userLocation.canLocateUserLocation()) {
      if (helper.positionIsNear(
          userLocation.currentLocation!, marker.position)) {
        markers.add(marker);
        markers.last = markers.last.copyWith(onTapParam: () {
          onMarkerTapped(marker.markerId);
        });
        notifyListeners();
      }
    }
  }

  void deleteMarker(Marker marker) {
    if (selectedMarker != null && marker.markerId == selectedMarker!.markerId) {
      finishFollowing();
    }
    markers.removeWhere((element) => element.markerId == marker.markerId);
    notifyListeners();
  }

  clear() {
    markers = [];
    notifyListeners();
  }

  void updateMarker(Marker marker) {
    deleteMarker(marker);
    addMarker(marker);
  }
}
