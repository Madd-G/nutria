import 'dart:ui';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  String selectedLanguage = 'English';

  // String selectedLanguage = 'Indonesia';
  // String languageCode = 'en_US';
  // String countryCode = 'EN_US';
  Locale locale = const Locale('en_US', 'EN_US');
  // Locale locale = const Locale('id_ID', 'ID_ID');
  // late Locale locale;

  void changeLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }

  void setLanguage(String lang) {
    selectedLanguage = lang;
    update();
  }
}
