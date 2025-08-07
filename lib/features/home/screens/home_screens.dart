import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/features/common/screens/custome_app_bar.dart';
import 'package:flutter_template/features/common/screens/home_category_view.dart';
import 'package:flutter_template/features/common/screens/home_image_slider.dart';
import 'package:flutter_template/features/common/screens/home_option_menu.dart';
import 'package:flutter_template/utils/app_color.dart';
import '../../common/screens/menuCard.dart';

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
            SliverToBoxAdapter(child: CustomeAppBar(title: "Tarkib e Namaz",)),
        
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
