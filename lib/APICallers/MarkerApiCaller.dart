import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ataa/Helpers/DataMapper.dart';

class MarkerApiCaller {
  late FirebaseFirestore firestore;
  late CollectionReference markers;
  DataMapper factory = new DataMapper();
  void initialize() {
    firestore = FirebaseFirestore.instance;
    markers = FirebaseFirestore.instance.collection('markers');
  }

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
