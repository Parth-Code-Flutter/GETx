import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/local_storage_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/splash/select_role_screen.dart';
import 'package:tsofie/app/utils/local_storage.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  LocalStorage localStorage = Get.put(LocalStorage());

  bool isLoggedIn = false;
  String selectedRoleName = '';

  Future<void> checkUserRoleAndIsLoggedIn() async {
    isLoggedIn = await localStorage.getBoolFromStorage(kStorageIsLoggedIn);
    selectedRoleName =
        await localStorage.getStringFromStorage(kStorageSelectedRole);
    if (isLoggedIn && selectedRoleName == kSelectedRoleAsBuyer) {
      /// navigate to buyer screen
      Get.offAllNamed(kRouteBuyerBottomNavScreen);
    } else if (isLoggedIn && selectedRoleName == kSelectedRoleAsSeller) {
      /// navigate to seller screen
      Get.offAllNamed(kRouteSellerBottomNavScreen);
    } else {
      Get.offAllNamed(kRouteSelectRoleScreen);

      /// navigate to select user role screen
    }
  }

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        checkUserRoleAndIsLoggedIn();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      // backgroundColor: Colors.grey.shade400,
       backgroundImage: AssetImage(kImgSplashScreenBG),
      showLoader: false,
     // loadingText: Text("Loading..."),
      //navigator: SelectRoleScreen(),
      durationInSeconds: 5,
      logo: Image.asset(kImgSplashScreenBG,width: 0,height: 0,),
    );

    // return Scaffold(
    //   body:
    //   Container(
    //     height: Get.height,
    //     color: kColorBackground,
    //     child: Image.asset(kImgSplashScreenBG, fit: BoxFit.fill),
    //   ),
    // );
  }
}
