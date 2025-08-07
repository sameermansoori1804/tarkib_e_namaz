import 'package:flutter_template/features/splash/domain/reposotories/splash_repository_interface.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/api_client.dart';
import '../../../../utils/AppConstants.dart';
import '../../../home/domain/models/home_data.dart';

class SplashRepository implements SplashRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepository({ required this.sharedPreferences, required this.apiClient});


  @override
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  @override
  Future<HomeData?> getHomeData() async {

    HomeData? homeData;

    Response response = await apiClient.postData(AppConstants.homeData,{});
    print(response.body);

    if(response.statusCode == 200) {
      homeData = HomeData.fromJson(response.body);

    }
    return homeData;
  }

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


}