import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/AppConstants.dart';
import '../../../utils/app_color.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';
import '../widgets/google_login_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  final bool backFromThis;
  final bool fromNotification;
  final bool fromResetPassword;
  const SignInScreen({super.key, required this.exitFromApp, required this.backFromThis, this.fromNotification = false, this.fromResetPassword = false});

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // IMPORTANT
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.top_color,
              AppColor.bottom_color,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Section with Quote Preview
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          children: [
                            TextSpan(
                              text: 'Get ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'Daily Quotes',
                              style: TextStyle(color: Color(0xFFFFB870)),
                            ),
                            TextSpan(
                              text: ' everyday\nwith your ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'Photo',
                              style: TextStyle(color: Color(0xFFFFB870)),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'Name',
                              style: TextStyle(color: Color(0xFFFFB870)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Preview Card
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 240,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: -25,
                            right: 10,
                            left: 50,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                border: Border.all(
                                  color: const Color(0xFFB8E986),
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'your_name'.tr,
                                  style: TextStyle(
                                    color: AppColor.second_color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -25,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFB8E986),
                                  width: 3,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColor.second_color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Login Section

              SingleChildScrollView(
                child: Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          // Logo
                          Container(
                            width: 80,
                            height: 80,
                            // decoration: BoxDecoration(
                            //   gradient: const LinearGradient(
                            //     colors: [
                            //       Color(0xFF6B9EFA),
                            //       Color(0xFF8B7FE8),
                            //     ],
                            //   ),
                            //   borderRadius: BorderRadius.circular(5),
                            // ),
                            child: Image.asset(Images.logo),
                          ),
                          Text(
                            '${'welcome_to'.tr} ${AppConstants.appName}',
                              style: robotoBold.copyWith(color: AppColor.text_black,fontSize: 20)
                            // style: TextStyle(
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.bold,
                            //   fontFamily: robotoRegular,
                            //     style: robotoRegular.copyWith(color: textColor)
                            //   color: Color(0xFF2D2D2D),
                            // ),
                          ),

                          // Next Button
                          // SignInWidget(),
                          // const SizedBox(height: 10),
                          // Divider
                          // Row(
                          //   children: const [
                          //     Expanded(child: Divider()),
                          //     Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 16),
                          //       child: Text(
                          //         'OR',
                          //         style: TextStyle(
                          //           color: Colors.grey,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(child: Divider()),
                          //   ],
                          // ),
                          const SizedBox(height: 10),
                          // Google Sign In Button
                          GoogleLoginWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
