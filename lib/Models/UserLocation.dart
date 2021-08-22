import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation {
  late Position currentLocation;
  late LatLng latLng;
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    print('center $latLng');
  }

  LatLng getLatLng() {
    return latLng;
  }

  updateLatLng() {
    getUserLocation();
  }
}
