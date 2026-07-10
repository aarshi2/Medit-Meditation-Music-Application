import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static final AdsManager instance = AdsManager.internal();

  factory AdsManager() => instance;

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  AdsManager.internal();

  // Initialize the ad manager
  void initialize() {
    MobileAds.instance.initialize();
  }

  // Load a Banner Ad
  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Banner Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner Ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  // Get the banner ad widget
  Widget? getBannerAdWidget() {
    if (bannerAd == null) return null;
    return Container(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }

  // Load an Interstitial Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          print('Interstitial Ad loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial Ad failed to load: $error');
        },
      ),
    );
  }

  // Show the Interstitial Ad
  Future<void> showInterstitialAd() async {
    if (interstitialAd != null) {
     await interstitialAd!.show();
      interstitialAd = null;
    }
  }

  // Load a Rewarded Ad
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ID
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          print('Rewarded Ad loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Rewarded Ad failed to load: $error');
        },
      ),
    );
  }

  // Show the Rewarded Ad
  Future<void> showRewardedAd() async {
    if (rewardedAd != null) {
     await rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount}');
        },
      );
      rewardedAd = null;
    }
  }

  // Dispose all ads
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    rewardedAd?.dispose();
  }
}
