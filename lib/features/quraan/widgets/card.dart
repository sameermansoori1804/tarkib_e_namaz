import 'package:flutter/material.dart';
import 'package:flutter_template/features/quraan/domain/models/Quraan.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../../../utils/images.dart';
import '../domain/models/ParaItem.dart';


class IslamicCard extends StatelessWidget {
  final Quraan itemData;
  final VoidCallback onTap;



  const IslamicCard({
    Key? key,
    required this.itemData,
    required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Top left circle with number
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${itemData.id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Top right decorative corner image
            Positioned(
              top: 2,
              right: 2,
              child: Image.asset(
                Images.top_right, // Your decorative corner image
                width: 60,
                height: 60,
                color: AppColor.primaryColor, // Tint the image to match your color scheme
              ),
            ),

            // Bottom left decorative corner image
            Positioned(
              bottom: 2,
              left: 2,
              child: Image.asset(
                Images.bottom_left,
                width: 60,
                height: 60,
                color: AppColor.primaryColor,

              ),
            ),

            // Center Arabic text
            Center(
              child: Text(
                '${itemData.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Amiri', // Use an Arabic font if available
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Bottom right info with book icon
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${itemData.ruku}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                      ),
                      child: Text(
                        'total_ruku'.tr,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      Images.quraan_logo, // Your book icon image
                      width: 20,
                      height: 20,
                      color:AppColor.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}