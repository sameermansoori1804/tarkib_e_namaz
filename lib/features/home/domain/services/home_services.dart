

import 'dart:async';

import 'package:flutter_template/features/home/domain/models/home_data.dart';
import '../reposotories/home_repository_interface.dart';
import 'home_services_interface.dart';


class HomeService implements HomeServiceInterface{

  final HomeRepositoryInterface homeRepositoryInterface;
  HomeService({required this.homeRepositoryInterface});

  @override
  Future<HomeData?> getHomeData() async {
    return await homeRepositoryInterface.getHomeData();
  }


}