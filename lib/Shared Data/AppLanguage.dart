// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  late String language;
  late Map<String, String> words;
  late TextDirection textDirection;
  late Alignment alignment;
  AppLanguage(this.language) {
    textDirection = initTextDirection(language);
    alignment = initAlignment(language);
    words = initWords(language);
  }
  changeLanguage(String language) {
    this.language = language;
    textDirection = initTextDirection(this.language);
    alignment = initAlignment(this.language);
    words = initWords(this.language);
    notifyListeners();
  }

  Map<String, String> initWords(String language) {
    return language == 'En'
        ? {
            'bottomNavigationItemFirst': 'Stay in touch',
            'bottomNavigationItemSecond': 'Home',
            'bottomNavigationItemThird': 'Settings',
            'StayInTouchTitle': 'Our Society',
            'StayInTouchFacebookTitle': 'Facebook',
            'StayInTouchFacebookSubtitle': 'Visit our facebook Page.',
            'StayInTouchInstagramTitle': 'Instagram',
            'StayInTouchInstagramSubtitle': 'Visit our Instagram Account.',
            'StayInTouchYoutubeTitle': 'Youtube',
            'StayInTouchYoutubeSubtitle': 'Visit our youtube channel.',
            'StayInTouchTwitterTitle': 'Twitter',
            'StayInTouchTwitterSubtitle': 'Find us on twitter.',
            'HomeTitle': 'Ataa',
            'HomeBody':
                'Ataa is a program that helps you to save people from starving by sharing your food with them.',
            'HomeSubtitle': 'Click to Proceed',
            'SettingsTitle': 'Settings',
            'SettingsDarkMode': 'DarkMode',
            'SettingsLanguage': 'Language',
            'AtaaIntroInfo': 'Info',
            'AtaaIntroAchievementCenter': 'Achievement Center\nComing Soon!',
            'AtaaIntroFirstButton': 'Share your food',
            'AtaaIntroSecondButton': 'Volunteer',
            'AtaaIntroWord':
                'Thank you for making the world a better place 😀',
            'AchievementCenterOne': 'Hey, you have',
            'AchievementCenterTwo': 'Markers published',
            'AchievementCenterThree': '&',
            'AchievementCenterFour': 'Markers collected',
      'AchievementCenterFive': 'Your Current Level is ',
      'AchievementCenterSix': 'Latest acquired badge was ',
      'AchievementCenterSeven': 'There is no badges acquired',
      'AchievementCenterEight': 'Head to Your Achievement Center',
            'MarkerCreationTitle': 'Food Sharing',
            'MarkerCreationSubtitle':
                'Remember That\n\nYou Don\'t Only Share It With The Poor\nSo Share the best you have.',
            'MarkerCreationFood': ' Food ',
            'MarkerCreationDrink': ' Drink ',
            'MarkerCreationBoth': ' Both of them ',
            'MarkerCreationDescription': 'Description',
            'MarkerCreationDescriptionDetails':
                'Describe it “E.g. it\'s 4 bags of meat & one cup of cooked rice”',
            'MarkerCreationPriority': 'Priority',
            'MarkerCreationType': 'Type',
            'MarkerCreationQuantity': 'Quantity(Bags)',
            'MarkerCreationCreateMarkerButton': 'Create Marker',
            'MarkerCreationLocationError':
                'We couldn\'t locate your location, Kindly try again',
            'MarkerCreationSuccessText': 'Thank You!',
            'MarkerCreationFailText': 'Please fill all the required Data',
            'InfoTitle': 'Info',
            'InfoSubtitle': 'Priorities',
            'InfoOne':
                '1 : Means it won\'t get rotten (Usually Banana, honey, uncooked rice, beans, Lentil).\n',
            'InfoTwo':
                '3 : Means it can waits for about 5 Days before it gets rotten(Usually Bread).\n',
            'InfoThree':
                '5 : Means it can waits for about 3 Days before it gets rotten(Usually Fruits).\n',
            'InfoFour':
                '7 : Means it can waits for about 24 hours before it gets rotten (Usually corn).\n',
            'InfoFive':
                '10 : Means it must be taken immediately & can\'t really waits for 3 hours (Usually meats, chickens, fish, milk & eggs or even cooked food).\n',
            'InfoNoteTitle': 'Notes',
            'InfoNoteOne':
                'Try to put mint or lemon in the bag cause it maybe keeps cats away\n',
            'InfoNoteTwoPartOne':
                'Don\'t use blue bags as cats like it the most ',
            'InfoNoteTwoPartTwo': 'try to use Pastel green ',
            'InfoNoteTwoPartThree': 'or Pastel purple.',
            'InfoOkButton': 'I Got it',
            'VolunteerInfoTitle': 'Priorities',
            'VolunteerInfoOne': 'Green : Means it won\'t get rotten.\n',
            'VolunteerInfoTwo':
                'Blue : Means it can waits for about 5 Days before it gets rotten.\n',
            'VolunteerInfoThree':
                'Azure : Means it can waits for about 3 Days before it gets rotten.\n',
            'VolunteerInfoFour':
                'Orange : Means it can waits for about 24 hours before it gets rotten.\n',
            'VolunteerInfoFive':
                'Red : Means it must be taken immediately & can\'t really waits for 3 hours.\n',
            'AtaaMainTitle': 'Volunteering',
            'AtaaMainCancelButton': 'Cancel',
            'AtaaMainAcquiringDialogOne': "meter to get it",
            'AtaaMainAcquiringActionOne': 'Go And Get IT!',
            'AtaaMainAcquiringActionTwo': 'Cancel',
            'AtaaMainFinishingDialogOne': 'Did you got it?',
            'AtaaMainFinishingDialogTwo': 'it seems that you are',
            'AtaaMainFinishingDialogThree': 'Meter away from.',
            'AtaaMainFinishingDialogFour': 'Yes i got it!',
            'AtaaMainFinishingDialogFive':
                'Thank You for making the world a better place!',
            'AtaaMainFinishingDialogSix': 'it\'s not found!',
            'AtaaMainFinishingDialogSeven':
                'Sorry for wasting your time, but consider that it has gone to it\'s place, Thank you!',
            'AtaaMainAcquiringErrorOne': 'We couldn\'t locate your location',
            'AtaaMainAcquiringErrorTwo':
                'Error happened while trying to show Google map.',
            'AtaaMainError': 'Something went wrong',
            'loading': 'Loading',
            'QuitDialogTitle': 'Are you sure?',
            'QuitDialogSubtitle': 'You wanna quit the app',
            'QuitActionButtonOne': 'Yes',
            'QuitActionButtonTwo': 'No',
          }
        : {
            'bottomNavigationItemFirst': 'أبقي علي تواصل',
            'bottomNavigationItemSecond': 'الرئيسية',
            'bottomNavigationItemThird': 'إعدادات',
            'StayInTouchTitle': 'مجتمعنا',
            'StayInTouchFacebookTitle': 'فيسبوك',
            'StayInTouchFacebookSubtitle': 'زوروا صفحتنا.',
            'StayInTouchInstagramTitle': 'إنستجرام',
            'StayInTouchInstagramSubtitle': 'زوروا حسابنا علي إنستجرام.',
            'StayInTouchYoutubeTitle': 'يوتيوب',
            'StayInTouchYoutubeSubtitle': 'زوروا قناتنا علي يوتيوب.',
            'StayInTouchTwitterTitle': 'تويتر',
            'StayInTouchTwitterSubtitle': 'زورونا علي تويتر.',
            'HomeTitle': 'عطاء',
            'HomeBody':
                'عطاء هو تطبيق يساعد في إنقاذ البشر من التضور جوعاً عن طريق مشاركة الطعام',
            'HomeSubtitle': 'أضغط للدخول',
            'SettingsTitle': 'الإعدادات',
            'SettingsDarkMode': 'الوضع المظلم',
            'SettingsLanguage': 'اللغة',
            'AtaaIntroInfo': 'معلومات',
            'AtaaIntroAchievementCenter': 'قريباً إن شاء الله.',
            'AtaaIntroFirstButton': 'شارك طعامك',
            'AtaaIntroSecondButton': 'تطوع',
            'AtaaIntroWord': 'شكراً لجعلك من العالم مكاناً أفضل 😀',
            'AchievementCenterOne': 'مرحباً، أنت تملك',
            'AchievementCenterTwo': 'طعام مشارك',
            'AchievementCenterThree': '&',
            'AchievementCenterFour': 'طعام تم توصيله',
      'AchievementCenterFive': 'مستواك الحالي هو ',
      'AchievementCenterSix': 'آخر شارة تم تجميعها هي ',
      'AchievementCenterSeven': 'لم تحصل علي أي من الشارات',
      'AchievementCenterEight': 'الذهاب إلي نظام الإنجازات الخاص بك',
            'MarkerCreationTitle': 'مشاركة الطعام',
            'MarkerCreationSubtitle':
                'تذكر ذلك\n\nأنت لا تشارك طعامك مع الفقراء فقط\n.فشارك أفضل ما تملك',
            'MarkerCreationFood': ' طعام ',
            'MarkerCreationDrink': ' شراب ',
            'MarkerCreationBoth': ' كلاهما ',
            'MarkerCreationDescription': 'معلومات',
            'MarkerCreationDescriptionDetails':
                'قم بوصفه علي سبيل المثال، ”يوجد هنا 4 أكياس من اللحم و طبق من الأرز“.',
            'MarkerCreationPriority': 'الأهمية',
            'MarkerCreationType': 'النوع',
            'MarkerCreationQuantity': 'عدد الحقائب',
            'MarkerCreationCreateMarkerButton': 'أضف العلامة',
            'MarkerCreationLocationError':
                'لم نتمكن من الحصول علي موقعك، الرجاء إعادة المحاولة',
            'MarkerCreationSuccessText': 'شكراً لك',
            'MarkerCreationFailText': 'من فضلك قم بملئ المعلومات المطلوبة',
            'InfoTitle': 'معلومات',
            'InfoSubtitle': 'الأهمية',
            'InfoOne':
                '1 : تعني أنه لن يتعفن (عادة ما يكون الموز، العسل، الأرز الغير مطهي، الفاصولياء،العدس و معظم أنواع الحبوب).\n',
            'InfoTwo':
                '3 : تعني أنه يمكنه الإنتظار لمدة 5 أيام قبل أن يتعفن (عادة الخبز). \n',
            'InfoThree':
                '5 : تعني أنه يمكنه الإنتظار لمدة 3 أيام قبل أن يتعفن (عادة الفاكهة). \n',
            'InfoFour':
                '7 : تعني أنه يمكنه الإنتظار لمدة يوم واحد قبل أن يتعفن (عادة الذرة). \n',
            'InfoFive':
                '10 : تعني أنه يجب أن يؤخذ الأن و لا يمكنه الإنتظار لأكثر من ثلاث ساعات (عادة اللحوم، الفراخ، الأسماك، اللبن و البيض أو حتي الطعام المطهي). \n',
            'InfoNoteTitle': 'ملاحظات',
            'InfoNoteOne':
                'حاول وضع النعناع أو الليمون بداخل الحقائب لأنها قد تبقي القطط بعيدة \n',
            'InfoNoteTwoPartOne': ' لا تستعمل حقائب زرقاء لأن القطط تحبها',
            'InfoNoteTwoPartTwo': ' حاول إستعمال حقائب خضراء فاتحة اللون',
            'InfoNoteTwoPartThree': ' أو أرجواني فاتح اللون.',
            'InfoOkButton': 'حسناً',
            'VolunteerInfoTitle': 'الأهمية',
            'VolunteerInfoOne': 'أخضر : تعني أنه لن يتعفن.\n',
            'VolunteerInfoTwo':
                'أزرق : تعني أنه يمكنه الإنتظار لمدة 5 أيام قبل أن يتعفن.\n',
            'VolunteerInfoThree':
                'أزرق سماوي : تعني أنه يمكنه الإنتظار لمدة 3 أيام قبل أن يتعفن. \n',
            'VolunteerInfoFour':
                'البرتقالي : تعني أنه يمكنه الإنتظار لمدة 24 ساعة قبل أن يتعفن. \n',
            'VolunteerInfoFive':
                'الأحمر : تعني أنه يجب أخذه في الحال ولا يمكنه الإنتظار لأكثر من 3 ساعات. \n',
            'AtaaMainTitle': 'التطوع',
            'AtaaMainCancelButton': 'التوقف',
            'AtaaMainAcquiringDialogOne': "متر للحصول عليها",
            'AtaaMainAcquiringActionOne': 'المشاركة',
            'AtaaMainAcquiringActionTwo': 'إغلاق',
            'AtaaMainFinishingDialogOne': 'هل حصلت عليها',
            'AtaaMainFinishingDialogTwo': 'يبدو أنك علي بعد',
            'AtaaMainFinishingDialogThree': 'متر من الحصول عليها',
            'AtaaMainFinishingDialogFour': 'نعم حصلت عليها',
            'AtaaMainFinishingDialogFive':
                'شكراً لجعلك من العالم مكاناً أفضل',
            'AtaaMainFinishingDialogSix': 'ليست موجودة',
            'AtaaMainFinishingDialogSeven':
                'نأسف لتضييع وقتك، لكن أعتبر أنها ذهبت لمكانها الصحيح، شكراً لك',
            'AtaaMainAcquiringErrorOne':
                'حدث خطأ ما لأننا لم نستطع أن نحصل علي موقعك',
            'AtaaMainAcquiringErrorTwo': 'حدث خطأ ما أثناء تحميل الخريطة',
            'AtaaMainError': 'حدث خطأ ما',
            'loading': 'جاري التحميل',
            'QuitDialogTitle': 'هل أنت متأكد؟',
            'QuitDialogSubtitle': 'هل  تريد إغلاق التطبيق',
            'QuitActionButtonOne': 'نعم',
            'QuitActionButtonTwo': 'لا',
          };
  }

  TextDirection initTextDirection(String language) {
    return language == 'En' ? TextDirection.ltr : TextDirection.rtl;
  }

  Alignment initAlignment(String language) {
    return language == 'En' ? Alignment.topRight : Alignment.topLeft;
  }
}
