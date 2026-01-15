import 'package:flutter/material.dart';
import 'package:flutter_template/features/home/screens/home_screens.dart';
import 'package:flutter_template/features/prayer_time/screens/prayer_time.dart';

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
      ComingSoonScreen(),
      ComingSoonScreen()
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

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _setPage,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed, // for more than 3 items

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: 'Prayer time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }


  void _setPage(int pageIndex) {
    print(pageIndex);
    print("farukh------");
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
