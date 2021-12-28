import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../Helpers/ResponseHandler.dart';
import 'package:http/http.dart' as http;
import '../Session/SessionManager.dart';

class TokenApiCaller {
  String url = "http://192.168.1.139:8000";
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();

  Future<Map<String, dynamic>> refreshAccessToken(String language) async {
    var headers = {
      "Content-Type": "application/json",
    };
    var body = {'oauthAccessToken': sessionManager.accessToken};
    try {
      print(url + "/api/token/refresh");
      var response = await http
          .post(Uri.parse(url + "/api/token/refresh"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
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
