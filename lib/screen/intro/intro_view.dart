import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smartgarbaging/common/assets/app_images.dart';
import 'package:smartgarbaging/screen/auth/login_view.dart';
import 'package:smartgarbaging/screen/home/home_view.dart';
import 'package:smartgarbaging/util/app_routes.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.toNamed(RouterNames.LOGIN);
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, double height) {
    return Image.asset(assetName, height: height);
  }

  static const pageDecoration = PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    bodyTextStyle: TextStyle(color: Color(0xff575757), fontSize: 16, height: 1.5),
    pageColor: Color(0xffE5EDDA),
    imagePadding: EdgeInsets.zero,
  );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color(0xffE5EDDA),
      pages: [
        PageViewModel(
          title: "Smart Bin",
          body: "The system of smart trash cans is connected to locate and notify information everywhere ",
          image: _buildImage(AppImages.INTRO_1, Get.height / 5),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Support  garbage truck",
          body: "Provide location of garbage trucks and dump locations.",
          image: _buildImage(AppImages.INTRO_2, Get.height / 3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Chart everyday",
          body: "Monitor the amount of garbage by day by day in each area.",
          image: _buildImage(AppImages.INTRO_3, Get.height / 4),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      showBackButton: false,
      dotsFlex: 2,
      next: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xff4DC66F), Color(0xffA0DCA9)],
          ),
        ),
        child: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
      ),
      onSkip: () {},
      done: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xff4DC66F), Color(0xffA0DCA9)],
          ),
        ),
        child: const Text(
          "Done",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color(0xff7EAE41),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
