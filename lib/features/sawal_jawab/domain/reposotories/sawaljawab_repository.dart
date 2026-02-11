import 'package:flutter_template/features/sawal_jawab/domain/models/question_model.dart';
import 'package:flutter_template/features/sawal_jawab/domain/reposotories/sawaljawab_repository_interface.dart';
import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
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
  Future<List<QuestionModel>> getQuetionData(int page) async {
    try {
      Response response =
      await apiClient.getData('${AppConstants.questions}/$page');

      if (response.statusCode == 200) {
        List data = [];

        // 🔥 CASE 1: if API returns list directly
        if (response.body is List) {
          data = response.body;
        }

        // 🔥 CASE 2: if API returns { data: [] }
        else if (response.body['data'] != null) {
          data = response.body['data'];
        }

        return data.map((e) => QuestionModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Question API error: $e");
      return [];
    }
  }


}