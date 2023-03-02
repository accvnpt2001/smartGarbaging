import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/screen/auth/auth_controller.dart';
import 'package:smartgarbaging/util/app_routes.dart';
import 'package:smartgarbaging/util/j_text.dart';
import 'package:smartgarbaging/util/text_filed.dart';

import '../../common/assets/app_images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? currentBackPressTime;
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: Get.height / 2.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.BACKGROUND_LOGIN),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: Get.height / 2.5 - 10),
                        width: double.infinity,
                        height: Get.height * (1 - 1 / 2.5) - 20,
                        decoration: const BoxDecoration(
                            color: AppColors.background_home,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            )),
                        child: Obx((() => controller.signInMode.value ? signInForm() : signUpForm()))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signInForm() {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Column(
        children: [
          JText(
            text: "Welcome to \n Smart Garbaging!",
            textColor: const Color(0xff29313A),
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            lineSpacing: 1.2,
            width: double.infinity,
            textAlign: TextAlign.start,
          ),
          JText(
            text: "Sign in to your account",
            textColor: AppColors.grey1,
            fontSize: 15.sp,
            lineSpacing: 2,
            width: double.infinity,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5.h),
          TextFieldCustome(
            controller: controller.account,
            width: Get.width * 0.7,
            hint: "Account name",
            icon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.person,
                color: AppColors.grey1,
              ),
            ),
          ),
          TextFieldCustome(
            controller: controller.password,
            width: Get.width * 0.7,
            isPassword: true,
            hint: "Password",
            icon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.lock,
                color: AppColors.grey1,
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoginFailed.value,
              child: JText(
                width: Get.width * 0.6,
                textAlign: TextAlign.center,
                lineSpacing: 1.2,
                text: "Your account/password is incorrect or already exists",
                textColor: Colors.red,
                fontSize: 8.sp,
                pin: EdgeInsets.only(top: 5.h),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.loginOnclick();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              width: Get.width * 0.7,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.green2,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                  child: JText(
                text: "Login",
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  JText(
                    text: "Don't have a account?",
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 10.w),
                  JText(
                    text: "Sign Up",
                    fontSize: 14.sp,
                    tappedText: () {
                      controller.signInMode.value = false;
                    },
                    fontWeight: FontWeight.bold,
                    textDecoration: TextDecoration.underline,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpForm() {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Column(
        children: [
          JText(
            text: "Sign Up New Accounr",
            textColor: const Color(0xff29313A),
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            lineSpacing: 1.2,
            width: double.infinity,
            textAlign: TextAlign.start,
          ),
          TextFieldCustome(
            controller: controller.accountRegis,
            width: Get.width * 0.7,
            hint: "Account name",
            icon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.person,
                color: AppColors.grey1,
              ),
            ),
          ),
          TextFieldCustome(
            controller: controller.passwordRegis,
            width: Get.width * 0.7,
            isPassword: true,
            hint: "Password",
            icon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.lock,
                color: AppColors.grey1,
              ),
            ),
          ),
          TextFieldCustome(
            controller: controller.confirmPasswordRegis,
            width: Get.width * 0.7,
            isPassword: true,
            hint: "Confirm Password",
            icon: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.lock,
                color: AppColors.grey1,
              ),
            ),
          ),
          Visibility(
            visible: controller.isRegisterFailed.value,
            child: JText(
              width: Get.width * 0.6,
              textAlign: TextAlign.center,
              lineSpacing: 1.2,
              text: "Please fill in the correct information",
              textColor: Colors.red,
              fontSize: 8.sp,
              pin: EdgeInsets.only(top: 5.h),
            ),
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: () => Get.toNamed(RouterNames.HOME),
            child: InkWell(
              onTap: () => controller.signUpOnclick(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: Get.width * 0.7,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 4, 175, 188),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                    child: JText(
                  text: "Sign Up",
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                )),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: () {
              controller.signInMode.value = true;
            },
            child: Container(
              width: Get.width * 0.3,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.green2,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                  child: JText(
                text: "Back to LogIn",
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
}
