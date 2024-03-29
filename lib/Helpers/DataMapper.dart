// ignore_for_file: file_names

import 'package:ataa/GeneralInfo.dart';
import 'package:ataa/Models/Prize.dart';
import 'package:ataa/Models/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/Prize.dart';
import '../Models/Badge.dart';
import 'Helper.dart';

class DataMapper {
  Helper helper = Helper();
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

  Marker getMarkerFromJson(Map<String, dynamic> data) {
    return Marker(
      markerId: MarkerId(data['id'].toString()),
      position: LatLng(double.parse(data['latitude'].toString()),
          double.parse(data['longitude'].toString())),
      icon: getMarkerColor(data['priority'].toString()),
      infoWindow: InfoWindow(
          title: data['type'].toString(),
          snippet: data['description'].toString() +
              ' \nQuantity = ${double.parse(data['quantity'].toString()).toInt()} bags'),
    );
  }

  List<Marker> getMarkersFromJson(List<dynamic> list) {
//  MarkerIcon markerOption = new MarkerIcon();      ///for custom marker icon
    List<Marker> returnedMarkers = <Marker>[];
    for (var marker in list) {
      returnedMarkers.add(getMarkerFromJson(marker));
    }
    return returnedMarkers;
  }

  User getUserFromJson(Map<String, dynamic> info) {
    return User(
        helper.getAppropriateText(info['user']['id']),
        helper.getAppropriateText(info['user']['name'].toString()),
        helper.getAppropriateText(info['user']['user_name'].toString()),
        helper.getAppropriateText(info['user']['email'].toString()),
        helper.getAppropriateText(info['user']['gender'].toString()),
        helper.getAppropriateText(info['user']['phone_number'].toString()),
        helper.getAppropriateText(info['user']['address'].toString()),
        info['user']['email_verified_at'] != null ? true : false,
        info['profile']['image'] != null
            ? BASE_URL + info['profile']['image']
            : 'N/A',
        info['profile']['cover'] != null
            ? BASE_URL + info['profile']['cover']
            : 'N/A',
        helper.getAppropriateText(info['profile']['bio'].toString()),
        info['user']['nationality']);
  }

  List<Prize> getPrizesFromJson(List<dynamic> list) {
    List<Prize> returnedPrizes = <Prize>[];
    for (var prize in list) {
      returnedPrizes.add(Prize(
          id: prize['id'].toString(),
          name: prize['name'],
          arabicName: prize['arabic_name'],
          image: prize['image'] == null
              ? prize['image']
              : BASE_URL + prize['image'],
          requiredMarkersCollected: prize['required_markers_collected'],
          requiredMarkersPosted: prize['required_markers_posted'],
          from: prize['from'] != null ? DateTime.parse(prize['from']) : null,
          to: prize['to'] != null ? DateTime.parse(prize['to']) : null,
          level: prize['level'],
          active: prize['active'] == 0 ? false : true,
          acquired: prize['acquired'] == 0 ? false : true,
          acquiredAt: prize['acquiredAt'] != null
              ? DateTime.parse(prize['acquiredAt'])
              : null));
    }
    return returnedPrizes;
  }

  List<Badge> getBadgesFromJson(List<dynamic> list) {
    List<Badge> returnedBadges = <Badge>[];
    for (var badge in list) {
      returnedBadges.add(Badge(
          id: badge['id'].toString(),
          name: badge['name'],
          arabicName: badge['arabic_name'],
          image: BASE_URL + badge['image'],
          description: badge['description'],
          active: badge['active'] == 0 ? false : true,
          acquired: badge['acquired'] == 0 ? false : true,
          acquiredAt: badge['acquiredAt'] != null
              ? DateTime.parse(badge['acquiredAt'])
              : null));
    }
    return returnedBadges;
  }
}
