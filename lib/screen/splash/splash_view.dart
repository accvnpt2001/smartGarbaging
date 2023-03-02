import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/service/notify_helper.dart';
import 'package:smartgarbaging/util/app_routes.dart';

import '../../common/assets/app_images.dart';
import '../auth/login_view.dart';
import '../intro/intro_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool toggle = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.BACKGROUND_SPLASH),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: Get.height / 2),
              alignment: Alignment.center,
              child: Image(
                image: const AssetImage(AppImages.LOGO_APP),
                width: 140.w,
                height: 140.w,
                fit: BoxFit.scaleDown,
              ),
            )
                .animate(
                  onComplete: (controller) => nextScreent(),
                )
                .slideY(
                  begin: -0.2,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.bounceOut,
                ),
          ],
        ),
      ),
    );
  }

  nextScreent() {
    NotificationHelper.configFCM();
    var storage = GetStorage();
    if (storage.read("firstTimeUseApp") == null) {
      Get.to(IntroScreen());
      storage.write("firstTimeUseApp", 1);
    } else if (storage.read("token") == null) {
      Get.toNamed(RouterNames.LOGIN);
    } else {
      Get.toNamed(RouterNames.HOME);
    }
  }
}
