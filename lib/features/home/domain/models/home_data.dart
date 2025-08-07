import 'package:flutter_template/features/home/domain/models/prayer_data.dart';
import 'package:flutter_template/features/home/domain/models/setting_model.dart';
import 'package:flutter_template/features/home/domain/models/tasbih_model.dart';
import 'categories_model.dart';
import 'home_slider.dart';

class HomeData {
  String? status;
  String? message;
  List<Setting>? settings;
  List<Tasbih>? tasbihs;
  List<Categories>? categories;
  PrayerData? prayerTime;
  List<Slider>? sliders;

  HomeData(
      {this.status,
        this.message,
        this.settings,
        this.tasbihs,
        this.categories,
        this.prayerTime,
        this.sliders});

  HomeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['settings'] != null) {
      settings = <Setting>[];
      json['settings'].forEach((v) {
        settings!.add(new Setting.fromJson(v));
      });
    }
    if (json['tasbihs'] != null) {
      tasbihs = <Tasbih>[];
      json['tasbihs'].forEach((v) {
        tasbihs!.add(new Tasbih.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    prayerTime = json['prayer_time'] != null
        ? new PrayerData.fromJson(json['prayer_time'])
        : null;
    if (json['sliders'] != null) {
      sliders = <Slider>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Slider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.settings != null) {
      data['settings'] = this.settings!.map((v) => v.toJson()).toList();
    }
    if (this.tasbihs != null) {
      data['tasbihs'] = this.tasbihs!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.prayerTime != null) {
      data['prayer_time'] = this.prayerTime!.toJson();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}