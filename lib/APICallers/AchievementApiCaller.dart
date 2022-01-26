import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Helpers/ResponseHandler.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/SessionManager.dart';
import 'TokenApiCaller.dart';

class AchievementApiCaller {
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  String url = "http://192.168.1.155:8000";

  Future<Map<String, dynamic>> getAchievements(String language) async {
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
      print(url + "/api/ataa/achievement/${sessionManager.user!.id}");
      var response = await http
          .get(
              Uri.parse(url +
                  "/api/ataa/achievement/${sessionManager.user!.id}?requesterId=${sessionManager.user!.id}"),
              headers: headers)
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
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

  Future<Map<String, dynamic>> getAtaaPrizes(String language) async {
    Map<String, dynamic> status;
    print(sessionManager.accessToken);
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    try {
      print(url + "/api/ataa/prizes/${sessionManager.user!.id}");
      var response = await http
          .get(
              Uri.parse(url +
                  "/api/ataa/prizes?userId=${sessionManager.user!.id}"),
              headers: headers)
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
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

  Future<Map<String, dynamic>> getAtaaBadges(String language) async {
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
      print(url + "/api/ataa/badges/${sessionManager.user!.id}");
      var response = await http
          .get(
              Uri.parse(url +
                  "/api/ataa/badges?userId=${sessionManager.user!.id}"),
              headers: headers)
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
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
}
