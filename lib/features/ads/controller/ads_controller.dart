import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  bool isLoading = false;
  // Interstitial Ad
  void loadInterstitialAd() {
    Get.dialog(
      Center(
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Please wait,\nloading ads…",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false
    );

    if(_interstitialAd != null){
      if (Get.isDialogOpen == true) Get.back(); // close loader
      showInterstitialAd();
    }else{
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712', // test interstitial
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            if (Get.isDialogOpen == true) Get.back(); // close loader
            showInterstitialAd();
          },
          onAdFailedToLoad: (error) {
            if (Get.isDialogOpen == true) Get.back(); // close loader
            print('Interstitial failed to load: $error');
          },
        ),
      );
    }

  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  // Rewarded Ad
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-4830223047407077/5572449975', // test rewarded
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
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

  @override
  void onClose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _appOpenAd?.dispose();
    super.onClose();
  }
}
