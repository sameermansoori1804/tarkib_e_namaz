import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_template/features/common/screens/sagment_circular_progress.dart';
import 'package:flutter_template/features/prayer_time/controller/prayer_time_controller.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:get/get.dart';

import '../controller/location_controller.dart';

class PrayerTimeCard extends StatefulWidget {
  @override
  State<PrayerTimeCard> createState() => _PrayerTimeCardState();
}

class _PrayerTimeCardState extends State<PrayerTimeCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerTimeController>(
      builder: (prayerTimeController) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(

            image: DecorationImage(
              image: AssetImage(Images.prayer_banner), // Your image path
              fit: BoxFit.cover,

            ),

            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                // Left side - Circular Progress

                SegmentedCircularProgress(
                  current: prayerTimeController.progress,
                  totalSegments: 150,
                  radius: 65,
                  strokeWidth: 1,
                  title: '${prayerTimeController.title ?? ""}',
                  reamaining: '${prayerTimeController.remainingTime ?? ""}',
                ),



                SizedBox(width: 20),

                // Right side - Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top section - Date and Time
                      Row(
                        children: [
                          Icon(
                            Icons.nights_stay,
                            color: Colors.white70,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                         Text(
                            prayerTimeController.currentTiming?.date?.hijri?.date ?? "",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white70,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                              prayerTimeController.currentTiming?.date?.gregorian?.date ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              Get.find<LocationController>().address ?? "",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB74D),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Icon(
                              Icons.mosque,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            '${prayerTimeController.title ?? "Test"} ${prayerTimeController.currentPrayerTime ?? "00:00"}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}



