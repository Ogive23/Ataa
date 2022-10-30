// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ataa/GeneralInfo.dart';
import 'package:http/http.dart' as http;
import '../Helpers/ResponseHandler.dart';
import '../Session/SessionManager.dart';
import 'TokenApiCaller.dart';

class MarkerApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  TokenApiCaller tokenApiCaller = TokenApiCaller();

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

    print(sessionManager.accessToken);

    var headers = {
      "Content-Type": "application/json",
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };

    var body = {
      "latitude": latitude,
      "longitude": longitude,
      "type": type,
      "description": description,
      "quantity": quantity,
      "priority": priority,
    };

    try {
      print(BASE_URL + "/api/ataa/markers");
      print(body);
      var response = await http
          .post(Uri.parse(BASE_URL + "/api/ataa/markers"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
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
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };

    try {
      print(BASE_URL +
          "/api/ataa/markers/$markerId?userId=${sessionManager.getUserId()}&language=$language");
      var response = await http
          .delete(
              Uri.parse(BASE_URL +
                  "/api/ataa/markers/$markerId?userId=${sessionManager.getUserId()}&language=$language"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
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

  Future<Map<String, dynamic>> getAll(
      String language, double latitude, longitude) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }

    var headers = {
      "Content-Type": "application/json",
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    print(sessionManager.accessToken);
    try {
      var response = await http
          .get(
              Uri.parse(BASE_URL +
                  "/api/ataa/markers/?" +
                  "userId=${sessionManager.getUserId()}&latitude=$latitude&longitude=$longitude"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      print(response.body);
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
