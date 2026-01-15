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
import '../../common/screens/prayer_time_card.dart';
import '../../common/screens/prayer_time_sliderview.dart';
import '../controller/prayer_time_controller.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();

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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar


            // Image slider
            SliverToBoxAdapter(child: PrayerTimeCard()),
            SliverToBoxAdapter(child: PrayerTimesSlider()),

          ],
        ),
      ),
    );
  }
}
