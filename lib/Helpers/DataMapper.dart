import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ataa_lite/Models/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Helper.dart';

class DataMapper {
  Helper helper = new Helper();
  getMarkerColor(priority) {
    switch (priority) {
      case '1':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case '3':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case '5':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      case '7':
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      case '10':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  List<Marker> getMarkersFromSnapshot(QuerySnapshot snapShot) {
//  MarkerIcon markerOption = new MarkerIcon();      ///for custom marker icon
    List<Marker> returnedMarkers = <Marker>[];
    snapShot.docs.forEach((marker) {
      returnedMarkers.add(Marker(
        markerId: new MarkerId(marker.id.toString()),
        position: LatLng(double.parse(marker.get('latitude').toString()),
            double.parse(marker.get('longitude').toString())),
//      icon: markerOption.getIcon(),
        icon: getMarkerColor(marker.get('priority').toString()),
        infoWindow: InfoWindow(
            title: marker.get('type').toString(),
            snippet: marker.get('description').toString() +
                ' \nQuantity = ${double.parse(marker.get('quantity').toString()).toInt()} bags'),
      ));
    });
    return returnedMarkers;
  }
  User getUserFromJson(String url, Map<String, dynamic> info) {
    return User(
        helper.getAppropriateText(info['user']['id']),
        helper.getAppropriateText(info['user']['name'].toString()),
        helper.getAppropriateText(info['user']['user_name'].toString()),
        helper.getAppropriateText(info['user']['email'].toString()),
        helper.getAppropriateText(info['user']['gender'].toString()),
        helper.getAppropriateText(info['user']['phone_number'].toString()),
        helper.getAppropriateText(info['user']['address'].toString()),
        info['user']['email_verified_at'] != null ? true : false,
        info['token'],
        info['profile']['image'] != null
            ? url + info['profile']['image']
            : 'N/A',
        info['profile']['cover'] != null
            ? url + info['profile']['cover']
            : 'N/A',
        helper.getAppropriateText(info['profile']['bio'].toString()));
  }
}
