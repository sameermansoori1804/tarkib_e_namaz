import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/controller/location_controller.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class CustomeAppBar extends StatelessWidget {
  final String title;

  const CustomeAppBar({this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(10),
      color: AppColor.primaryColor,
      child: Row(
        children: [
          Text(
            "$title",
            style: robotoMedium.copyWith(
              color: Theme.of(context).cardColor,
              fontSize: Dimensions.fontSizeExtraLarge,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Get.find<LocationController>().getCurrentLocation();
            },
            child: Icon(Icons.location_on_sharp, color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
