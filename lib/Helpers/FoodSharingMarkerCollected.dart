// ignore_for_file: file_names

import 'dart:convert';

import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Shared%20Data/MarkerData.dart';
import 'package:pusher_client/pusher_client.dart';

import 'PusherChannel.dart';

class FoodSharingMarkerCollected extends PusherChannel {
  String eventName = "FoodSharingMarkerCollected";

  @override
  bind(Channel channel, MarkerData markerData) {
    channel.bind(eventName, (PusherEvent? event) {
      DataMapper dataMapper = DataMapper();
      markerData.deleteMarker(dataMapper
          .getMarkerFromJson(jsonDecode(event!.data!)['foodSharingMarker']));
    });
  }
}
