import 'package:feedme/Custom_Widgets/text.dart';
import 'package:feedme/Session/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Lottie.asset(
                  'assets/animations/7520-welcome.json',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                ),
                SizedBox(height: 30),
                Text(
                  'Welcome To FeedMe App!',
                  style: GoogleFonts.delius(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                text(
                    'We gonna help you to change \nTHE WORLD.',
                    Colors.blue,
                    22.0,
                    1.5,
                    FontWeight.w800),
                SizedBox(height: 30),
                RaisedButton.icon(
                    color: Colors.white,
                    icon: Icon(
                      Icons.fast_forward,
                      color: Colors.green,
                    ),
                    label: text(
                        'Continue', Colors.green, 18.0, 1.5, FontWeight.w600),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreferredThemeTakingScreen()));
                    })
              ],
            ))));
  }
}

class PreferredLanguageTakingScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  void finishedChoosing(context,String lang){
    sessionManager.createPreferredLanguage(lang);
    sessionManager.changeStatus();
    Navigator.popAndPushNamed(context, 'MainScreen');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  text('Now, Tell us which Language do you prefer?\n الآن، أخبرنا ما هي اللغة التي تفضلها؟', Colors.white,
                      22.0, 1.5, FontWeight.w500),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.white,
                        child: text('العربية', Colors.black, 16.0, 1.5,
                            FontWeight.w500),
                        onPressed: () {
                          finishedChoosing(context,'Ar');
                        },
                      ),
                      RaisedButton(
                        color: Colors.black,
                        child: text('English', Colors.white, 16.0, 1.5,
                            FontWeight.w500),
                        onPressed: () {
                          finishedChoosing(context,'En');
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}

class PreferredThemeTakingScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  void finishedChoosing(context, bool theme){
    sessionManager.createPreferredTheme(theme);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PreferredLanguageTakingScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(186, 224, 255, 1),
        body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  text('Now Tell us which theme do you prefer?', Colors.white,
                      22.0, 1.5, FontWeight.w500),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.white,
                        child: text('White Theme', Colors.black, 16.0, 1.5,
                            FontWeight.w500),
                        onPressed: () {
                          finishedChoosing(context, false);
                        },
                      ),
                      RaisedButton(
                        color: Colors.black,
                        child: text('Black Theme', Colors.white, 16.0, 1.5,
                            FontWeight.w500),
                        onPressed: () {
                          finishedChoosing(context, true);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
