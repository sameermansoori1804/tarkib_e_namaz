import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/controller/auth_controller.dart';
import 'package:flutter_template/features/compitition/screens/profile_screen.dart';
import 'package:flutter_template/features/home/screens/SavedPdfListScreen.dart';
import 'package:flutter_template/features/home/screens/home_screens.dart';
import 'package:flutter_template/features/prayer_time/screens/prayer_time.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_color.dart';
import '../../common/screens/commig_soon.dart';
import '../../common/screens/custome_app_bar.dart';
import '../../common/screens/home_category_view.dart';
import '../../common/screens/home_image_slider.dart';
import '../../common/screens/menuCard.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen(
      {super.key, required this.pageIndex, this.fromSplash = false});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late List<Widget> _screens;
  PageController? _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    // initialize PageController with the starting page
    _pageController = PageController(initialPage: widget.pageIndex);

    _pageIndex = widget.pageIndex;

    _screens = [
      HomeScreens(),
      PrayerTime(),
      SavedPdfListScreen(),
      SavedPdfListScreen(),
      ProfileScreen(),
    ];
  }
  @override
  Widget build(BuildContext context) {



    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.lightgray,

        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),

        // 🔥 CENTER FLOATING BUTTON
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            elevation: 6,
            shape: const CircleBorder(),
            onPressed: () {
              if (!Get.find<AuthController>().isLoggedIn()) {
                return; // stop further execution
              }
              Get.toNamed(AppRoutes.getCompetitionScreen());
            },
            child: Lottie.asset(
              Images.trophy_json,
              fit: BoxFit.cover,
              repeat: false,
            ),
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,

        // 🔥 Bottom Bar
        bottomNavigationBar: SafeArea(
          bottom: false, // 🔥 important
          child: SizedBox(
            height: 65, // final height
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              shape: const CircularNotchedRectangle(),
              notchMargin: 4,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 0),
                  _buildNavItem(Icons.access_time_filled, 1),
                  const SizedBox(width: 40),
                  _buildNavItem(Icons.favorite, 3),
                  _buildNavItem(Icons.person, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _pageIndex == index;

    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      iconSize: 25,
      icon: Icon(
        icon,
        color: isSelected
            ? AppColor.primaryColor
            : Colors.grey,
      ),
      onPressed: () => _setPage(index),
    );
  }

  void _setPage(int pageIndex) {


    // if (pageIndex == 3) {
    //   if (!Get.find<AuthController>().isLoggedIn()) {
    //     return; // stop further execution
    //   }
    // }

    if (pageIndex == 4) {
      if (!Get.find<AuthController>().isLoggedIn()) {
        return; // stop further execution
      }
    }

    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
