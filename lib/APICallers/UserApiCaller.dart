// ignore_for_file: file_names

import 'dart:io';
import 'package:ataa/GeneralInfo.dart';
import 'package:dio/dio.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Helpers/ResponseHandler.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/SessionManager.dart';
import 'TokenApiCaller.dart';

class UserApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  TokenApiCaller tokenApiCaller = TokenApiCaller();

  Future<Map<String, dynamic>> login(String email, String password) async {
    var headers = {
      "Content-Type": "application/json",
    };
    var body = {
      "email": email,
      "password": password,
      "accessType": "Mobile",
      "appType": "Ataa"
    };
    try {
      var response = await http
          .post(Uri.parse(BASE_URL + "/api/login"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "User": dataMapper.getUserFromJson(responseToJson['data']),
        "AccessToken": responseToJson['data']['token'],
        "ExpiryDate": responseToJson['data']['expiryDate'],
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter("En");
    } on SocketException {
      return responseHandler.errorPrinter("En", "InternetError");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter("En", 'SomethingWentWrong');
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
    FormData formData = FormData.fromMap({
      '_method': 'put',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(BASE_URL + "/api/profile/$userId/picture",
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
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
      return responseHandler.timeOutPrinter(language);
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
    FormData formData = FormData.fromMap({
      '_method': 'put',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(BASE_URL + "/api/profile/$userId/cover",
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
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
      return responseHandler.timeOutPrinter(language);
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
          .post(Uri.parse(BASE_URL + "/api/profile/$userId/information"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
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
