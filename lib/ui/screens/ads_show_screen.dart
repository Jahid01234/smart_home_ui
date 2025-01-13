import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_home_ui/resources/appConfig/app_config.dart';

class AdsShowScreen extends StatefulWidget {
  const AdsShowScreen({super.key});

  @override
  State<AdsShowScreen> createState() => _AdsShowScreenState();
}

class _AdsShowScreenState extends State<AdsShowScreen> {
  // create Interstitial Ads Instance..
  late InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    _interstitialAdsSection();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              interstitialAd.show();
            },
            child: const Text("Click for Interstitial Ads"),
        ),
      ) ,
    );
  }

  // show interstitial ads implements......
  void _interstitialAdsSection(){
   InterstitialAd.load(
       adUnitId: AppConfig.interstitialAdsID,
       request: const AdRequest(),
       adLoadCallback: InterstitialAdLoadCallback(
           onAdLoaded: (InterstitialAd ad){
             interstitialAd = ad;
             setState(() {});
           },
           onAdFailedToLoad: (LoadAdError error){
             debugPrint('InterstitialAd failed to load: $error');
           },
       ),
    );
  }
}
