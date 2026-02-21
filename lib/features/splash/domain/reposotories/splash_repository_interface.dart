import '../../../../interfaces/repository_interface.dart';
import '../../../auth/domain/models/user.dart';
import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';
import 'package:get/get.dart';

abstract class SplashRepositoryInterface extends RepositoryInterface {
  bool isLoggedIn();
  Future<HomeData?> getHomeData(Map<String, dynamic> body);
  Future<List<Data>?> getLoadMorePrayer(Map<String, dynamic> body);
  Future<UserModel?> getUserData();
  Future<Response> getConfigData();

}