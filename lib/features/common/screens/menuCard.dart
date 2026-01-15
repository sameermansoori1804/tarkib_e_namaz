import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/screens/home_option_menu.dart';

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
              title: "Tasbih",
            ),

            HomeOptionMenu(
              icon: Images.prayer,
              route: AppRoutes.getQazaNamaz(),
              title: "Qaza Namaz",
            ),
            HomeOptionMenu(
              icon: Images.qibla,
              route: AppRoutes.getFindQibla(),
              title: "Qibla Finder",
            ),
            HomeOptionMenu(
              icon: Images.zakat,
              route: AppRoutes.getZakatScreen(),
              title: "Zakat",
            ),
          ],
        ),
        SizedBox(height: 5,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeOptionMenu(
              icon: Images.quraan,
              route: AppRoutes.getQuraanScreen(),
              title: "Quraan",
            ),
            HomeOptionMenu(
              icon: Images.qa,
              route: AppRoutes.getComingSoonScreen(),
              title: "Sawal-Jawab",
            ),
            HomeOptionMenu(
              icon: Images.trophy,
              route: AppRoutes.getComingSoonScreen(),
              title: "Compitition",
            ),
            HomeOptionMenu(
              icon: Images.sajdah,
              route: AppRoutes.getComingSoonScreen(),
              title: "Namaz",
            ),
          ],
        ),
      ],
    );
  }
}
