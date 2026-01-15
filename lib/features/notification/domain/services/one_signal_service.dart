import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static const String oneSignalAppId =
      "54877126-383f-4b3f-b475-fb91d6c4556a"; // 🔹 Replace with your app id

  static Future<void> initOneSignal(BuildContext context) async {
    // Initialize OneSignal
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(oneSignalAppId);

    // Ask user for notification permission (iOS + Android 13+)
    OneSignal.Notifications.requestPermission(true);

    // Get player id (device id)
    final deviceState = await OneSignal.User.pushSubscription;
    if (deviceState != null) {
      log("Player ID: ${deviceState.id}");
    }

    // Handle notification received (foreground)
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      log("Notification Received: ${event.notification.jsonRepresentation()}");
      event.preventDefault();

    });

    // Handle notification opened (click handler from system tray)
    OneSignal.Notifications.addClickListener((event) {
      log("Notification Clicked: ${event.notification.jsonRepresentation()}");

      final data = event.notification.additionalData;
      if (data != null && data.containsKey("screen")) {
        String screen = data["screen"];
        if (screen == "details") {
          Navigator.pushNamed(context, "/details", arguments: data);
        }
      }
    });
  }
}
