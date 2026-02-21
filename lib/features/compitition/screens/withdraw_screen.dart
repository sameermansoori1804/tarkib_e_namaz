import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/compitition/controller/CopetitionController.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBg,
      appBar: AppBar(
        backgroundColor: AppColor.primaryGreen,
        iconTheme: const IconThemeData(
          color: Colors.white, // 👈 Back icon color
        ),
        title: Text(
          "withdraw".tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CopetitionController>(
          builder: (copetitionController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 💰 Available Balance
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "${'available_balance'.tr}: ₹${copetitionController.user?.balance ?? "0"}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// 💵 Amount Field
                Text(
                  "enter_amount".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: copetitionController.amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "enter_amount_hint".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// 🏦 UPI ID Field
                Text(
                  "enter_upi".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: copetitionController.upiController,
                  decoration: InputDecoration(
                    hintText: "example_upi".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                /// OR Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// 📷 Upload QR
                Text(
                  "upload_qr".tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: copetitionController.pickQRImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: copetitionController.qrImage == null
                        ? Center(
                      child: Text("tap_to_upload_qr".tr),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        copetitionController.qrImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// 🚀 Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: copetitionController.submitWithdraw,
                    child: Text(
                      "submit_withdraw".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}