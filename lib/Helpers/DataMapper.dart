import 'package:ataa/GeneralInfo.dart';
import 'package:ataa/Models/Prize.dart';
import 'package:ataa/Models/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/Prize.dart';
import '../Models/Badge.dart';
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

  List<Marker> getMarkersFromJson(List<dynamic> list) {
//  MarkerIcon markerOption = new MarkerIcon();      ///for custom marker icon
    List<Marker> returnedMarkers = <Marker>[];
    list.forEach((marker) {
      returnedMarkers.add(Marker(
        markerId: new MarkerId(marker['id'].toString()),
        position: LatLng(double.parse(marker['latitude'].toString()),
            double.parse(marker['longitude'].toString())),
//      icon: markerOption.getIcon(),
        icon: getMarkerColor(marker['priority'].toString()),
        infoWindow: InfoWindow(
            title: marker['type'].toString(),
            snippet: marker['description'].toString() +
                ' \nQuantity = ${double.parse(marker['quantity'].toString()).toInt()} bags'),
      ));
    });
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
        helper.getAppropriateText(info['profile']['bio'].toString()));
  }

  List<Prize> getPrizesFromJson(List<dynamic> list) {
    List<Prize> returnedPrizes = <Prize>[];
    list.forEach((prize) {
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
    });
    return returnedPrizes;
  }

  List<Badge> getBadgesFromJson(List<dynamic> list) {
    List<Badge> returnedBadges = <Badge>[];
    list.forEach((badge) {
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
    });
    return returnedBadges;
  }
}
