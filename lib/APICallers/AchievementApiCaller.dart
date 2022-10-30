// ignore_for_file: file_names

import 'dart:io';
import 'package:ataa/GeneralInfo.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Helpers/ResponseHandler.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/SessionManager.dart';
import 'TokenApiCaller.dart';

class AchievementApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  TokenApiCaller tokenApiCaller = TokenApiCaller();

  Future<Map<String, dynamic>> getAchievements(String language) async {
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
      print(BASE_URL + "/api/ataa/achievement");
      var response = await http
          .get(
              Uri.parse(BASE_URL +
                  "/api/ataa/achievement"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
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
      print(BASE_URL + "/api/ataa/prizes");
      var response = await http
          .get(
              Uri.parse(BASE_URL +
                  "/api/ataa/prizes"),
              headers: headers)
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(const Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
      print(responseToJson);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter(language);
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
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
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    try {
      print(BASE_URL + "/api/ataa/badges");
      var response = await http
          .get(
              Uri.parse(BASE_URL +
                  "/api/ataa/badges"),
              headers: headers)
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(const Duration(seconds: 120));
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
