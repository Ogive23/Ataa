// ignore_for_file: file_names, constant_identifier_names

import 'package:ataa/Screens/AchievementScreen.dart';
import 'package:ataa/Screens/ProfileScreen.dart';

import 'Screens/AtaaMainPage.dart';
import 'Screens/TopThree/HomeScreen.dart';
import 'Screens/IntroPage.dart';
import 'Screens/MarkerCreationPage.dart';
import 'Screens/SettingsScreen.dart';
import 'Screens/StayInTouchPage.dart';

const String BASE_URL = "http://192.168.1.155:8000";

enum Pages {
  StayInTouchPage,
  HomeScreen,
  SettingsScreen,
  IntroPage,
  AtaaMainPage,
  MarkerCreationPage,
  ProfileScreen,
  StayInTouchScreen,
  AchievementScreen
}

final pageOptions = [
  StayInTouchPage(),
  HomeScreen(),
  SettingsScreen(),
  IntroPage(),
  const AtaaMainPage(),
  const MarkerCreationPage(),
  const ProfileScreen(),
  StayInTouchPage(),
  const AchievementScreen()
];
