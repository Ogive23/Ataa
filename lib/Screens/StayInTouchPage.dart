// ignore_for_file: file_names

import 'package:ataa/CustomWidgets/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Session/SessionManager.dart';
import '../Shared Data/AppLanguage.dart';
import '../Shared Data/AppTheme.dart';
import '../Shared Data/CommonData.dart';

class StayInTouchPage extends StatelessWidget {
  static late double w, h;
  final SessionManager sessionManager = SessionManager();
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;

  StayInTouchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: appTheme.themeData.primaryColor,
        appBar: AppBar(
          backgroundColor: appTheme.themeData.primaryColor,
          elevation: 0.0,
          title: Text(
            appLanguage.words['StayInTouchTitle']!,
            style: appTheme.themeData.primaryTextTheme.headline2,
          ),
        ),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: h / 100, horizontal: w / 50),
            //   height: double.infinity,
            decoration: BoxDecoration(color: appTheme.themeData.primaryColor),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCard(
                      title: appLanguage.words['StayInTouchFacebookTitle']!,
                      subtitle:
                          appLanguage.words['StayInTouchFacebookSubtitle']!,
                      url: 'https://www.facebook.com/ogive23/',
                      icon: FontAwesomeIcons.facebook,
                      iconColor: Colors.blue,
                      kind: 'fb',
                      textDirection: appLanguage.textDirection),
                  // CustomSpacing(
                  //   value: 100,
                  // ),
                  // CustomCard(
                  //     title: appLanguage
                  //         .words['StayInTouchInstagramTitle']!,
                  //     subtitle: appLanguage
                  //         .words['StayInTouchInstagramSubtitle']!,
                  //     url:
                  //         'https://www.instagram.com/mahmoued.martin/',
                  //     icon: FontAwesomeIcons.instagram,
                  //     iconColor: Colors.black,
                  //     kind: 'insta',
                  //     textDirection: appLanguage.textDirection),
                  // CustomSpacing(
                  //   value: 100,
                  // ),
                  // CustomCard(
                  //     title: appLanguage
                  //         .words['StayInTouchYoutubeTitle']!,
                  //     subtitle: appLanguage
                  //         .words['StayInTouchYoutubeSubtitle']!,
                  //     url:
                  //         'https://www.youtube.com/channel/UCedueKqOIz38zog0alc7_eg',
                  //     icon: FontAwesomeIcons.youtube,
                  //     iconColor: Colors.red,
                  //     kind: 'youtube',
                  //     textDirection: appLanguage.textDirection),
                  // CustomSpacing(
                  //   value: 100,
                  // ),
                  // CustomCard(
                  //     title: appLanguage
                  //         .words['StayInTouchTwitterTitle']!,
                  //     subtitle: appLanguage
                  //         .words['StayInTouchTwitterSubtitle']!,
                  //     url: 'https://twitter.com/MahmouedMartin2',
                  //     icon: FontAwesomeIcons.twitter,
                  //     iconColor: Colors.blue,
                  //     kind: 'twitter',
                  //     textDirection: appLanguage.textDirection),
                ],
              ),
            ),
          ),
        ])));
  }
}
