import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ataa/Helpers/DataMapper.dart';
import '../Helpers/ResponseHandler.dart';
import '../Session/session_manager.dart';
import 'TokenApiCaller.dart';

class MarkerApiCaller {
  DataMapper factory = new DataMapper();

  Future<bool> create(latitude, longitude, String description, int priority,
      String type, double quantity) async {
    late bool done;
    await markers.add({
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'description': description,
      'quantity': quantity,
      'priority': priority
    }).then((value) {
      done = true;
    }).catchError((error) {
      done = false;
    });
    print('thing 55');
    return done;
  }

  delete(markerId) async {
    await markers.doc(markerId).delete();
  }

  dynamic getAll() async {
    QuerySnapshot snapshot = await markers.get();
    print(snapshot);
    return factory.getMarkersFromSnapshot(snapshot);
  }
}
