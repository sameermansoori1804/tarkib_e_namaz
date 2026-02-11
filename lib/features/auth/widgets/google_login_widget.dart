import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/styles.dart';
import '../controller/auth_controller.dart';


class GoogleLoginWidget extends StatelessWidget {
  const GoogleLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return SizedBox(
          width: double.infinity,
          height: 45,
          child: OutlinedButton.icon(
            onPressed: () {
              authController.googleLogin();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xFFE0E0E0),
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Image.network(
              'https://www.google.com/favicon.ico',
              width: 24,
              height: 24,
            ),
            label: Text(
              'continue_with_google'.tr,
                style: robotoBold.copyWith(color: AppColor.text_black,fontSize: 16)
            ),
          ),
        );
      }
    );
  }
}
