import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../../utils/app_color.dart';
import '../../compitition/domain/models/competition_task.dart';

Future<void> showIslamicConfirmationDialog({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onYes,
  VoidCallback? onNo,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Dialog container
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge,
                  vertical: Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Color(0xFF0B3D2E)), // deep green
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  // Description
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            if (onNo != null) onNo();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0B3D2E),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(vertical: 14)),
                          child: Text(
                            "No".tr,
                            style: robotoBold.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeLarge),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onYes,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.gold,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(vertical: 14)),
                          child: Text(
                            "Yes".tr,
                            style: robotoBold.copyWith(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Top circular pattern (Islamic geometric style)
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF0B3D2E),
              child: Icon(
                Icons.check,
                size: 50,
                color: AppColor.gold,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void openInputDialog(CompetitionTask task, {required BuildContext context,  required Function(int value) onYes,
  VoidCallback? onNo,}) {
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Dialog container
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraLarge,
                vertical: Dimensions.paddingSizeLarge),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),

                // Task title
                Text(
                  task.name,
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Color(0xFF0B3D2E)), // deep green
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                // Description / hint
                Text(
                  "enter_your_value".tr,
                  textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Colors.black87),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                // TextField for input
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF0F5F5), // soft background
                    hintText: "enter_number".tr,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Color(0xFF0B3D2E), width: 2)),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Get.back();
                          if (onNo != null) onNo();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0B3D2E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("cancel".tr,
                            style: robotoBold.copyWith(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          int val =
                              int.tryParse(controller.text.trim()) ?? 0;

                          if (val <= 0) {
                            Get.snackbar(
                              "Error",
                              "Please enter valid number",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          onYes(val);   // ✅ Send value
                          Get.back();   // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.gold,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("submit".tr,
                            style: robotoBold.copyWith(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top circular ornament
          CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF0B3D2E),
            child: Icon(Icons.edit, size: 50, color: AppColor.gold),
          ),
        ],
      ),
    ),
  );
}