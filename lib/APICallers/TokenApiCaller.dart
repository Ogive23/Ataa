// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ataa/GeneralInfo.dart';

import '../Helpers/ResponseHandler.dart';
import 'package:http/http.dart' as http;
import '../Session/SessionManager.dart';

class TokenApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();

  Future<Map<String, dynamic>> refreshAccessToken(String language) async {
    var headers = {
      "Content-Type": "application/json",
      'Content-Language': language,
    };
    var body = {'oauthAccessToken': sessionManager.accessToken};
    try {
      print(BASE_URL + "/api/token/refresh");
      var response = await http
          .post(Uri.parse(BASE_URL + "/api/token/refresh"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      sessionManager.refreshAccessToken(responseToJson['data']['accessToken'],
          responseToJson['data']['expiryDate']);
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "AccessToken": responseToJson['data']['accessToken'],
        "ExpiryDate": responseToJson['data']['expiryDate'],
      };
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
