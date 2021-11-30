import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Helpers/ResponseHandler.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/session_manager.dart';
import 'TokenApiCaller.dart';

class UserApiCaller {
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  String url = "http://192.168.1.139:8000";

  Future<Map<String, dynamic>> login(String email, String password) async {
    var headers = {
      "Content-Type": "application/json",
    };
    var body = {"email": email, "password": password};
    try {
      var response = await http
          .post(Uri.parse(url + "/api/login"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "User": dataMapper.getUserFromJson(url, responseToJson['data']),
        "AccessToken": responseToJson['data']['token'],
        "ExpiryDate": responseToJson['data']['expiryDate'],
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter("En", "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter("En", 'SomethingWentWrong');
    }
  }

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
              Uri.parse(
                  url + "/api/ataa/achievement/${sessionManager.user!.id}?requesterId=${sessionManager.user!.id}"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      Map<String, dynamic> responseToJson = jsonDecode(response.body);
      print(responseToJson);
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

  Future<Map<String, dynamic>> changeProfilePicture(
      String language, String userId, File image) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    FormData formData = new FormData.fromMap({
      '_method': 'put',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(url + "/api/profile/$userId/picture",
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      }
      if (e.response!.statusCode == 403) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else if (e.response!.statusCode == 404) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else {
        return responseHandler.errorPrinter(language, "SomethingWentWrong");
      }
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }

  Future<Map<String, dynamic>> changeCoverPicture(
      String language, String userId, File image) async {
    Map<String, dynamic> status;
    if (sessionManager.accessTokenExpired()) {
      status = await tokenApiCaller.refreshAccessToken(language);
      if (status['Err_Flag']) return status;
    }
    var headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    FormData formData = new FormData.fromMap({
      '_method': 'put',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(url + "/api/profile/$userId/cover",
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      }
      if (e.response!.statusCode == 403) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else if (e.response!.statusCode == 404) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else {
        return responseHandler.errorPrinter(language, "SomethingWentWrong");
      }
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }

  changeUserInformation(String language, String userId, String bio,
      String address, String phoneNumber) async {
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
      '_method': 'put',
      'userId': userId,
      'bio': bio,
      'address': address,
      'phoneNumber': phoneNumber,
    };
    try {
      var response = await http
          .post(Uri.parse(url + "/api/profile/$userId/information"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter(language, "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter(language, "SomethingWentWrong");
    }
  }
}
