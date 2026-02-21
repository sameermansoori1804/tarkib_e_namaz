import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../route/routes_name.dart';

class AppUpdateScreen extends StatelessWidget {
  const AppUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// ✅ Feature List

    return Scaffold(
      backgroundColor: const Color(0xFF0C7C46),
      body: GetBuilder<SplashController>(
        builder: (splashController) {

          final data = splashController.data;
          List<dynamic> features = jsonDecode(data?['update_information']);
          return Stack(
            children: [

              /// Skip Button
              data?['force_update'] == 1 ? Positioned(
                top: 50,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed(RouteName.homeView);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ) : SizedBox(),

              /// Main Card
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Center(
                          child: Icon(
                            Icons.system_update,
                            size: 70,
                            color: Color(0xFF0F9D58),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Center(
                          child: Text(
                            "New Update Available",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F9D58),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "What's New:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// ✅ Generate List Dynamically
                        ...features.map(
                              (feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "• ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async{
                              final Uri url = Uri.parse(data?['app_link'] ?? "https://play.google.com/store/apps/details?id=com.yourpackage.name");
                              if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                              )) {
                              throw Exception('Could not launch $url');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F9D58),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon: const Icon(Icons.download,
                                color: Colors.white),
                            label: const Text(
                              "Update Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}