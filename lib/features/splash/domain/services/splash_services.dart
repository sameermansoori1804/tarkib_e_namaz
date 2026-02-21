

import 'dart:async';

import 'package:flutter_template/features/auth/domain/models/user.dart';
import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services_interface.dart';
import 'package:get/get.dart';

import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';


class SplashService implements SplashServiceInterface{

  final SplashRepositoryInterface splashRepositoryInterface;

  SplashService({required this.splashRepositoryInterface});


  @override
  bool isLoggedIn() {
    return splashRepositoryInterface.isLoggedIn();
  }


  @override
  Future<HomeData?> getHomeData(Map<String, dynamic> body) async {
    return await splashRepositoryInterface.getHomeData(body);
  }


  @override
  Future<UserModel?> getUserData() async {
    return await splashRepositoryInterface.getUserData();
  }
  @override
  Future<List<Data>?> getLoadMorePrayer(Map<String, dynamic> body) async {
    return await splashRepositoryInterface.getLoadMorePrayer(body);
  }

  @override
  Future<Response> getConfigData() async{
    // TODO: implement getConfigData
    return await splashRepositoryInterface.getConfigData();

  }

}