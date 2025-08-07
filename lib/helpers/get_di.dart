import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_template/features/ads/controller/ads_controller.dart';
import 'package:flutter_template/features/common/controller/location_controller.dart';
import 'package:flutter_template/features/language/domain/reposotories/language_repository.dart';
import 'package:flutter_template/features/language/domain/reposotories/language_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';
import '../features/language/controller/language_controller.dart';
import '../features/language/domain/models/LanguageModel.dart';
import '../features/language/domain/services/language_service.dart';
import '../features/language/domain/services/language_service_interface.dart';
import '../features/splash/controller/splash_controller.dart';
import '../features/splash/domain/reposotories/splash_repository.dart';
import '../features/splash/domain/reposotories/splash_repository_interface.dart';
import '../utils/AppConstants.dart';


Future<Map<String, Map<String, String>>> init() async {
  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
  /// Repository interface
  SplashRepositoryInterface splashRepositoryInterface = SplashRepository(sharedPreferences: Get.find(), apiClient: Get.find());
  Get.lazyPut(() => splashRepositoryInterface);
  
  LanguageRepositoryInterface languageRepositoryInterface = LanguageRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(()=>languageRepositoryInterface);
  
  /// Service Interface

  SplashServiceInterface splashServiceInterface = SplashService(splashRepositoryInterface: Get.find());
  Get.lazyPut(() => splashServiceInterface);

  LanguageServiceInterface languageServiceInterface = LanguageService(languageRepositoryInterface: Get.find());
  Get.lazyPut(()=>languageServiceInterface);


  /// Controller
  // Get.lazyPut(() => SplashController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashServiceInterface: Get.find()));
  Get.lazyPut(() => LocationController());
  Get.lazyPut(() => AdsController());
  Get.lazyPut(() => LocalizationController(languageServiceInterface: Get.find()));


  /// Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    print('${languageModel.languageCode}');

    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
