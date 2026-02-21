

import 'dart:async';
import 'dart:io';

import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/services/splash_services_interface.dart';
import 'package:get/get.dart';

import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';
import '../reposotories/copetition_repository_interface.dart';
import 'copetition_services_interface.dart';


class CopetitionService implements CopetitionServiceInterface{

  final CopetitionRepositoryInterface splashRepositoryInterface;

  CopetitionService({required this.splashRepositoryInterface});

  @override
  Future<Response> getTaskList() async{
    // TODO: implement getHomeData
    return await splashRepositoryInterface.getTaskList();
  }
 @override
  Future<Response> getLeaderBoard() async{
    // TODO: implement getHomeData
    return await splashRepositoryInterface.getLeaderBoard();
  }
 @override
  Future<Response> getWalletHistories() async{
    // TODO: implement getHomeData
    return await splashRepositoryInterface.getWalletHistories();
  }
 @override
  Future<Response> submitWithdrawRequest(File? imageFile,Map<String, String> body) async{
    // TODO: implement getHomeData
    return await splashRepositoryInterface.submitWithdrawRequest(imageFile,body);
  }

  @override
  Future<Response> submitTask(int taskId, {int? value}) async {
    // TODO: implement submitTask
    return await splashRepositoryInterface.submitTask(taskId,value: value);
  }




}