import 'package:flutter/foundation.dart';
import 'package:flutter_template/features/common/screens/home_image_slider.dart';
import 'package:flutter_template/features/home/domain/models/home_data.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../home/domain/models/categories_model.dart';
import '../../home/domain/models/home_slider.dart';
import '../../home/domain/models/post_model.dart';
import '../domain/services/splash_services_interface.dart';

class SplashController extends GetxController implements GetxService {
  final SplashServiceInterface splashServiceInterface;

  SplashController({required this.splashServiceInterface});

  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Categories>? _categories = [];
  List<Categories>? get categories=>_categories;


  List<Slider>? _sliderImage = [];
  List<Slider>? get sliderImage=>_sliderImage;



  Future<bool> getHomeData() async {
    _isLoading = true;
    HomeData? homeData;
    homeData = await splashServiceInterface.getHomeData();

    if(homeData !=null){
      if(homeData.categories!.isNotEmpty){
        _categories?.addAll(homeData.categories as Iterable<Categories>);
        print("farukh");
        print(_categories?.length);
        print("farukh");
        _isLoading = false;
      }


      if(homeData.sliders!.isNotEmpty){
        _sliderImage?.addAll(homeData.sliders as Iterable<Slider>);
        print(_sliderImage?.length);
        _isLoading = false;
      }
    }
    update();
    return true;

  }



}