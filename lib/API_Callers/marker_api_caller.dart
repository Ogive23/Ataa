import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedme/Factory/factory.dart';

class MarkerApiCaller {
  MarkerApiCaller._privateConstructor();

  static final MarkerApiCaller _instance = MarkerApiCaller._privateConstructor();
  FirebaseFirestore firestore;
  CollectionReference markers;
  Factory factory = new Factory();
  factory MarkerApiCaller() {
    return _instance;
  }
  initialize(){
    firestore = FirebaseFirestore.instance;
    markers =
        FirebaseFirestore.instance.collection('markers');
  }
  Future<bool> create(
      latitude, longitude, String description, int priority, String type,double quantity) async {
    bool done;
    await markers
        .add({
          'latitude': latitude,
          'longitude': longitude,
          'type': type,
          'description': description,
          'quantity': quantity,
          'priority': priority
        })
        .then((value) {done = true;})
        .catchError((error) { done = false;});
    print('thing 55');
    return done;
  }

  delete(markerId) async {
    await markers.doc(markerId).delete();
  }

  dynamic getAll() async {
    QuerySnapshot snapshot = await markers.get();
    return factory.getMarkersFromSnapshot(snapshot);
  }
}
