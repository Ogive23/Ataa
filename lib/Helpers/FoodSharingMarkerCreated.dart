// ignore_for_file: file_names

import 'dart:convert';

import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Shared%20Data/MarkerData.dart';
import 'package:pusher_client/pusher_client.dart';

import 'PusherChannel.dart';

class FoodSharingMarkerCreated extends PusherChannel {
  String eventName = "FoodSharingMarkerCreated";

  @override
  bind(Channel channel, MarkerData markerData) {
    channel.bind(eventName, (PusherEvent? event) {
      DataMapper dataMapper = DataMapper();
      markerData.addMarker(dataMapper
          .getMarkerFromJson(jsonDecode(event!.data!)['foodSharingMarker']));
    });
  }
}
