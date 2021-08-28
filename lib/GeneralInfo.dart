import 'Screens/AtaaMainPage.dart';
import 'Screens/TopThree/HomeScreen.dart';
import 'Screens/IntroPage.dart';
import 'Screens/MarkerCreationPage.dart';
import 'Screens/SettingsScreen.dart';
import 'Screens/StayInTouchPage.dart';

enum Pages {
  StayInTouchPage,
  HomeScreen,
  SettingsScreen,
  IntroPage,
  AtaaMainPage,
  MarkerCreationPage,
  ProfileScreen,
  StayInTouchScreen,
}

final pageOptions = [
  StayInTouchPage(),
  HomeScreen(),
  SettingsScreen(),
  IntroPage(),
  AtaaMainPage(),
  MarkerCreationPage(),
  StayInTouchPage()
];
