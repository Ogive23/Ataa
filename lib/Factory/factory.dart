import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Factory {
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
    List<Marker> returnedMarkers = new List<Marker>();
    snapShot.docs.forEach((marker) {
      returnedMarkers.add(Marker(
        markerId: new MarkerId(marker.id.toString()),
        position: LatLng(double.parse(marker.get('latitude').toString()),
            double.parse(marker.get('longitude').toString())),
//      icon: markerOption.getIcon(),
        icon: getMarkerColor(marker.get('priority').toString()),
        infoWindow: InfoWindow(
            title: marker.get('name'),
            snippet: marker.get('description') +
                ' \nQuantity = ${marker.get('quantity')}'),
      ));
    });
    return returnedMarkers;
  }
}
