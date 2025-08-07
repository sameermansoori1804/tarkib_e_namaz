import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/screens/home_option_menu.dart';

class Menucard extends StatelessWidget {
  const Menucard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeOptionMenu(),
            HomeOptionMenu(),
            HomeOptionMenu(),
            HomeOptionMenu(),
          ],
        ),
        SizedBox(height: 5,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomeOptionMenu(),
            HomeOptionMenu(),
            HomeOptionMenu(),
            HomeOptionMenu(),
          ],
        ),
      ],
    );
  }
}
