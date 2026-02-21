import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/controller/location_controller.dart';
import 'package:flutter_template/features/common/screens/no_internet_screen.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../route/routes.dart';
import '../../../utils/AppConstants.dart';
import '../../../utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _fadeController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _fadeController.forward();
    _scaleController.forward();

    _loadHomeData();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _loadHomeData() async {
    final locationController = Get.find<LocationController>();
    await locationController.getInitData();

    DateTime now = DateTime.now();

    final splashController = Get.find<SplashController>();
    await splashController.getUserData();
    await splashController.getConfigData();

    Map<String, dynamic> body = {
      "latitude": locationController.latitude,
      "longitude": locationController.longitude,
      "tune": locationController.tune,
      "year": now.year.toString(),
      "month": now.month.toString().padLeft(2, '0'),
      "days": locationController.daySetting
    };
    bool success = await splashController.getHomeData(body);

    if (success && splashController.firstTimeConnectionCheck) {

      SharedPreferences pref =await SharedPreferences.getInstance();
      final langCod = pref.getString(AppConstants.languageCode);
       print("lang-code------->");
       print(langCod);
       if(langCod == null){
         Get.offAllNamed(AppRoutes.getLanguageScreen("no"));
       }else{
         if(double.parse(splashController.data?['app_version_code'] ?? "0") > AppConstants.appVersion){
           Get.toNamed(AppRoutes.getAppUpdateScreen());
         }else{
           Get.offAllNamed(RouteName.homeView);
         }
       }
    } else {

      // Optionally show NoInternetScreen or retry
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor, // Dark green
              AppColor.secondaryColor, // Forest green
              AppColor.lastColor, // Deep green
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Islamic Pattern

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Logo/Icon Container
                      AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(Images.app_logo,width: 60,height: 60,),
                              // child: Icon(
                              //   Icons.mosque,
                              //   size: 60,
                              //   color: Color(0xFF1B4D3E),
                              // ),

                            ),
                          );
                        },
                      ),

                      SizedBox(height: 0),

                      // App Name with Fade Animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'app_name'.tr,

                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Subtitle with Fade Animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'بِسْمِ اللَّهِ الرَّحْمَـنِ الرَّحِيمِ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 60),

                      // Loading Section
                      GetBuilder<SplashController>(
                        builder: (splashController) {
                          if (!splashController.firstTimeConnectionCheck && !splashController.isLoading) {
                            return NoInternetScreen();
                          }

                          return Column(
                            children: [
                              // Custom Loading Indicator
                              Container(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFFD700),
                                  ),
                                  backgroundColor: Colors.white30,
                                ),
                              ),

                              SizedBox(height: 20),

                              // Loading Text
                              Text(
                                splashController.isLoading
                                    ? 'loading'.tr
                                    : 'welcome'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              SizedBox(height: 10),

                              // Progress Dots Animation
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (index) {
                                  return AnimatedBuilder(
                                    animation: _fadeController,
                                    builder: (context, child) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 4),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.primaryColor.withOpacity(
                                            ((_fadeController.value + index * 0.3) % 1.0),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Islamic Pattern
            ],
          ),
        ),
      ),
    );
  }
}
