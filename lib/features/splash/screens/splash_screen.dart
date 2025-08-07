import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/screens/no_internet_screen.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../../../route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    final splashController = Get.find<SplashController>();

    bool success = await splashController.getHomeData();

    if (success && splashController.firstTimeConnectionCheck) {
      Get.offAllNamed(RouteName.homeView);
    } else {
      // Optionally show NoInternetScreen or retry
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: GetBuilder<SplashController>(
            builder: (splashController) {
              if (splashController.isLoading) {
                return CircularProgressIndicator();
              }
              return splashController.firstTimeConnectionCheck
                  ? Text("Welcome")
                  : NoInternetScreen();
            },
          ),
        ),
      ),
    );
  }
}
