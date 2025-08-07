import '../../../home/domain/models/home_data.dart';

abstract class SplashServiceInterface {
  bool isLoggedIn();
  Future<HomeData?> getHomeData();

}