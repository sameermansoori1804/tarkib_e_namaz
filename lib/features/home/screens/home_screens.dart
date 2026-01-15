import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/features/common/controller/location_controller.dart';
import 'package:flutter_template/features/common/screens/custome_app_bar.dart';
import 'package:flutter_template/features/common/screens/home_category_view.dart';
import 'package:flutter_template/features/common/screens/home_image_slider.dart';
import 'package:flutter_template/features/common/screens/home_option_menu.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';
import '../../common/screens/menuCard.dart';
import '../../prayer_time/controller/prayer_time_controller.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.find<PrayerTimeController>().initData();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColor.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text("Tarkib e Namaz",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on_sharp,color: AppColor.white,), // You can use any icon here
            onPressed: () {
              final locationController = Get.find<LocationController>();
              locationController.getCurrentLocation();
            },
          ),
          // You can add more icons if needed
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar


            // Image slider
            SliverToBoxAdapter(child: HomeImageSlider()),
            SliverToBoxAdapter(child: SizedBox(height: 8,)),

            // Menu card
            SliverToBoxAdapter(child: Menucard()),
            SliverToBoxAdapter(child: SizedBox(height: 8,)),

            // Category View (make it non-scrollable inside)
            SliverToBoxAdapter(child: HomeCategoryView()),
          ],
        ),
      ),
    );
  }
}
