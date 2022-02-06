import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;

class Helper{
  bool notNull(dynamic object){
    return object != null && object != 'null';
  }

  String getAppropriateText(dynamic object) {
    return notNull(object) ? object.toString() : 'غير متوفر';
  }

  bool isNotAvailable(String text){
    return text == 'غير متوفر';
  }
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
}