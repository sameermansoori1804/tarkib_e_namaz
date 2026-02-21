import 'package:flutter/material.dart';
import 'package:flutter_template/route/routes_name.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AdHelper.dart';

class AdsController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  bool isLoading = false;
  // Interstitial Ad
  void loadInterstitialAd() {

    if(_interstitialAd != null){

      showInterstitialAd();
    }else{
      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId, // test interstitial
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;

            showInterstitialAd();
          },
          onAdFailedToLoad: (error) {

            print('Interstitial failed to load: $error');
          },
        ),
      );
    }

  }

  void showInterstitialAd() {

    // ❌ Do not show ad on Quran page
    if (Get.currentRoute == RouteName.quraanPageScreen) {
      return;
    }
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  // Rewarded Ad
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5354046379', // test rewarded
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print("rewarded ads load success");
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('Rewarded failed to load: $error');
        },
      ),
    );
  }

  void showRewardedAd(Function(int) onRewardEarned) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onRewardEarned(reward.amount.toInt());
      });
      _rewardedAd = null;
    }
  }

  // App Open Ad
  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-4830223047407077/1163158023', // test app open
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('App Open failed to load: $error');
        },
      ),
    );
  }

  void showAppOpenAd() {
    if (_appOpenAd != null) {
      _appOpenAd!.show();
      _appOpenAd = null;
    }
  }


}
