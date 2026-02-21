import 'package:flutter_template/features/sawal_jawab/domain/models/question_model.dart';
import 'package:flutter_template/features/sawal_jawab/domain/reposotories/sawaljawab_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../utils/AppConstants.dart';
import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';

class SawaljawabRepository implements SawaljawabRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SawaljawabRepository({ required this.sharedPreferences, required this.apiClient});




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
  Future<Response> askQuestion(String question) async {
    return  await apiClient.postData('${AppConstants.questions}',{"quetion":question});

  }
  @override
  Future<Response> getQuetionData(int page) async {
      Response response =
      await apiClient.getData('${AppConstants.questions}/$page');
      return response;

  }


}