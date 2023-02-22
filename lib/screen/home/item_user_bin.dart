import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/util/app_routes.dart';

import '../../util/j_text.dart';

Widget itemUserBin() {
  return InkWell(
    onTap: () => Get.toNamed(RouterNames.SELECT_ONE_BIN_VIEW),
    child: Container(
      padding: EdgeInsets.all(5.h),
      height: 60.h,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orangeAccent,
                style: BorderStyle.solid,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: JText(
                text: "20",
                fontSize: 16.sp,
                textColor: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JText(
                text: "Adress",
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              JText(
                text: "Ngõ 23 Ngô Văn Tự, đường Hoàng Quốc Việt",
                width: Get.width * 0.63,
                pin: EdgeInsets.symmetric(vertical: 2.h),
                lineSpacing: 1.2,
                fontSize: 10.sp,
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 25.h,
              ),
              JText(
                text: "90%",
                fontSize: 10.h,
                fontWeight: FontWeight.bold,
              )
            ],
          )
        ],
      ),
    ),
  );
}
