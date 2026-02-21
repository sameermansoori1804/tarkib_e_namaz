import 'dart:io';

import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../utils/AppConstants.dart';
import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';
import 'copetition_repository_interface.dart';

class CopetitionRepository implements CopetitionRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CopetitionRepository({ required this.sharedPreferences, required this.apiClient});



  @override
  Future add(value) {
    // TODO: implement add
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
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Response> getTaskList() async{
    // TODO: implement getTaskList
    return await apiClient.getData(AppConstants.get_compition_task);

  }

  @override
  Future<Response> getLeaderBoard() async{
    // TODO: implement getTaskList
    return await apiClient.getData(AppConstants.leaderboard);

  }
  @override
  Future<Response> getWalletHistories() async{
    // TODO: implement getTaskList
    return await apiClient.getData(AppConstants.walletHistory);

  }

  @override
  Future<Response> submitWithdrawRequest(
      File? imageFile,
      Map<String, String> body,
      ) async {


    if (imageFile != null) {
      XFile xFile = XFile(imageFile.path);
      List<MultipartBody> multipartBody = [];

      multipartBody.add(
        MultipartBody(
          'image',   // API field name
          xFile,
        ),
      );
      Response response = await apiClient.postMultipartData(
        AppConstants.withdrawalRequest,
        body,
        multipartBody,
      );

      return response;
    }

    Response response = await apiClient.postData(
      AppConstants.withdrawalRequest,
      body
    );


    return response;
  }

  @override
  Future<Response> submitTask(int taskId, {int? value}) async {
    // TODO: implement submitTask
    return await apiClient.postData(AppConstants.taskSubmit, {"id":taskId,"value":value ?? ""});
  }
}