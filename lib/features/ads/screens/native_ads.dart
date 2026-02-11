import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controller/AdHelper.dart';

class NativeAdWidget extends StatefulWidget {
  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  // Ad unit IDs - replace with your actual ad unit IDs
  final String adUnitId = AdHelper.nativeAdsIds; // Test native ad

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      // Styling options
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white,
        cornerRadius: 10.0,

      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Container(
      padding: EdgeInsets.all(0),
      height: 300, // Adjust height as needed
      child: AdWidget(ad: _nativeAd!),
    )
        : SizedBox();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}