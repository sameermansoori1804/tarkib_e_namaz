import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../interfaces/repository_interface.dart';
import '../models/social_log_in_body.dart';


abstract class AuthRepositoryInterface extends RepositoryInterface{
  bool isSharedPrefNotificationActive();


  Future<Response> logout();
  Future<Response> login({required String emailOrPhone, required String password, required String loginType, required String fieldType});
  Future<Response> otpLogin({required String phone, required String otp, required String loginType, required String verified});
  Future<bool> saveUserToken(String token, {bool alreadyInApp = false});
  Future<Response> updateToken({String notificationDeviceToken = ''});
  Future<bool> saveSharedPrefGuestId(String id);
  String getSharedPrefGuestId();
  Future<bool> clearSharedPrefGuestId();
  Future<bool> clearSharedData({bool removeToken = true});
  Future<Response> loginWithSocialMedia(SocialLogInBody socialLogInModel);
  bool isLoggedIn();
  Future<bool> clearSharedAddress();
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode);
  String getUserNumber();
  String getUserCountryCode();
  String getUserPassword();
  Future<bool> clearUserNumberAndPassword();
  String getUserToken();
  Future<Response> updateZone();
  Future<bool> saveGuestContactNumber(String number);
  String getGuestContactNumber();
  Future<bool> saveDmTipIndex(String index);
  String getDmTipIndex();
  Future<bool> saveEarningPoint(String point);
  String getEarningPint();
  Future<void> setNotificationActive(bool isActive);
  Future<String?> saveDeviceToken();
}