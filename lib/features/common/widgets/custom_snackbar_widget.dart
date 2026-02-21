import 'package:flutter/material.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

void showIslamicLoadingDialog() {
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Islamic Icon (replace with your asset)
              Image.asset(
               Images.qibla, // your islamic icon
                height: 60,
              ),

              const SizedBox(height: 20),

              const CircularProgressIndicator(),

              const SizedBox(height: 20),

              const Text(
                "Task uploading...\nPlease wait",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false, // User cannot close
  );
}

void hideLoadingDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}