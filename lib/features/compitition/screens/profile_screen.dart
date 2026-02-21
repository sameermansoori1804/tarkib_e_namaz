import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/controller/auth_controller.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/adhan_notification_service_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // late final AdhanNotificationService _adhanNotificationService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _adhanNotificationService = AdhanNotificationServiceImpl();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<SplashController>(
            builder: (splashController) {
              return Column(
                children: [
                  /// 👤 Profile Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B5E20), Color(0xFF43A047)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        /// Profile Picture
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            splashController.user?.profilePic ?? "",
                          ),
                        ),
                        const SizedBox(width: 15),
                        /// Name & Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${splashController.user?.name ?? ""}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${splashController.user?.email ?? ""}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 📋 Menu Items
                  _menuItem(
                    icon: Icons.emoji_events,
                    title: "leaderboard".tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getLeaderboardScreen());
                    },
                  ),
                  _menuItem(
                    icon: Icons.account_balance_wallet,
                    title: "my_wallet".tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getWalletScreen());
                    },
                  ),
                  _menuItem(
                    icon: Icons.language,
                    title: "language".tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getLanguageScreen("yes"));
                    },
                  ),
                  _menuItem(
                    icon: Icons.notifications,
                    title: "notification_settings".tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getNotificationSettings());
                    },
                  ),
                  _menuItem(
                    icon: Icons.flag,
                    title: "competition".tr,
                    onTap: () async {

                      Get.toNamed(AppRoutes.getCompetitionScreen());
                    },
                  ),
                  _menuItem(
                    icon: Icons.lock,
                    title: "privacy_policy".tr,
                    onTap: () {
                      Get.toNamed(AppRoutes.getWebView(
                          "https://tarkibenamaz.visticsolutions.in/privacy-policy",
                          "cancellation_policy".tr));
                    },
                  ),
                  _menuItem(
                    icon: Icons.share,
                    title: "share_app".tr,
                    onTap: () {
                      Share.share(
                        "${"share_text".tr}\nhttps://play.google.com/store/apps/details?id=com.yourapp.package",
                      );
                    },
                  ),
                  _menuItem(
                    icon: Icons.logout,
                    title: "logout".tr,
                    isLogout: true,
                    onTap: () {
                      _showLogoutDialog();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF43A047)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mosque, color: Colors.white, size: 40),
              const SizedBox(height: 15),
              Text(
                "logout".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "logout_message".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  /// Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "cancel".tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  /// Logout Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        Get.find<AuthController>().logout();
                      },
                      child: Text(
                        "logout".tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable Menu Tile
  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : AppColor.primaryGreen,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}