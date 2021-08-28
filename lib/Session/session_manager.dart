import 'package:ataa_lite/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  late User? user;
  late DateTime? accessTokenExpireDate;
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }
  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  createSession(User user, DateTime accessTokenExpiryDate) {
    this.user = user;
    print(user.toList());
    sharedPreferences!.setStringList('user', user.toList());
    sharedPreferences!.setString(
        'accessTokenExpireDate', accessTokenExpiryDate.toString());
  }

  loadSession() {
    accessTokenExpireDate =
        DateTime.parse(sharedPreferences!.getString('accessTokenExpireDate')!);
    if (accessTokenExpireDate!.isBefore(DateTime.now())) {
      logout();
    }
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
        userData[8],
        userData[9],
        userData[10],
        userData[11]);
  }
  bool isLoggedIn() {
    return sharedPreferences!.containsKey('user');
  }
  bool accessTokenExpired() {
    return accessTokenExpireDate!.isBefore(DateTime.now());
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

  logout() {
    this.user = null;
    this.accessTokenExpireDate = null;
    sharedPreferences!.remove('accessTokenExpireDate');
    sharedPreferences!.remove('user');
  }
}
