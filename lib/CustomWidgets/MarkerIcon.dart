// ignore_for_file: file_names

//import 'dart:typed_data';
//import 'package:flutter/services.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'dart:ui' as ui;
//
//class MarkerIcon {
//  BitmapDescriptor _markerIcon;
//  MarkerIcon() {
//    createMarkerImageFromAsset();
//  }
//  BitmapDescriptor getIcon() {
//    return _markerIcon;
//  }
//
//  Future<Uint8List> getBytesFromAsset(String path, int width) async {
//    ByteData data = await rootBundle.load(path);
//    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//        targetWidth: width);
//    ui.FrameInfo fi = await codec.getNextFrame();
//    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
//        .buffer
//        .asUint8List();
//  }
//
//  createMarkerImageFromAsset() async {
//    final Uint8List markerIcon =
//    await getBytesFromAsset('assets/images/marker.png', 70);
//    if (_markerIcon == null) {
//      _updateBitmap(BitmapDescriptor.fromBytes(markerIcon));
//    }
//  }
//
//  void _updateBitmap(BitmapDescriptor bitmap) {
//    _markerIcon = bitmap;
//  }
//}
