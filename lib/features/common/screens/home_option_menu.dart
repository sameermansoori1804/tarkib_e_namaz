import 'package:flutter/material.dart';
import 'package:flutter_template/features/ads/controller/ads_controller.dart';
import 'package:flutter_template/route/routes.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../../../utils/images.dart';

class HomeOptionMenu extends StatelessWidget {
  const HomeOptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdsController>(builder: (adsController){


      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap:()=>Get.toNamed(AppRoutes.getTasbihScreen()),
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // shadow color
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2), // shadow position
                    ),
                  ],
                ),

                child: Image.asset(Images.tasbih),
              ),
            ),
            SizedBox(height: 3,),
            Text("Menu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0),)
          ],
        ),
      );
    });
  }
}
