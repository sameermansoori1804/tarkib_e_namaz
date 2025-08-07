import '../../../../interfaces/repository_interface.dart';
import '../models/home_data.dart';

abstract class HomeRepositoryInterface<T> extends RepositoryInterface {
  Future<HomeData?> getHomeData();

}