import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../../../../helpers/google_auth_helper.dart';
import '../models/auth_response_model.dart';
import '../models/response_model.dart';
import '../models/social_log_in_body.dart';
import '../reposotories/auth_repository_interface.dart';
import 'auth_service_interface.dart';


class AuthService implements AuthServiceInterface{
  final AuthRepositoryInterface authRepositoryInterface;
  AuthService({required this.authRepositoryInterface});

  @override
  bool isSharedPrefNotificationActive() {
    return authRepositoryInterface.isSharedPrefNotificationActive();
  }


  @override
  Future<Response> logout() async {
   return await authRepositoryInterface.logout();

  }
  Future<void> googleLogin() async {
    final helper = GoogleAuthHelper();
    final socialBody = await helper.signIn();

    if (socialBody == null) return;

    ResponseModel response =await loginWithSocialMedia(socialBody);

    if (response.isSuccess) {
      Get.offAllNamed(RouteName.splashScreen);
    } else {
      Get.snackbar('Error', response.message ?? 'Login failed');
    }
  }
  @override
  Future<ResponseModel> loginWithSocialMedia(SocialLogInBody socialLogInModel, {bool isCustomerVerificationOn = false}) async {
    Response response = await authRepositoryInterface.loginWithSocialMedia(socialLogInModel);
    if (response.statusCode == 200) {
      AuthResponseModel authResponse = AuthResponseModel.fromJson(response.body);
      await _updateHeaderFunctionality(authResponse);
      return ResponseModel(true, authResponse.token??'', authResponseModel: authResponse);
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  Future<void> _updateHeaderFunctionality(AuthResponseModel authResponse, {bool alreadyInApp = false}) async {
    await authRepositoryInterface.saveUserToken(authResponse.token!);
  }

  @override
  Future<void> updateToken() async {
    await authRepositoryInterface.updateToken();
  }

  @override
  bool isLoggedIn() {
    return authRepositoryInterface.isLoggedIn();
  }


  @override
  String getSharedPrefGuestId() {
    return authRepositoryInterface.getSharedPrefGuestId();
  }

  @override
  Future<bool> clearSharedData({bool removeToken = true}) async {
    return await authRepositoryInterface.clearSharedData(removeToken: removeToken);
  }

  @override
  Future<bool> clearSharedAddress() async {
    return await authRepositoryInterface.clearSharedAddress();
  }

  @override
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode) async {
    await authRepositoryInterface.saveUserNumberAndPassword(number, password, countryCode);
  }

  @override
  String getUserNumber() {
    return authRepositoryInterface.getUserNumber();
  }

  @override
  String getUserCountryCode() {
    return authRepositoryInterface.getUserCountryCode();
  }

  @override
  String getUserPassword() {
    return authRepositoryInterface.getUserPassword();
  }

  @override
  Future<bool> clearUserNumberAndPassword() async {
    return await authRepositoryInterface.clearUserNumberAndPassword();
  }

  @override
  String getUserToken() {
    return authRepositoryInterface.getUserToken();
  }

  @override
  Future updateZone() async {
    await authRepositoryInterface.updateZone();
  }

  @override
  Future<bool> saveGuestContactNumber(String number) async {
    return authRepositoryInterface.saveGuestContactNumber(number);
  }

  @override
  String getGuestContactNumber() {
    return authRepositoryInterface.getGuestContactNumber();
  }

  @override
  Future<bool> saveDmTipIndex(String index) async {
    return await authRepositoryInterface.saveDmTipIndex(index);
  }

  @override
  String getDmTipIndex() {
    return authRepositoryInterface.getDmTipIndex();
  }

  @override
  Future<bool> saveEarningPoint(String point) async {
    return await authRepositoryInterface.saveEarningPoint(point);
  }

  @override
  String getEarningPint() {
    return authRepositoryInterface.getEarningPint();
  }

  @override
  Future<void> setNotificationActive(bool isActive) async {
   await authRepositoryInterface.setNotificationActive(isActive);
  }

  @override
  Future<String?> saveDeviceToken() async {
    return await authRepositoryInterface.saveDeviceToken();
  }

}