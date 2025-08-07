import 'package:flutter_template/features/home/domain/models/home_data.dart';

abstract class HomeServiceInterface {
  Future<HomeData?> getHomeData();

}