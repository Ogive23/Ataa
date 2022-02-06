import 'package:ataa/Helpers/Helper.dart';
import 'package:ataa/Models/UserLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData extends ChangeNotifier {
  List<Marker> markers = [];
  Marker? selectedMarker;
  bool following = false;
  Helper helper = new Helper();
  UserLocation userLocation = new UserLocation();

  void setMarkers(List<Marker> markers) {
    this.markers = markers;
    notifyListeners();
  }

  void setSelectedMarker(Marker selectedMarker) {
    this.following = true;
    this.selectedMarker = selectedMarker;
    notifyListeners();
  }

  void finishFollowing() {
    this.following = false;
  }

  Future<void> addMarker(Marker marker) async {
    if (await userLocation.canLocateUserLocation()) {
      print(helper.calculateDistance(
          userLocation.currentLocation!, marker.position));
      if (helper.calculateDistance(
              userLocation.currentLocation!, marker.position) <
          100) this.markers.add(marker);
      notifyListeners();
    }
  }

  void deleteMarker(Marker marker) {
    if (selectedMarker != null && marker.markerId == selectedMarker!.markerId)
      finishFollowing();
    this.markers.removeWhere((element) => element.markerId == marker.markerId);
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
