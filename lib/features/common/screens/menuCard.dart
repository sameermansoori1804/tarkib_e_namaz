import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/screens/home_option_menu.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';

import '../../../route/routes.dart';
import '../../../utils/images.dart';

class Menucard extends StatelessWidget {
  const Menucard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeOptionMenu(
              icon: Images.tasbih,
              route: AppRoutes.getTasbihScreen(),
              title: "tasbih".tr,
            ),
            HomeOptionMenu(
              icon: Images.normal_tasbih,
              route: AppRoutes.getnormalTasbihScreen(),
              title: "normal_tasbih".tr,
            ),

            HomeOptionMenu(
              icon: Images.qibla,
              route: AppRoutes.getFindQibla(),
              title: "qibla_finder".tr,
            ),
            HomeOptionMenu(
              icon: Images.zakat,
              route: AppRoutes.getZakatScreen(),
              title: "zakat".tr,
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeOptionMenu(
              icon: Images.quraan,
              route: AppRoutes.getQuraanScreen(),
              title: "quraan".tr,
            ),
            HomeOptionMenu(
              icon: Images.qa,
              route: RouteName.sawalJawab,
              isRegistered: true,
              title: "sawal_jawab".tr,
            ),
            HomeOptionMenu(
              icon: Images.trophy,
              route:AppRoutes.getCompetitionScreen(),
              isRegistered: true,
              title: "competition".tr,
            ),
            HomeOptionMenu(
              icon: Images.prayer,
              route: AppRoutes.getQazaNamaz(),
              title: "qaza_namaz".tr,
            ),
          ],
        ),
      ],
    );
  }
}