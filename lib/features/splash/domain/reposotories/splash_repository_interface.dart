import '../../../../interfaces/repository_interface.dart';
import '../../../home/domain/models/home_data.dart';
import '../../../home/domain/models/prayer_data.dart';

abstract class SplashRepositoryInterface extends RepositoryInterface {
  bool isLoggedIn();
  Future<HomeData?> getHomeData(Map<String, dynamic> body);
  Future<List<Data>?> getLoadMorePrayer(Map<String, dynamic> body);

}