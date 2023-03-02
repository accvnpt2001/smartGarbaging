import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/assets/app_colors.dart';
import '../models/bin.dart';
import '../screen/detail_bin/detail_bin.dart';
import '../screen/detail_bin/detail_bin_controller.dart';
import 'j_text.dart';

class BottomSheetCustom {
  static void showBottomSheetMarker(Bin bin) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JText(
                        text: "Adress",
                        textColor: AppColors.green2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        lineSpacing: 1.5,
                      ),
                      JText(
                        text: bin.address,
                        textColor: AppColors.grey1,
                        fontSize: 12.sp,
                        width: Get.width * 0.8,
                        pin: EdgeInsets.symmetric(vertical: 5.h),
                      ),
                    ],
                  ),
                  JText(
                    text: "${bin.total > 100 ? 100 : bin.total}%",
                    textColor: bin.total < 60 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                            ),
                          ),
                          imageUrl: bin.imageUrl,
                          errorWidget: ((context, url, error) => Center(
                                  child: JText(
                                text: "No Image Available!",
                                fontSize: 10.sp,
                              ))),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                      onTap: () async {
                        if (Get.isRegistered<DetailBinController>()) {
                          Get.delete<DetailBinController>();
                        }
                        DetailBinController controller = Get.put(DetailBinController());
                        EasyLoading.show();
                        await controller.getDataTrash(bin.id);
                        EasyLoading.dismiss();
                        Get.to(
                            DetailBin(
                              binData: bin,
                            ),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: SizedBox(
                        height: 100.h,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          size: 20.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
    );
  }
}
