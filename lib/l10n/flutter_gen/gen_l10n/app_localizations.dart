import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get lang;

  /// No description provided for @thereIsNoData.
  ///
  /// In en, this message translates to:
  /// **'There is no data'**
  String get thereIsNoData;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @playRoleOne.
  ///
  /// In en, this message translates to:
  /// **'Let\'s role-play, you only know about fruits and vegetables, other than greetings or unrelated questions about fruits or vegetables, you pretend not to know.'**
  String get playRoleOne;

  /// No description provided for @cantSendMultipleMessage.
  ///
  /// In en, this message translates to:
  /// **'You can\'t send multiple messages at a time'**
  String get cantSendMultipleMessage;

  /// No description provided for @askQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please ask any questions about fruits or vegetables'**
  String get askQuestion;

  /// No description provided for @playRoleSecond.
  ///
  /// In en, this message translates to:
  /// **'Let\'s role play, you become a fruit and vegetable expert, in addition to greetings and questions related to fruits and vegetables, answer \'Sorry I don\'t understand, I only understand about fruits and vegetables\'. If the question is about fruits and vegetables, answer based on the context of the previous question as a reference.'**
  String get playRoleSecond;

  /// No description provided for @questionsToBeAnswered.
  ///
  /// In en, this message translates to:
  /// **'questions to be answered'**
  String get questionsToBeAnswered;

  /// No description provided for @nutriAIGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, I\'m NutriAI Bot'**
  String get nutriAIGreeting;

  /// No description provided for @generalInfo.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInfo;

  /// No description provided for @characteristics.
  ///
  /// In en, this message translates to:
  /// **'Characteristics'**
  String get characteristics;

  /// No description provided for @nutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutrition;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'List of general nutrition information for'**
  String get generalInformation;

  /// No description provided for @definitionAndBenefits.
  ///
  /// In en, this message translates to:
  /// **'Definition and benefits of consuming foods that contain'**
  String get definitionAndBenefits;

  /// No description provided for @todaysArticle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s article recommendation'**
  String get todaysArticle;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @fruitUpper.
  ///
  /// In en, this message translates to:
  /// **'FRUIT'**
  String get fruitUpper;

  /// No description provided for @vegetableUpper.
  ///
  /// In en, this message translates to:
  /// **'VEGETABLE'**
  String get vegetableUpper;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @loginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login with your account'**
  String get loginFirst;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @loginWithApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get loginWithApple;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @logoutSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Logout Successfully'**
  String get logoutSuccessfully;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @deletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'account deleted successfully'**
  String get deletedSuccessfully;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @todaysRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Today\'s recommendation'**
  String get todaysRecommendation;

  /// No description provided for @scanNow.
  ///
  /// In en, this message translates to:
  /// **'SCAN NOW TO DETECT'**
  String get scanNow;

  /// No description provided for @fruitVegetableUpper.
  ///
  /// In en, this message translates to:
  /// **'FRUITS AND VEGETABLES'**
  String get fruitVegetableUpper;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'GOOD MORNING'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'GOOD AFTERNOON'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'GOOD EVENING'**
  String get goodEvening;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @fruitVegetable.
  ///
  /// In en, this message translates to:
  /// **'Fruits and Vegetables'**
  String get fruitVegetable;

  /// No description provided for @fruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get fruit;

  /// No description provided for @vegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetable'**
  String get vegetable;

  /// No description provided for @dataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Data not found'**
  String get dataNotFound;

  /// No description provided for @searchFruitsVegetables.
  ///
  /// In en, this message translates to:
  /// **'Search for Fruits or Vegetables'**
  String get searchFruitsVegetables;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Oops, an error occurred'**
  String get errorOccurred;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get back;

  /// No description provided for @noCameraAvailable.
  ///
  /// In en, this message translates to:
  /// **'No camera available'**
  String get noCameraAvailable;

  /// No description provided for @scanFruitVegetable.
  ///
  /// In en, this message translates to:
  /// **'Scan fruits or vegetables'**
  String get scanFruitVegetable;

  /// No description provided for @nutrientsAndMinerals.
  ///
  /// In en, this message translates to:
  /// **'Nutrients and minerals'**
  String get nutrientsAndMinerals;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noFruitVegetable.
  ///
  /// In en, this message translates to:
  /// **'No fruits/vegetables detected'**
  String get noFruitVegetable;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'YES'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'NO'**
  String get no;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'SCAN'**
  String get scan;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'HOME'**
  String get home;

  /// No description provided for @article.
  ///
  /// In en, this message translates to:
  /// **'ARTICLE'**
  String get article;

  /// No description provided for @askAboutFruitsVegetable.
  ///
  /// In en, this message translates to:
  /// **'ask about fruits or vegetables'**
  String get askAboutFruitsVegetable;

  /// No description provided for @benefitsConsuming.
  ///
  /// In en, this message translates to:
  /// **'Benefits of consuming'**
  String get benefitsConsuming;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @cannotScan.
  ///
  /// In en, this message translates to:
  /// **'Connect your device to the internet to use the scan feature'**
  String get cannotScan;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetTitle;

  /// No description provided for @noInternetAlert.
  ///
  /// In en, this message translates to:
  /// **'You cannot use some features such as scanning, chatting with NutriAI ChatBot, logging into your account, or deleting your account.'**
  String get noInternetAlert;

  /// No description provided for @cannotChat.
  ///
  /// In en, this message translates to:
  /// **'Connect your device to the internet to chat with NutriAI ChatBot'**
  String get cannotChat;

  /// No description provided for @cannotSearch.
  ///
  /// In en, this message translates to:
  /// **'Data not found\nor your device is not connected to the internet'**
  String get cannotSearch;

  /// No description provided for @cannotDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'You cannot delete your account because your device is not connected to the internet'**
  String get cannotDeleteAccount;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
