import 'package:flutter/material.dart';

import '../../../../interfaces/repository_interface.dart';


abstract class LanguageRepositoryInterface extends RepositoryInterface {
  Locale getLocaleFromSharedPref();
  void saveLanguage(Locale locale);
  void saveCacheLanguage(Locale locale);
  Locale getCacheLocaleFromSharedPref();
}