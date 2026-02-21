import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/app_color.dart';
import 'package:flutter_template/utils/app_dark_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';

class Functions {

  static Color getColor(BuildContext context, String colorName) {

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    switch (colorName.toLowerCase()) {

      case "primary":
        return isDark
            ? AppDarkColor.primaryColor
            : AppColor.primaryColor;

      case "secondary":
        return isDark
            ? AppDarkColor.secondaryColor
            : AppColor.secondaryColor;

      case "background":
        return isDark
            ? AppDarkColor.black
            : AppColor.lightBg;

      case "text":
        return isDark
            ? Colors.white
            : Colors.black;

      case "card":
        return isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white;

      default:
        return isDark ? Colors.white : Colors.black;
    }
  }
}