import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../domain/models/ParaItem.dart';
import '../widgets/para_screen.dart';
import '../widgets/surah_screen.dart';

class QuranParaSurahView extends StatefulWidget {
  const QuranParaSurahView({super.key});

  @override
  State<QuranParaSurahView> createState() => _QuranParaSurahViewState();
}

class _QuranParaSurahViewState extends State<QuranParaSurahView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Tab Bar with proper equal width division
            Container(
              height: 40, // Reduced from typical 48-56px
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 2,
                  color: AppColor.primaryColor,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                // Key properties for equal width and proper centering
                isScrollable: false, // This ensures equal width division
                indicatorSize: TabBarIndicatorSize.tab, // Full tab width indicator
                indicatorWeight: 0, // Remove default underline indicator
                dividerColor: Colors.transparent, // Remove divider line
                labelPadding: EdgeInsets.zero, // Remove default padding
                indicator: BoxDecoration(
                  color:  AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs:  [
                  Tab(
                    child: Center(
                      child: Text("para".tr),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text("surah".tr),
                    ),
                  ),

                ],
              ),
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ParaScreen(),
                  SurahScreen(),
                  _buildLastReadingView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildLastReadingView() {
    return  Center(
      child: Text(
        "last_reading_view".tr,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

}

