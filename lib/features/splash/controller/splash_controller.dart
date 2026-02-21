import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_template/features/common/screens/home_image_slider.dart';
import 'package:flutter_template/features/home/domain/models/home_data.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/AppConstants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../helpers/adhan_notification_service_helper.dart';
import '../../auth/domain/models/user.dart';
import '../../common/controller/location_controller.dart';
import '../../home/domain/models/categories_model.dart';
import '../../home/domain/models/home_slider.dart';
import '../../home/domain/models/post_model.dart';
import '../../home/domain/models/prayer_data.dart';
import '../../home/domain/models/tasbih_model.dart';
import '../../tasbih/controller/tasbih_controller.dart';
import '../domain/services/splash_services_interface.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class SplashController extends GetxController implements GetxService {
  final SplashServiceInterface splashServiceInterface;

  SplashController({required this.splashServiceInterface});

  bool _firstTimeConnectionCheck = true;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Categories>? _categories = [];
  List<Categories>? get categories=>_categories;

  List<Tasbih>? _tasbihs = [];
  List<Tasbih>? get tasbihs => _tasbihs;


  List<Slider>? _sliderImage = [];
  List<Slider>? get sliderImage=>_sliderImage;

  PrayerTime? _prayerTime = PrayerTime();
  PrayerTime? get prayerTime=>_prayerTime;
  final adhanNotificationServices = AdhanNotificationServiceImpl();


  Map<String, dynamic>? _data = {};
  Map<String, dynamic>? get data => _data;


  UserModel? _user = null;
  UserModel? get user =>_user;

  Future<UserModel?> getUserData() async {

    if(!splashServiceInterface.isLoggedIn()){
      return null;
    }

    _isLoading = true;
    _user = await splashServiceInterface.getUserData();
    _isLoading = false;
    update();
    return _user;
  }


   getConfigData() async {
    Response response = await splashServiceInterface.getConfigData();
    _data = response.body;



    update();
    return _user;
  }


  Future<void> sendNotification() async {


    DateTime time = DateTime.now().add(const Duration(minutes: 2));

    // adhanNotificationServices.sendNotification(title: "test", body: "farukh khan");
    //
    await adhanNotificationServices.scheduleNotification(
        id: 1,
        title: "Fazar",
        body: 'farukh Khjan',
        dateTime: time,
        payload: time.toIso8601String());
  }

  List<PendingNotificationRequest> pendingList = [];
  List<ActiveNotification> activeList = [];

  Future<void> getNotification() async {
    pendingList = await adhanNotificationServices.getPendingNotifications();
    activeList = await adhanNotificationServices.getActiveNotifications();


    print("farukh-------->");
    print(pendingList[0].body);
    print(activeList.length);
    print("farukh-------->");

  }

  Future<bool> getHomeData(Map<String, dynamic> body) async {
    _isLoading = true;
    HomeData? homeData;



    homeData = await splashServiceInterface.getHomeData(body);

    if(homeData !=null){
      if(homeData.categories!.isNotEmpty){
        _categories?.addAll(homeData.categories as Iterable<Categories>);
      }


      if(homeData.sliders!.isNotEmpty){
        _sliderImage?.addAll(homeData.sliders as Iterable<Slider>);
        print(_sliderImage?.length);

      }


      if(homeData.tasbihs!.isNotEmpty){
        _tasbihs?.addAll(homeData.tasbihs as Iterable<Tasbih>);
        final TasbihController tasbihController = Get.find<TasbihController>();
        await tasbihController.syncFromTasbihList(_tasbihs!);
      }


      if(homeData.prayerTime! != null){
        _prayerTime = homeData.prayerTime as PrayerTime?;
      }
    }

    await adhanNotificationServices.initializeNotification();
    _isLoading = false;
    update();
    return true;

  }

  Future<void> loadMorePrayerTimes(int? page) async {
    _isLoading = true;
    final locationController = Get.find<LocationController>();
    DateTime now = DateTime.now();
    int month =  now.month+page!;
    int year =  now.year;
    if(month>12){
      month = 1;
      year = now.year+1;
    }
    Map<String, dynamic> body = {
      "latitude": locationController.latitude,
      "longitude": locationController.longitude,
      "tune": locationController.tune,
      "year": year.toString(),
      "month": month.toString().padLeft(2, '0'), // 2-digit month
      "days": locationController.daySetting     // 2-digit day
    };
    List<Data>? d = await splashServiceInterface.getLoadMorePrayer(body);
    _prayerTime!.data!.addAll(d as Iterable<Data>); // now safe
    update();

  }


  }