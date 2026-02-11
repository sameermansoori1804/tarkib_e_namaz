import 'package:get/get.dart';


abstract class AuthServiceInterface{
  bool isSharedPrefNotificationActive();
  Future<Response> logout();
  Future<void> googleLogin();
  Future<void> updateToken();
  bool isLoggedIn();
  String getUserToken();
  Future<void> setNotificationActive(bool isActive);
  Future<String?> saveDeviceToken();
}