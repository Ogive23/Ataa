// ignore_for_file: file_names

import 'package:ataa/Helpers/Helper.dart';
import 'package:ataa/Models/UserLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData extends ChangeNotifier {
  List<Marker> markers = [];
  Marker? selectedMarker;
  bool following = false;
  Helper helper = Helper();
  UserLocation userLocation = UserLocation();

  void setMarkers(List<Marker> markers) {
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

  Future<void> addMarker(Marker marker) async {
    if (await userLocation.canLocateUserLocation()) {
      if (helper.positionIsNear(
          userLocation.currentLocation!, marker.position)) {
        markers.add(marker);
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
