import 'dart:async';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  late Position? currentLocation;

  Future<Position?> _locateUser() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print('thing $e');
      return null;
    }
  }

  Future<bool> canLocateUserLocation() async {
    currentLocation = await _locateUser();
    print('thing $currentLocation');
    if (currentLocation == null) return false;
    return true;
  }
}
