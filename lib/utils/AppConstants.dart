import 'package:get/get.dart';

import '../features/language/domain/models/LanguageModel.dart';
import 'images.dart';


class AppConstants {
  static const
  String appName = 'AaharCart';
  static const
  double appVersion = 15;
  ///Flutter Version: 3.24.4
  static const String fontFamily = 'Roboto';
  static const bool payInWevView = false;
  static const int balanceInputLen = 10;
  static const String webHostedUrl = 'https://tarkibenamaz.visticsolutions.in/';
  static const bool useReactWebsite = false;

  static const String baseUrl = 'https://tarkibenamaz.visticsolutions.in/123456789';



  static const String homeData = '/getsettings';



  /// Shared Key
  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cacheCountryCode = 'cache_country_code';
  static const String cacheLanguageCode = 'cache_language_code';
  static const String localizationKey = 'X-localization';
  static const String userAddress = '6ammart_user_address';





  static List<LanguageModel> languages = [
    // LanguageModel(
    //     imageUrl: Images.english,
    //     languageName: 'English',
    //     countryCode: 'US',
    //     languageCode: 'en'),
    // LanguageModel(
    //     imageUrl: Images.arabic,
    //     languageName: 'عربى',
    //     countryCode: 'SA',
    //     languageCode: 'ar'),

    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),

    LanguageModel(
        imageUrl: Images.hindi,
        languageName: 'हिंदी',
        countryCode: 'IN',
        languageCode: 'hi'),


    // LanguageModel(imageUrl: Images.arabic, languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
    // LanguageModel(imageUrl: Images.bengali, languageName: 'Bengali', countryCode: 'BN', languageCode: 'bn'),
  ];
}