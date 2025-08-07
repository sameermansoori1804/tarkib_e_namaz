import 'package:flutter/material.dart';

import '../models/LanguageModel.dart';

abstract class LanguageServiceInterface {
  bool setLTR(Locale locale);
  Locale getLocaleFromSharedPref();
  setSelectedIndex(List<LanguageModel> languages, Locale locale);
  void saveLanguage(Locale locale);
  void saveCacheLanguage(Locale locale);
  Locale getCacheLocaleFromSharedPref();
}
