import '../../../../interfaces/repository_interface.dart';
import '../../../home/domain/models/home_data.dart';

abstract class SplashRepositoryInterface extends RepositoryInterface {
  bool isLoggedIn();
  Future<HomeData?> getHomeData();

}