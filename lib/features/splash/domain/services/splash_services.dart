

import 'dart:async';

import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services_interface.dart';
import 'package:get/get.dart';

import '../../../home/domain/models/home_data.dart';


class SplashService implements SplashServiceInterface{

  final SplashRepositoryInterface splashRepositoryInterface;

  SplashService({required this.splashRepositoryInterface});


  @override
  bool isLoggedIn() {
    return splashRepositoryInterface.isLoggedIn();
  }


  @override
  Future<HomeData?> getHomeData() async {
    return await splashRepositoryInterface.getHomeData();
  }

}