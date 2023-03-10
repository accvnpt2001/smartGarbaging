import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/screen/home/select_bin_view.dart';
import 'package:smartgarbaging/util/app_routes.dart';

import '../../models/bin.dart';
import '../../util/j_text.dart';

Widget itemUserBin(Bin bin) {
  return InkWell(
    onTap: () => Get.to(SelectOneBinView(bin: bin)),
    child: Container(
      padding: EdgeInsets.all(5.h),
      height: 60.h,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bin.total < 80 ? Colors.transparent : Colors.red),
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
                text: bin.name,
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
                text: bin.address,
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
                color: bin.total < 80 ? (bin.total < 50 ? Colors.green : Colors.yellow) : Colors.red,
              ),
              JText(
                text: "${bin.total > 100 ? 100 : bin.total}%",
                fontSize: 10.h,
                textColor: bin.total < 80 ? (bin.total < 50 ? Colors.green : Colors.yellow) : Colors.red,
                fontWeight: FontWeight.bold,
              )
            ],
          )
        ],
      ),
    ),
  );
}
