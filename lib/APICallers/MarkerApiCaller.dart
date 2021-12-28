import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Helpers/ResponseHandler.dart';
import '../Session/SessionManager.dart';
import 'TokenApiCaller.dart';

class MarkerApiCaller {
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  String url = "http://192.168.1.139:8000";

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
      "language": language,
      "createdBy": sessionManager.user!.id,
      "latitude": latitude,
      "longitude": longitude,
      "type": type,
      "description": description,
      "quantity": quantity,
      "priority": priority,
    };

    try {
      print(url + "/api/ataa/markers");
      var response = await http
          .post(Uri.parse(url + "/api/ataa/markers"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter(language);
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }

  Future<Map<String, dynamic>> delete(String language, String markerId) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }

    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };

    try {
      print(url +
          "/api/ataa/markers/$markerId?userId=${sessionManager.user!.id}&language=$language");
      var response = await http
          .delete(
              Uri.parse(url +
                  "/api/ataa/markers/$markerId?userId=${sessionManager.user!.id}&language=$language"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter(language);
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }

  Future<Map<String, dynamic>> getAll(String language) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }

    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    try {
      var response = await http
          .get(
              Uri.parse(url +
                  "/api/ataa/markers/?" +
                  "userId=${sessionManager.user!.id}"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      return responseHandler.timeOutPrinter(language);
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }
}
