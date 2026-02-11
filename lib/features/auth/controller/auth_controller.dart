import 'package:flutter/material.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../route/routes.dart';
import '../domain/services/auth_service_interface.dart';



class AuthController extends GetxController implements GetxService {
  final AuthServiceInterface authServiceInterface;
  AuthController({required this.authServiceInterface}){
    _notification = authServiceInterface.isSharedPrefNotificationActive();
  }

  bool _notification = true;
  bool get notification => _notification;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _guestLoading = false;
  bool get guestLoading => _guestLoading;

  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  bool _notificationLoading = false;
  bool get notificationLoading => _notificationLoading;


  final TextEditingController phoneController = TextEditingController();

  String selectedCountryCode = '+91';
  String countryIsoCode = 'IN';


  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  Future<void> updateToken() async {
    await authServiceInterface.updateToken();
  }
  void logout() async {
    Response response = await authServiceInterface.logout();
    if (response.statusCode == 200 && response.body['status'] == true) {
      Get.offAllNamed(RouteName.splashScreen);
    }

  }
  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
  }

  Future<void> socialLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    googleSignIn.disconnect();
  }

  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  Future<bool> setNotificationActive(bool isActive) async {
    _notificationLoading = true;
    update();
    _notification = isActive;
    await authServiceInterface.setNotificationActive(isActive);
    _notificationLoading = false;
    update();
    return _notification;
  }

  Future<String?> saveDeviceToken() async {
    return await authServiceInterface.saveDeviceToken();
  }

  void googleLogin() async {
    await authServiceInterface.googleLogin();

  }
}