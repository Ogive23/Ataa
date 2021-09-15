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
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  String url = "http://192.168.1.190:8000";

  Future<Map<String, dynamic>> create(
      String language,
      double latitude,
      double longitude,
      String description,
      int priority,
      String type,
      double quantity) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }

    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };

    var body = {
      "createdBy": sessionManager.user!.id,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "type": type,
      "description": description,
      "quantity": quantity,
      "priority": priority,
    };

    try {
      print(url + "/api/ataa/markers");
      var response = await http
          .post(Uri.parse(url + "/api/ahed/markers"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
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
