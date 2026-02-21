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

  const SignInScreen({
    super.key,
    required this.exitFromApp,
    required this.backFromThis,
    this.fromNotification = false,
    this.fromResetPassword = false,
  });

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F3D2E),
              Color(0xFF14532D),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// TOP ISLAMIC SECTION
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// App Name
                      Text(
                        "app_name".tr,
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Islamic Tagline
                      Text(
                        "tagline".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 25),

                      /// Islamic Icon (Mosque)
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.mosque,
                          size: 80,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Quran Ayah Quote
                      Text(
                        "quran_ayah".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// BOTTOM LOGIN SECTION
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F6F1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Welcome Text
                        Text(
                          "welcome_text".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F3D2E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "signin_instruction".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 30),

                        /// Google Login Button
                        GoogleLoginWidget(),
                        const SizedBox(height: 20),

                        /// Footer Islamic Line
                        Text(
                          "footer_text".tr,
                          style: TextStyle(
                            color: Color(0xFF14532D),
                            fontSize: 13,
                          ),
                        ),
                      ],
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