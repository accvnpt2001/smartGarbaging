import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/screen/garbage_truck/truck_controller.dart';
import 'package:smartgarbaging/screen/home/home_controller.dart';
import 'package:smartgarbaging/screen/home/item_user_bin.dart';
import 'package:smartgarbaging/util/app_routes.dart';

import '../../common/assets/app_images.dart';
import '../../util/j_image.dart';
import '../../util/j_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? currentBackPressTime;
  HomeController homeController = Get.find<HomeController>();

  var userName = GetStorage().read("accountName");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: Get.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.BACKGROUND_HOME),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Container(
                      padding: EdgeInsets.only(bottom: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.4),
                        ),
                        child: blockProfile(),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    JText(
                      width: Get.width,
                      textAlign: TextAlign.start,
                      text: "Let's collect garbage",
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                    service(context),
                    JText(
                      margin: EdgeInsets.only(top: 10.h),
                      width: Get.width,
                      textAlign: TextAlign.start,
                      text: "My smart bin",
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                    Obx(() => homeController.loadingUserBin.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                homeController.loadListUserBin();
                              },
                              child: ListView.builder(
                                itemBuilder: ((context, index) => itemUserBin(homeController.listUserBin[index])),
                                itemCount: homeController.listUserBin.length,
                              ),
                            ),
                          ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget blockProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: JImage(
              assetPath: AppImages.DEFAULT_AVATAR,
              width: 70.w,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.w, top: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JText(
                    pin: EdgeInsets.symmetric(vertical: 2.h),
                    text: "$userName",
                    fontSize: 18.sp,
                  ),
                  JText(
                    pin: EdgeInsets.only(top: 5.h),
                    text: "09223828",
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white,
                    fontSize: 15.sp,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.find<HomeController>().logout(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: JImage(
                assetPath: AppImages.ICON_LOGOUT,
                width: 30.w,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget service(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: InkWell(
            onTap: () {
              showGeneralDialog(
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 300),
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return alertDiaglogCustom();
                  });
              // Get.toNamed(RouterNames.GARBAGE_TRUCK);
            },
            child: Container(
              margin: EdgeInsets.only(top: 10.h, right: 15.w),
              height: Get.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 140.h,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      child: JImage(
                        assetPath: AppImages.GARBAGE_TRUCK,
                        boxFit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  JText(
                    pin: EdgeInsets.symmetric(vertical: 18.h),
                    text: "Start with garbage truck",
                    textColor: Colors.grey,
                    fontSize: 12.sp,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () => Get.toNamed(RouterNames.LIST_BIN),
            child: Container(
              margin: EdgeInsets.only(top: 10.h, left: 5.w),
              height: Get.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 140.h,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      child: JImage(
                        assetPath: AppImages.SMART_BIN,
                        boxFit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  JText(
                    pin: EdgeInsets.symmetric(vertical: 18.h),
                    text: "Smart bin",
                    textColor: Colors.grey,
                    fontSize: 12.sp,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget alertDiaglogCustom() {
    return Obx(() => Align(
          alignment: Alignment.center,
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(5.w),
              height: 120.h,
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(children: [
                  JText(
                    pin: EdgeInsets.only(top: 5.h),
                    text: "Để sử dụng dịch vụ này bạn cần bật định vị và cho phép truy cập vào vị trí của ứng dụng.",
                    fontSize: 15.sp,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (!Get.isRegistered<TruckController>()) Get.put(TruckController());
                            Get.find<HomeController>().getDataTruck();
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.h),
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: AppColors.green1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Get.find<HomeController>().loadingTruckData.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.green,
                                    )
                                  : JText(
                                      text: "OK",
                                      textColor: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
        ));
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
