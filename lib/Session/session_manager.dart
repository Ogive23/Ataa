import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }

  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool notFirstTime() {
    return sharedPreferences!.containsKey('notFirstTime'); //true if there
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

  createPreferredLanguage(String lang){
    sharedPreferences!.setString('lang', lang);
  }

  String? loadPreferredLanguage(){
    return sharedPreferences!.getString('lang');
  }

}
