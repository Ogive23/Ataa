import 'package:ataa/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  late User? user;
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

  loadSession() {
    expiryDate = DateTime.parse(sharedPreferences!.getString('expiryDate')!);
    if (expiryDate!.isBefore(DateTime.now())) {
      logout();
    }
    accessToken = sharedPreferences!.getString('accessToken')!;
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = new User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        //ToDo: Review
        userData[7] == "true" ? true : false,
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

  createPreferredLanguage(String lang) {
    sharedPreferences!.setString('lang', lang);
  }

  String? loadPreferredLanguage() {
    return sharedPreferences!.getString('lang');
  }

  logout() {
    this.user = null;
    this.accessToken = null;
    this.expiryDate = null;
    sharedPreferences!.remove('expiryDate');
    sharedPreferences!.remove('accessToken');
    sharedPreferences!.remove('user');
  }
}
