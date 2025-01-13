import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home_ui/resources/appConfig/app_config.dart';
import 'package:smart_home_ui/ui/screens/ads_show_screen.dart';
import 'package:smart_home_ui/ui/widgets/smart_devices_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // create Banner Ads Instance..
  late BannerAd bannerAd;
  bool isLoaded = false;

  List mySmartDevices = [
    //[DeviceName,iconPath,powerStatus]
    ["Smart Light", "assets/images/light_bulb.png", false],
    ["Smart AC", "assets/images/air_conditioner.png", true],
    ["Smart TV", "assets/images/smart_tv.png", false],
    ["Smart Fan", "assets/images/fan.png", false],
  ];

  // power button switch
  void powerToggleChanged(bool value, int index){
    mySmartDevices[index][2] = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _bannerAdsSection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1st:- custom app bar.....
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/menu.png",
                    height: 30,
                    color: Colors.grey[800],
                  ),
                  ClipOval(
                    child: Image.asset(
                      "assets/images/jahid.jpg",
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //2nd:- welcome with Jahid Hasan text....
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Home',
                        style: GoogleFonts.aboreto(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'JAHID HASAN',
                        style: GoogleFonts.bebasNeue(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Lottie.asset(
                      'assets/animations/home_animation.json',
                      height: 100,
                      width: 180,
                  ),
                ],
              ),
              const SizedBox(height: 80),

              //3rd:- Smart device text....
              const Text(
                'Smart Devices',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              //4th:- smart home card, grid view....
              Expanded(
                child: GridView.builder(
                    itemCount: mySmartDevices.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1/1.3,
                    ),
                   itemBuilder: (context, index) {
                      return SmartDevicesCard(
                        smartDeviceName: mySmartDevices[index][0],
                        iconPath: mySmartDevices[index][1],
                        powerOn: mySmartDevices[index][2],
                        onChanged:(value)=> powerToggleChanged(value,index),
                      );
                   },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLoaded
          ? SizedBox(
             height: bannerAd.size.height.toDouble(),
             width:  bannerAd.size.width.toDouble(),
             child: AdWidget(ad:bannerAd),
          )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> const AdsShowScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // show banner ads implements......
  void _bannerAdsSection(){
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AppConfig.bannerAdsID,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad){
            isLoaded = true;
            setState(() {});
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error){
            ad.dispose();
            if (kDebugMode) {
              print(error);
            }
          },
        ),
        request: const AdRequest(),
    );
    bannerAd.load();
  }

}
