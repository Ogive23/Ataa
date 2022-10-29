// ignore_for_file: file_names

import 'package:ataa/Models/AnonymousUser.dart';
import 'package:ataa/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  AnonymousUser? anonymousUser;
  User? user;
  late String? accessToken;
  late DateTime? expiryDate;
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }
  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  createSession(User user, String accessToken, DateTime expiryDate) {
    this.user = user;
    this.accessToken = accessToken;
    this.expiryDate = expiryDate;
    print(user.toList());
    sharedPreferences!.setStringList('user', user.toList());
    sharedPreferences!.setString('accessToken', accessToken.toString());
    sharedPreferences!.setString('expiryDate', expiryDate.toString());
  }

  createAnonymousSession(AnonymousUser anonymousUser, String accessToken, DateTime expiryDate) {
    this.anonymousUser = anonymousUser;
    this.accessToken = accessToken;
    this.expiryDate = expiryDate;
    print(anonymousUser.toList());
    sharedPreferences!.setStringList('anonymousUser', anonymousUser.toList());
    sharedPreferences!.setString('accessToken', accessToken.toString());
    sharedPreferences!.setString('expiryDate', expiryDate.toString());
  }

  loadSession() {
    expiryDate = DateTime.parse(sharedPreferences!.getString('expiryDate')!);
    if (expiryDate!.isBefore(DateTime.now())) {
      logout();
    }
    accessToken = sharedPreferences!.getString('accessToken')!;
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        //ToDo: Review
        userData[7] == "true" ? true : false,
        userData[8],
        userData[9],
        userData[10],
        userData[11]);
  }

  bool isLoggedIn() {
    return sharedPreferences!.containsKey('user');
  }

  bool accessTokenExpired() {
    return expiryDate!.isBefore(DateTime.now());
  }

  refreshAccessToken(String accessToken, DateTime expiryDate) {
    this.accessToken = accessToken;
    this.expiryDate = expiryDate;
    sharedPreferences!.setString('accessToken', accessToken.toString());
    sharedPreferences!.setString('expiryDate', expiryDate.toString());
  }

  bool firstTime() {
    return ! (sharedPreferences!.containsKey('notFirstTime')); //true if there
  }

  changeStatus() {
    sharedPreferences!.setString('notFirstTime', true.toString());
  }

  createPreferredTheme(bool theme) {
    sharedPreferences!.setString('theme', theme.toString());
  }

  bool loadPreferredTheme() {
    return sharedPreferences!.get('theme') == 'true' ? true : false;
  }

  createPreferredLanguage(String lang) {
    sharedPreferences!.setString('lang', lang);
  }

  String? loadPreferredLanguage() {
    return sharedPreferences!.getString('lang');
  }

  bool hasAnonymousUser() {
    return sharedPreferences!.containsKey('anonymousUser');
  }

  loadAnonymousUser() {
    expiryDate = DateTime.parse(sharedPreferences!.getString('expiryDate')!);
    accessToken = sharedPreferences!.getString('accessToken')!;
    List<String> anonymousUserData = sharedPreferences!.getStringList('anonymousUser')!;
    anonymousUser = AnonymousUser(
        anonymousUserData[0]
    );
  }

  logout() {
    user = null;

    anonymousUser = null;
    accessToken = null;
    expiryDate = null;
    sharedPreferences!.remove('expiryDate');
    sharedPreferences!.remove('accessToken');
    sharedPreferences!.remove('user');
    sharedPreferences!.remove('anonymousUser');
  }
}
