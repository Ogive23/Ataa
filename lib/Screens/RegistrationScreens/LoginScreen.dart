// ignore_for_file: file_names

import 'package:ataa/APICallers/OptionApiCaller.dart';
import 'package:ataa/APICallers/UserApiCaller.dart';
import 'package:ataa/CustomWidgets/CustomActionTextRow.dart';
import 'package:ataa/CustomWidgets/CustomButtonLoading.dart';
import 'package:ataa/CustomWidgets/CustomDropdownButton.dart';
import 'package:ataa/CustomWidgets/CustomSpacing.dart';
import 'package:ataa/CustomWidgets/ErrorMessage.dart';
import 'package:ataa/Helpers/DataMapper.dart';
import 'package:ataa/Models/Nationality.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/AppLanguage.dart';
import 'package:ataa/Shared%20Data/AppTheme.dart';
import 'package:ataa/Shared%20Data/MemoryCache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static late double w, h;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final SessionManager sessionManager = SessionManager();
  final MemoryCache memoryCache = MemoryCache();
  final OptionApiCaller optionApiCaller = new OptionApiCaller();
  String error = '';
  List<String> availableNationalities = ['Egyptian', 'xDian'];
  String? nationality;
  final Map<String, bool> loadingButtons = {
    "login": false,
    "loginAsAnonymous": false
  };
  String get email => emailController.text;
  String get password => passwordController.text;
  cacheData(List<Nationality> nationalities) {
    memoryCache.setData('nationalities', nationalities);
  }

  void saveSession(
      bool anonymous, dynamic data, String accessToken, DateTime expiryDate) {
    if (anonymous) {
      return sessionManager.createAnonymousSession(
          data, accessToken, expiryDate);
    }
    return sessionManager.createSession(data, accessToken, expiryDate);
  }

  void redirect() {
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, 'MainScreen');
  }

  void saveSessionAndRedirect(
      bool anonymous, dynamic user, String accessToken, DateTime expiryDate) {
    saveSession(anonymous, user, accessToken, expiryDate);
    redirect();
  }

  Future<dynamic> login(context) async {
    changeLoadingState('login');
    UserApiCaller userApiCaller = UserApiCaller();
    Map<String, dynamic> status =
        await userApiCaller.login(appLanguage.language, email, password);
    changeLoadingState('login');
    print(status);
    if (status['Err_Flag']) {
      setState(() {
        error = status['Err_Desc'];
      });
      return;
    }
    saveSessionAndRedirect(false, status['User'], status['AccessToken'],
        DateTime.parse(status['ExpiryDate']));
  }

  Future<dynamic> createAnonymousUser(context) async {
    changeLoadingState('loginAsAnonymous');
    UserApiCaller userApiCaller = UserApiCaller();
    Map<String, dynamic> status =
        await userApiCaller.createAnonymousUser(appLanguage.language, nationality);
    changeLoadingState('loginAsAnonymous');
    if (status['Err_Flag']) {
      setState(() {
        error = status['Err_Desc'];
      });
      return;
    }
    saveSessionAndRedirect(true, status['AnonymousUser'], status['AccessToken'],
        DateTime.parse(status['ExpiryDate']));
  }

  changeLoadingState(button) {
    setState(() {
      loadingButtons[button] = !loadingButtons[button]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    appTheme = AppTheme(true, context);
    appLanguage = AppLanguage(sessionManager.loadPreferredLanguage()!);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 49, 56, 1.0),
                  image: DecorationImage(
                      image: const AssetImage(
                        'assets/images/hand-giving-food-bowl-needy-person_23-2148733818.png',
                      ),
                      fit: BoxFit.cover,
                      // scale: 0.66,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      alignment: Alignment.center),
                ),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: h / 10, bottom: h / 50),
                        child: Container(
                          height: h / 6,
                          width: h / 6,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/ogive_version_2.png'),
                            ),
                          ),
                        )),
                    Text(
                      appLanguage.words['loginPageTitle']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: appTheme.mediumTextSize(context),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: h / 15, right: w / 20, left: w / 20),
                      padding: EdgeInsets.only(top: h / 100, bottom: h / 100),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                spreadRadius: 5,
                                blurRadius: 10)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w / 25),
                            child: Align(
                                alignment: appLanguage.alignment,
                                child: Text(
                                  appLanguage.words['loginPageDialogTitle']!,
                                  style: appTheme.nonStaticGetTextStyle(
                                      2.0,
                                      Colors.white,
                                      appTheme.mediumTextSize(context),
                                      FontWeight.w300,
                                      1.0,
                                      TextDecoration.none,
                                      'OpenSans'),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w / 25, vertical: h / 200),
                              child: TextField(
                                controller: emailController,
                                textAlign: TextAlign.center,
                                style: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    Colors.white,
                                    appTheme.mediumTextSize(context),
                                    FontWeight.normal,
                                    1.0,
                                    TextDecoration.none,
                                    'OpenSans'),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    labelText: appLanguage
                                        .words['loginPageEmailField']!,
                                    labelStyle:
                                        const TextStyle(color: Colors.white)),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: h / 50, right: w / 25, left: w / 25),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    Colors.white,
                                    appTheme.mediumTextSize(context),
                                    FontWeight.normal,
                                    1.0,
                                    TextDecoration.none,
                                    'OpenSans'),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    icon: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    labelText: appLanguage
                                        .words['loginPagePasswordField']!,
                                    labelStyle:
                                        const TextStyle(color: Colors.white)),
                              )),
                          SizedBox(
                            height: h / 50,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: w / 10),
                              child: Text(
                                error,
                                style: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    Colors.red,
                                    appTheme.mediumTextSize(context),
                                    FontWeight.bold,
                                    1.0,
                                    TextDecoration.none,
                                    'OpenSans'),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: h / 50,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (loadingButtons['login']!)
                                  const CustomButtonLoading()
                                else
                                  ElevatedButton(
                                    child: Text(
                                      appLanguage
                                          .words['loginPageLoginButton']!,
                                      style: appTheme.nonStaticGetTextStyle(
                                          1.0,
                                          Colors.white,
                                          appTheme.mediumTextSize(context),
                                          FontWeight.normal,
                                          1.0,
                                          TextDecoration.none,
                                          'OpenSans'),
                                      textAlign: TextAlign.center,
                                    ),
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all<Size>(
                                            Size(w / 4, h / 20)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromRGBO(
                                                    53, 67, 77, 1.0)),
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)))),
                                    onPressed: () {
                                      login(context);
                                    },
                                  ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: w / 25),
                                  child: Text(
                                    appLanguage.words[
                                        'loginPageForgetPasswordButton']!,
                                    style: appTheme.nonStaticGetTextStyle(
                                        1.0,
                                        Colors.red,
                                        appTheme.smallTextSize(context),
                                        FontWeight.normal,
                                        1.0,
                                        TextDecoration.underline,
                                        'OpenSans'),
                                  ),
                                )
                              ]),
                          ElevatedButton(
                            child: Text(
                              appLanguage.words['loginPageAnonymousButton']!,
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  const Color.fromRGBO(255, 255, 255, 1.0),
                                  appTheme.mediumTextSize(context),
                                  FontWeight.normal,
                                  1.0,
                                  TextDecoration.none,
                                  'OpenSans'),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(w / 4, h / 20)),
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromRGBO(234, 249, 255, 0.1)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                            onPressed: () async {
                              if (sessionManager.hasAnonymousUser()) {
                                Navigator.popUntil(context, (route) => false);
                                Navigator.pushNamed(context, 'MainScreen');
                                return;
                              }
                              showAnonymousLoginDialog();
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomActionTextRow(
                                  firstText: appLanguage
                                      .words['loginPageSignUpFirst']!,
                                  secondText: appLanguage
                                      .words['loginPageSignUpSecond']!,
                                  firstTextStyle:
                                      appTheme.nonStaticGetTextStyle(
                                          1.0,
                                          Colors.white,
                                          appTheme.smallTextSize(context),
                                          FontWeight.normal,
                                          1.0,
                                          TextDecoration.none,
                                          'OpenSans'),
                                  secondTextStyle:
                                      appTheme.nonStaticGetTextStyle(
                                          1.0,
                                          Colors.green[700],
                                          appTheme.mediumTextSize(context),
                                          FontWeight.w600,
                                          1.0,
                                          TextDecoration.none,
                                          'OpenSans'),
                                  language: appLanguage.language))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  String language = appLanguage.language == 'En' ? 'Ar' : 'En';
                  appLanguage.changeLanguage(language);
                  setState(() {
                    sessionManager.createPreferredLanguage(language);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w / 25, vertical: h / 25),
                  child: Text(
                    appLanguage.language == 'En' ? 'العربية' : 'English',
                    style: appTheme.nonStaticGetTextStyle(
                        2.0,
                        Colors.white,
                        appTheme.mediumTextSize(context),
                        FontWeight.w300,
                        1.0,
                        TextDecoration.none,
                        'OpenSans'),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void showAnonymousLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Directionality(
            textDirection: appLanguage.textDirection,
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: appTheme.themeData.primaryColor,
                insetPadding:
                    EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 10),
                contentPadding: EdgeInsets.symmetric(horizontal: w / 25),
                title: Text(
                  appLanguage.words['LoginPageAnonymousDialogTitle']!,
                  style: appTheme.themeData.primaryTextTheme.headline4,
                ),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: w / 50, vertical: h / 50),
                content: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: w - w / 10,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5))),
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: appTheme.themeData.primaryColor,
                                ),
                                child: memoryCache.hasData('nationalities')
                                    ? showNationalitiesDropdown(
                                        context, setState)
                                    : FutureBuilder<Map<String, dynamic>>(
                                        future:
                                            optionApiCaller.getNationalities(
                                                appLanguage.language),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Map<String, dynamic>>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.data != null) {
                                            if (snapshot.data!['Err_Flag']) {
                                              return Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: h / 100),
                                                child: ErrorMessage(
                                                    message: snapshot
                                                        .data!['Err_Desc']),
                                              );
                                            }
                                            DataMapper dataMapper =
                                                DataMapper();
                                            List<Nationality> nationalities =
                                                dataMapper
                                                    .getNationalitiesFromJson(
                                                        snapshot.data!['data']);
                                            cacheData(nationalities);
                                            return showNationalitiesDropdown(
                                                context, setState);
                                          } else if (snapshot.error != null) {
                                            print(snapshot.error);
                                            return Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h / 100),
                                              child: ErrorMessage(
                                                message: appLanguage.words[
                                                    'AtaaMainAcquiringErrorTwo']!,
                                                appTheme: appTheme,
                                                appLanguage: appLanguage,
                                              ),
                                            );
                                          } else {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CupertinoActivityIndicator(
                                                  radius: w / 10,
                                                ),
                                                const CustomSpacing(value: 50),
                                                Text(
                                                  appLanguage.words['loading']!,
                                                  style: appTheme
                                                      .themeData
                                                      .primaryTextTheme
                                                      .headline3,
                                                )
                                              ],
                                            );
                                          }
                                        },
                                      )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  if (loadingButtons['loginAsAnonymous']!)
                    const CustomButtonLoading()
                  else
                  TextButton(
                    child: Text(
                        appLanguage.words['LoginPageAnonymousDialogOkButton']!,
                        textDirection: appLanguage.textDirection,
                        style: appTheme.themeData.primaryTextTheme.headline4),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            appTheme.themeData.colorScheme.secondary)),
                    onPressed: () {
                      createAnonymousUser(context);
                    },
                  ),
                ],
              );
            }),
          );
        });
  }

  Widget showNationalitiesDropdown(context, setState) {
    return CustomDropdownButton(
      text: appLanguage.words['LoginPageAnonymousDialogDropDown']!,
      selectedValue: nationality,
      onChanged: (selectedNationality) {
        setState(() {
          nationality = selectedNationality;
        });
      },
      items: (memoryCache.getData('nationalities') as List<Nationality>)
          .map((nationality) => DropdownMenuItem(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SizedBox(
                      width: w,
                      child: Text(
                        nationality.label,
                        textAlign: TextAlign.right,
                      ),
                    )),
                value: nationality.label,
              ))
          .toList(),
      appTheme: appTheme,
    );
  }
}
