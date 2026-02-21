import 'package:flutter/material.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../controller/CopetitionController.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<CopetitionController>();
    controller.getWalletHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBg,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primaryGreen,
        title: Text(
          "my_wallet".tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: GetBuilder<CopetitionController>(
          id: "wallet-history",
          builder: (copetitionController) {
            return copetitionController.isWalletLoading
                ? const SizedBox()
                : Column(
              children: [
                /// 💰 Balance Card
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFD4AF37),
                        Color(0xFFFFE082),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "available_balance".tr,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹ ${copetitionController.user?.balance ?? "0"}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      /// Withdraw Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryGreen,
                        ),
                        onPressed: () {
                          double balance = double.parse(
                              copetitionController.user?.balance ?? "0");
                          if (balance >= 10) {
                            Get.toNamed(AppRoutes.getWithdrawScreen());
                          }
                        },
                        child: Text(
                          "withdraw".tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),

                /// 📜 Transaction History Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "transaction_history".tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// 📋 Transactions List
                Expanded(
                  child: ListView.builder(
                    itemCount: copetitionController.walletHistories.length,
                    itemBuilder: (_, index) {
                      final tx =
                      copetitionController.walletHistories[index];

                      final type = tx.type?.toLowerCase();

                      final isCredit = type == "credit";
                      final isDebit = type == "debit";
                      final isPending = type == "pending";

                      Color bgColor;
                      Color iconColor;
                      IconData icon;

                      if (isCredit) {
                        bgColor = Colors.green.withOpacity(0.2);
                        iconColor = Colors.green;
                        icon = Icons.arrow_downward;
                      } else if (isDebit) {
                        bgColor = Colors.red.withOpacity(0.2);
                        iconColor = Colors.red;
                        icon = Icons.arrow_upward;
                      } else {
                        // Pending
                        bgColor = Colors.orange.withOpacity(0.2);
                        iconColor = Colors.orange;
                        icon = Icons.access_time;
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            /// Icon
                            CircleAvatar(
                              backgroundColor: bgColor,
                              child: Icon(icon, color: iconColor),
                            ),

                            const SizedBox(width: 12),

                            /// Title & Date
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${tx.title}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${tx.createdAt}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),

                            /// Amount
                            Text(
                              "${isCredit ? "+" : isDebit ? "-" : ""} ₹${tx.amount}",
                              style: TextStyle(
                                color: iconColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}