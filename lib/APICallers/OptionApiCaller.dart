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

class OptionApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  TokenApiCaller tokenApiCaller = TokenApiCaller();

  Future<Map<String, dynamic>> getNationalities(String language) async {
    Map<String, dynamic> status;
    var headers = {
      "Content-Type": "application/json",
      'Content-Language': language,
    };
    try {
      print(BASE_URL + "/api/options/nationalities");
      var response = await http
          .get(
              Uri.parse(BASE_URL +
                  "/api/options/nationalities"),
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
}
