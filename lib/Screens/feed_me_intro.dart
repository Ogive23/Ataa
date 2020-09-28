import 'dart:ui';
import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Themes/app_language.dart';
import 'package:feedme/Themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedMeIntro extends StatelessWidget {
  final AppTheme appTheme;
  final AppLanguage appLanguage;
  final SessionManager sessionManager = new SessionManager();
  FeedMeIntro(this.appTheme, this.appLanguage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            FontAwesomeIcons.info,
            color: appTheme.themeData.accentColor,
            size: 23,
          ),
          backgroundColor: appTheme.themeData.backgroundColor,
          elevation: 10,
          splashColor: Colors.blue,
          tooltip: appLanguage.words['FeedMeIntroInfo'],
          heroTag: "info",
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/giving.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    color: Colors.transparent.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ClipRRect(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 3),
                                        child: Text(
                                          'Hey, you have',
                                          style: GoogleFonts.catamaran(
                                              fontSize: 20,
                                              color: Colors.white
                                                  .withOpacity(0.7)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  '123',
                                                  style: GoogleFonts.anton(
                                                    fontSize: 25,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                Text(
                                                  'Markers published',
                                                  style: GoogleFonts.catamaran(
                                                      fontSize: 12,
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                )
                                              ],
                                            ),
                                            Text(
                                              '&',
                                              style: GoogleFonts.catamaran(
                                                  fontSize: 40,
                                                  color: Colors.white
                                                      .withOpacity(0.7)),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  '123',
                                                  style: GoogleFonts.anton(
                                                    fontSize: 25,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                Text(
                                                  'Markers collected',
                                                  style: GoogleFonts.catamaran(
                                                      fontSize: 12,
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Your progress',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.catamaran(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 6,
                                            bottom: 2,
                                            left: 5,
                                            right: 5),
                                        child: LinearProgressIndicator(
                                          value: 0.3,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '62 Markers left to your prize.',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.catamaran(
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ],
                                  ),
                                ),
                                BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 1.5, sigmaY: 1.5),
                                    child: Text(
                                      appLanguage.words['FeedMeIntroAchievementCenter'],
                                      textAlign: TextAlign.center,
                                      textDirection: appLanguage.textDirection,
                                      style: TextStyle(
                                          color: Colors.amber[100],
                                          fontSize: 24.0),
                                    ))
                              ],
                            )))),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      buttonColor: Colors.amber,
                      hoverColor: Colors.blueAccent,
                      splashColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: RaisedButton.icon(
                        elevation: 10,
                        onPressed: () {
                          Navigator.pushNamed(context, 'MarkerCreation');
                        },
                        icon: Icon(
                          Icons.flag,
                          color: appTheme.themeData.backgroundColor,
                        ),
                        label: Text(
                          appLanguage.words['FeedMeIntroFirstButton'],
                          style: GoogleFonts.aBeeZee(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: appTheme.themeData.accentColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ButtonTheme(
                      buttonColor: Colors.amber,
                      hoverColor: Colors.blueAccent,
                      splashColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, 'FeedMe');
                        },
                        icon: Icon(
                          Icons.flash_on,
                          color: Colors.redAccent,
                        ),
                        label: Text(
                            appLanguage.words['FeedMeIntroSecondButton'],
                            style: GoogleFonts.aBeeZee(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: appTheme.themeData.accentColor)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                    appLanguage.words['FeedMeIntroWord'],
                    textAlign: TextAlign.center,
                    textDirection: appLanguage.textDirection,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
        ));
  }
}
