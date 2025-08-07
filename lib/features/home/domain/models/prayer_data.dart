import 'package:flutter_template/features/home/domain/models/prayer_timming.dart';

class PrayerData {
  Timing? prayerTime;

  PrayerData({this.prayerTime});

  PrayerData.fromJson(Map<String, dynamic> json) {
    prayerTime = json['prayer_time'] != null
        ? new Timing.fromJson(json['prayer_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prayerTime != null) {
      data['prayer_time'] = this.prayerTime!.toJson();
    }
    return data;
  }
}

