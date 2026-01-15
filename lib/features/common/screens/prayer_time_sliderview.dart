import 'package:flutter/material.dart';
import 'package:flutter_template/features/prayer_time/controller/prayer_time_controller.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:flutter_template/features/tasbih/controller/tasbih_controller.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:get/get.dart';

import '../../home/domain/models/prayer_data.dart';
import 'package:intl/intl.dart';

import '../controller/location_controller.dart';

class PrayerTimesSlider extends StatelessWidget {
  // Sample data for multiple cards

  int page = 0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveHeight = screenHeight * 0.6; // 60% of screen height
    return Container(
      height: responsiveHeight.clamp(300.0, 450.0), // Min 300, Max 500
      child: GetBuilder<PrayerTimeController>(
        builder: (prayerTimeController) {
          return GetBuilder<SplashController>(
            builder: (splashController) {
              return PageView.builder(
                itemCount: splashController.prayerTime!.data!.length ?? 0,
                onPageChanged: (index) {
                  if (index == splashController.prayerTime!.data!.length - 1) {
                    page++;
                    splashController.loadMorePrayerTimes(page);
                  }
                },
                controller: PageController(
                  viewportFraction: 0.9,
                  initialPage: prayerTimeController.currentIndex,
                ),
                itemBuilder: (context, index) {
                  String dateString =
                      splashController
                          .prayerTime!
                          .data![index]
                          .date!
                          .gregorian!
                          .date ??
                      "";

                  DateTime parsedDate = DateFormat(
                    "dd-MM-yyyy",
                  ).parse(dateString);

                  // Get today's date without time
                  DateTime today = DateTime.now();
                  bool isToday =
                      parsedDate.year == today.year &&
                      parsedDate.month == today.month &&
                      parsedDate.day == today.day;
                  if (isToday) {
                    Get.find<PrayerTimeController>().setCurrentData(
                      splashController.prayerTime!.data![index],
                    );
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: PrayerTimesWidget(
                      date:
                          splashController
                              .prayerTime!
                              .data![index]
                              .date!
                              .gregorian!
                              .date ??
                          "",
                      hijriDate:
                          splashController
                              .prayerTime!
                              .data![index]
                              .date!
                              .hijri!
                              .date ??
                          "",
                      address: Get.find<LocationController>().address ?? "",
                      festival:
                          splashController
                              .prayerTime!
                              .data![index]
                              .date!
                              .gregorian!
                              .date ??
                          "",
                      prayerTimes:
                          splashController.prayerTime!.data![index].timings ??
                          Timings(),
                      isToday: isToday,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class PrayerTimesWidget extends StatelessWidget {
  final String date;
  final String hijriDate;
  final String address;
  final String festival;
  final Timings prayerTimes;
  final bool isToday;

  const PrayerTimesWidget({
    Key? key,
    required this.date,
    required this.hijriDate,
    required this.address,
    required this.festival,
    required this.prayerTimes,
    required this.isToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.primaryColor.withOpacity(0.6),
            AppColor.primaryColor.withOpacity(0.7),
            AppColor.primaryColor.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hijari Date',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      hijriDate,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12),

            // Address and Festival section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Festival',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        festival,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Prayer times list
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    bool isActive = false;
                    String title = "";
                    String time = "";
                    switch (index) {
                      case 0: // Fajr → Sunrise
                        title = "Fazr";
                        time = formatPrayerTime(prayerTimes!.fajr ?? "00:00");
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.fajr ?? "00:00"),
                            formatPrayerTime(prayerTimes!.sunrise ?? "00:00"),
                          );
                        }

                        break;

                      case 1: // Sunrise → Dhuhr
                        title = "Sunrise";
                        time = formatPrayerTime(
                          prayerTimes!.sunrise ?? "00:00",
                        );
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.sunrise ?? "00:00"),
                            formatPrayerTime(prayerTimes!.dhuhr ?? "00:00"),
                          );
                        }
                        break;

                      case 2: // Dhuhr → Asr
                        title = "Dhuhr";
                        time = formatPrayerTime(prayerTimes!.dhuhr ?? "00:00");
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.dhuhr ?? "00:00"),
                            formatPrayerTime(prayerTimes!.asr ?? "00:00"),
                          );
                        }
                        break;

                      case 3: // Asr → Maghrib
                        title = "Asr";
                        time = formatPrayerTime(prayerTimes!.asr ?? "00:00");
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.asr ?? "00:00"),
                            formatPrayerTime(prayerTimes!.maghrib ?? "00:00"),
                          );
                        }
                        break;

                      case 4: // Maghrib → Isha
                        title = "Maghrib";
                        time = formatPrayerTime(
                          prayerTimes!.maghrib ?? "00:00",
                        );
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.maghrib ?? "00:00"),
                            formatPrayerTime(prayerTimes!.isha ?? "00:00"),
                          );
                        }
                        break;
                      case 5: // Maghrib → Isha
                        title = "Isha";
                        time = formatPrayerTime(prayerTimes!.isha ?? "00:00");
                        if (isToday) {
                          isActive = checkCurrentTime(
                            formatPrayerTime(prayerTimes!.isha ?? "00:00"),
                            formatPrayerTime(prayerTimes!.fajr ?? "00:00"),
                          );
                        }
                        break;
                    }

                    if (isActive) {
                      Get.find<PrayerTimeController>().setCurrentTime(
                        time,
                        title,
                      );
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: _buildPrayerTimeRow(title, time, isActive),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatPrayerTime(String timeString) {
    // Remove the " (IST)" part
    String cleanTime = timeString.split(" ").first;
    DateTime parsedTime = DateFormat("HH:mm").parse(cleanTime);
    return DateFormat("h:mm a").format(parsedTime);
  }

  bool checkCurrentTime(String startTime, String endTime) {
    DateTime now = DateTime.now();

    // Parse input times
    DateTime startParsed = DateFormat("h:mm a").parse(startTime);
    DateTime endParsed = DateFormat("h:mm a").parse(endTime);

    // Attach today's date
    DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      startParsed.hour,
      startParsed.minute,
    );
    DateTime end = DateTime(
      now.year,
      now.month,
      now.day,
      endParsed.hour,
      endParsed.minute,
    );

    // If range crosses midnight (end before start)
    if (end.isBefore(start)) {
      // End time is on the next day
      end = end.add(Duration(days: 1));
    }

    return now.isAfter(start) && now.isBefore(end);
  }

  Widget _buildPrayerTimeRow(String prayerName, String time, bool isActive) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color:
            isActive
                ? Color(0xFF4A90E2).withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Color(0xFF4A90E2) : Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
