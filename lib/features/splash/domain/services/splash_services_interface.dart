import 'package:flutter_template/features/home/domain/models/prayer_data.dart';

import '../../../home/domain/models/home_data.dart';

abstract class SplashServiceInterface {
  bool isLoggedIn();
  Future<HomeData?> getHomeData(Map<String, dynamic> body);
  Future<List<Data>?> getLoadMorePrayer(Map<String, dynamic> body);

}