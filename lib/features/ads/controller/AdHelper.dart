import 'package:flutter/foundation.dart';

class AdHelper {
  // Interstitial
  static String get interstitialAdUnitId {
    if (kReleaseMode) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return 'ca-app-pub-3940256099942544/1033173712'; // test
    }
  }

  // Rewarded
  static String get rewardedAdUnitId {
    if (kReleaseMode) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else {
      return 'ca-app-pub-3940256099942544/5224354917'; // test
    }
  }

  // App Open
  static String get appOpenAdUnitId {
    if (kReleaseMode) {
      return 'ca-app-pub-4830223047407077/1163158023';
    } else {
      return 'ca-app-pub-3940256099942544/9257395921'; // test
    }
  }
  // App Open
  static String get nativeAdsIds {
    if (kReleaseMode) {
      return 'ca-app-pub-4830223047407077/1163158023';
    } else {
      return 'ca-app-pub-3940256099942544/2247696110'; // test
    }
  }
  // App Open
  static String get bannerAdsIds {
    if (kReleaseMode) {
      return 'ca-app-pub-4830223047407077/1163158023';
    } else {
      return 'ca-app-pub-3940256099942544/2247696110'; // test
    }
  }
}