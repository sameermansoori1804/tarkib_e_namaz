import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../utils/AppConstants.dart';
import '../models/social_log_in_body.dart';
import 'auth_repository_interface.dart';


class AuthRepository implements AuthRepositoryInterface{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepository({ required this.sharedPreferences, required this.apiClient});

  @override
  bool isSharedPrefNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }



  @override
  Future<Response> login({required String emailOrPhone, required String password, required String loginType, required String fieldType, bool alreadyInApp = false}) async {
    String guestId = getSharedPrefGuestId();
    Map<String, String> data = {
      "email_or_phone": emailOrPhone,
      "password": password,
      "login_type": loginType,
      "field_type": fieldType,
    };
    if(guestId.isNotEmpty) {
      data.addAll({"guest_id": guestId});
    }
    return await apiClient.postData(AppConstants.loginUri, data, handleError: false);
  }

  @override
  Future<Response> otpLogin({required String phone, required String otp, required String loginType, required String verified}) async {
    String guestId = getSharedPrefGuestId();
    Map<String, String> data = {
      "phone": phone,
      "login_type": loginType,
    };
    if(guestId.isNotEmpty) {
      data.addAll({"guest_id": guestId});
    }
    if(otp.isNotEmpty) {
      data.addAll({"otp": otp});
    }
    if(verified.isNotEmpty) {
      data.addAll({"verified": verified});
    }
    return await apiClient.postData(AppConstants.loginUri, data, handleError: false);
  }



  @override
  Future<Response> loginWithSocialMedia(SocialLogInBody socialLogInModel) async {
    Map<String, dynamic> data = socialLogInModel.toJson();
    return await apiClient.postData(AppConstants.loginUri, data);
  }

  @override
  Future<bool> saveUserToken(String token, {bool alreadyInApp = false}) async {
    apiClient.token = token;
    apiClient.updateHeader(token, sharedPreferences.getString(AppConstants.LANGUAGE_ID));
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  @override
  Future<Response> updateToken({String notificationDeviceToken = ''}) async {
    String? deviceToken;
    if(notificationDeviceToken.isEmpty){
      if (GetPlatform.isIOS && !GetPlatform.isWeb) {
        FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true, announcement: false, badge: true, carPlay: false,
          criticalAlert: false, provisional: false, sound: true,
        );
        if(settings.authorizationStatus == AuthorizationStatus.authorized) {
          deviceToken = await saveDeviceToken();
        }
      }else {
        deviceToken = await saveDeviceToken();
      }
      if(!GetPlatform.isWeb) {
        FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
        // FirebaseMessaging.instance.subscribeToTopic('zone_${AddressHelper.getUserAddressFromSharedPref()!.zoneId}_customer');
      }
    }
    print("farukh---khan");
    return await apiClient.postData(AppConstants.tokenUri, {"_method": "put", "cm_firebase_token": notificationDeviceToken.isNotEmpty ? notificationDeviceToken : deviceToken}, handleError: false);
  }

  @override
  Future<String?> saveDeviceToken() async {
    String? deviceToken = '@';
    if(!GetPlatform.isWeb) {
      try {
        deviceToken = (await FirebaseMessaging.instance.getToken())!;
      }catch(_) {}
    }
    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }

  @override
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }
  @override
  Future<Response> logout() async {

    Response response =await apiClient.getData(AppConstants.logout);
    if(response.statusCode == 200){
      clearSharedData();
    }
    return response;
  }

  @override
  Future<bool> clearSharedData({bool removeToken = true}) async {

    sharedPreferences.remove(AppConstants.token);
    apiClient.token = null;
    if(sharedPreferences.getString(AppConstants.userAddress) != null){
      // AddressModel? addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      apiClient.updateHeader(null, sharedPreferences.getString(AppConstants.LANGUAGE_ID)
      );
    }
    return true;
  }

  @override
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }


  @override
  Future<void> setNotificationActive(bool isActive) async {
    if(isActive) {
      await updateToken();
    }else {
      if(!GetPlatform.isWeb) {
        await updateToken(notificationDeviceToken: '@');
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic);
        if(isLoggedIn()) {
          // FirebaseMessaging.instance.unsubscribeFromTopic('zone_${AddressHelper.getUserAddressFromSharedPref()!.zoneId}_customer');
        }
      }
    }
    sharedPreferences.setBool(AppConstants.notification, isActive);
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> clearSharedAddress() {
    // TODO: implement clearSharedAddress
    throw UnimplementedError();
  }

  @override
  Future<bool> clearSharedPrefGuestId() {
    // TODO: implement clearSharedPrefGuestId
    throw UnimplementedError();
  }

  @override
  Future<bool> clearUserNumberAndPassword() {
    // TODO: implement clearUserNumberAndPassword
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  String getDmTipIndex() {
    // TODO: implement getDmTipIndex
    throw UnimplementedError();
  }

  @override
  String getEarningPint() {
    // TODO: implement getEarningPint
    throw UnimplementedError();
  }

  @override
  String getGuestContactNumber() {
    // TODO: implement getGuestContactNumber
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  String getSharedPrefGuestId() {
    // TODO: implement getSharedPrefGuestId
    throw UnimplementedError();
  }

  @override
  String getUserCountryCode() {
    // TODO: implement getUserCountryCode
    throw UnimplementedError();
  }

  @override
  String getUserNumber() {
    // TODO: implement getUserNumber
    throw UnimplementedError();
  }

  @override
  String getUserPassword() {
    // TODO: implement getUserPassword
    throw UnimplementedError();
  }

  @override
  bool isGuestLoggedIn() {
    // TODO: implement isGuestLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<bool> saveDmTipIndex(String index) {
    // TODO: implement saveDmTipIndex
    throw UnimplementedError();
  }

  @override
  Future<bool> saveEarningPoint(String point) {
    // TODO: implement saveEarningPoint
    throw UnimplementedError();
  }

  @override
  Future<bool> saveGuestContactNumber(String number) {
    // TODO: implement saveGuestContactNumber
    throw UnimplementedError();
  }

  @override
  Future<bool> saveSharedPrefGuestId(String id) {
    // TODO: implement saveSharedPrefGuestId
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode) {
    // TODO: implement saveUserNumberAndPassword
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Response> updateZone() {
    // TODO: implement updateZone
    throw UnimplementedError();
  }

}