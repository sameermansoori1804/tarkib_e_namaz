import 'package:flutter/material.dart';
import 'package:flutter_template/features/ads/controller/ads_controller.dart';
import 'package:flutter_template/features/auth/controller/auth_controller.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

class HomeOptionMenu extends StatelessWidget {
  final String icon;
  final String route;
  final String title;
  final bool isRegistered;

  const HomeOptionMenu({
    required this.icon,
    required this.route,
    required this.title,
    this.isRegistered = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug prints only in debug mode
    assert(() {
      debugPrint("HomeOptionMenu - icon: $icon");
      debugPrint("HomeOptionMenu - route: $route");
      debugPrint("HomeOptionMenu - title: $title");
      return true;
    }());

    return Center(
      child: GetBuilder<AuthController>(
          builder: (authController) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    if (route.isNotEmpty) {
                      if(isRegistered){
                        if(authController.isLoggedIn()){
                          Get.toNamed(route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('login_required'.tr)),
                          );
                        }
                      }else{
                        Get.toNamed(route);
                      }

                    } else {
                      debugPrint("Route is empty for $title");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('feature_not_available'.trParams({'feature': title}))),
                      );
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _buildIconWidget(),
                  ),
                ),
                const SizedBox(height: 3),
                _buildTitleWidget(),
              ],
            );
          }
      ),
    );
  }

  Widget _buildIconWidget() {
    if (icon.isEmpty) {
      return Icon(Icons.image_not_supported, color: Colors.grey);
    }

    return Image.asset(
      icon,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.error_outline,
        color: Colors.red,
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      title.isNotEmpty ? title : 'no_title'.tr,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}