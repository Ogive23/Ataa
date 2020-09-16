import 'package:feedme/Custom_Widgets/card.dart';
import 'package:feedme/Session/session_manager.dart';
import 'package:feedme/Themes/app_language.dart';
import 'package:feedme/Themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class StayInTouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    AppLanguage appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: appTheme.themeData.appBarTheme.color,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appTheme.themeData.appBarTheme.color,
        title: Text(
          appLanguage.language=='En'?'Our Society':'مجتمعنا',
          style: appTheme.themeData.textTheme.title,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
        decoration: BoxDecoration(color: appTheme.themeData.backgroundColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: NativeBannerAdSize.HEIGHT_50.height.toDouble(),
                  child: FacebookNativeAd(
                    placementId: "666800453940153_669631920323673",
                    adType: NativeAdType.NATIVE_BANNER_AD,
                    bannerAdSize: NativeBannerAdSize.HEIGHT_50,
                    width: double.infinity,
                    backgroundColor: appTheme.themeData.backgroundColor,
                    titleColor: appTheme.themeData.accentColor,
                    descriptionColor: appTheme.themeData.accentColor,
                    buttonColor: Colors.deepPurple,
                    buttonTitleColor: appTheme.themeData.accentColor,
                    buttonBorderColor: appTheme.themeData.accentColor,
                    keepAlive: true,
                    labelColor: Colors.transparent,
                    listener: (result, value) {
                      print("Native Ad: $result --> $value");
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              card(
                  appTheme.themeData.cardTheme.color,
                  appTheme.themeData.textTheme.body2,
                  appLanguage.language=='En'?'Facebook':'فيسبوك',
                  appLanguage.language=='En'?'Visit our facebook Page.':'زوروا صفحتنا.',
                  'https://www.facebook.com/ogive23/',
                  FontAwesomeIcons.facebook,
                  Colors.blue,
                  'fb',
                  appLanguage.language=='En'? TextDirection.ltr:TextDirection.rtl
              ),
              SizedBox(
                height: 20,
              ),
              card(
                  appTheme.themeData.cardTheme.color,
                  appTheme.themeData.textTheme.body2,
                  appLanguage.language=='En'?'Instagram':'إنستجرام',
                  appLanguage.language=='En'?'Visit our Instagram Account.':'زوروا حسابنا علي إنستجرام.',
                  'https://www.instagram.com/mahmoued.martin/',
                  FontAwesomeIcons.instagram,
                  Colors.black,
                  'insta',
                  appLanguage.language=='En'? TextDirection.ltr:TextDirection.rtl
              ),
              SizedBox(
                height: 20,
              ),
              card(
                  appTheme.themeData.cardTheme.color,
                  appTheme.themeData.textTheme.body2,
                  appLanguage.language=='En'?'Youtube':'يوتيوب',
                  appLanguage.language=='En'?'Visit our youtube channel.':'زوروا قناتنا علي يوتيوب.',
                  'https://www.youtube.com/channel/UCedueKqOIz38zog0alc7_eg',
                  FontAwesomeIcons.youtube,
                  Colors.red,
                  'youtube',
                  appLanguage.language=='En'? TextDirection.ltr:TextDirection.rtl
              ),
              SizedBox(
                height: 20,
              ),
              card(
                  appTheme.themeData.cardTheme.color,
                  appTheme.themeData.textTheme.body2,
                  appLanguage.language=='En'?'Twitter':'تويتر',
                  appLanguage.language=='En'?'Find us on twitter.':'زورونا علي تويتر.',
                  'https://twitter.com/MahmouedMartin2',
                  FontAwesomeIcons.twitter,
                  Colors.blue,
                  'twitter',
                  appLanguage.language=='En'?TextDirection.ltr:TextDirection.rtl
              ),
            ],
          ),
        ),
      ),
    );
  }
}
