// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/common/assets/app_images.dart';
import 'package:smartgarbaging/models/bin.dart';
import 'package:smartgarbaging/screen/detail_bin/detail_bin.dart';
import 'package:smartgarbaging/util/app_routes.dart';
import 'package:smartgarbaging/util/j_image.dart';

import '../../util/j_text.dart';

class ItemBin extends StatelessWidget {
  Bin binData;
  ItemBin({
    Key? key,
    required this.binData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailBin(binData: binData));
      },
      child: Container(
        padding: EdgeInsets.all(5.h),
        height: 100.h,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 20.h,
                  margin: EdgeInsets.only(right: 10.w),
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
                      text: binData.name,
                      fontSize: 14.sp,
                      textColor: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                JText(
                  text: binData.address,
                  width: Get.width * 0.5,
                  pin: EdgeInsets.symmetric(vertical: 2.h),
                  lineSpacing: 1.2,
                  fontSize: 10.sp,
                ),
                SizedBox(height: 10.h),
                LinearPercentIndicator(
                  width: 150.w,
                  lineHeight: 15.h,
                  percent: binData.total[0] / 100,
                  barRadius: Radius.circular(10.r),
                  backgroundColor: AppColors.green1,
                  animation: true,
                  center: JText(
                    text: "${binData.total[0]}%",
                    fontSize: 12.sp,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  progressColor: AppColors.green2,
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: AppColors.green2.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                      ),
                    ),
                    imageUrl: "https://media.timeout.com/images/105910674/750/422/image.jpg",
                    errorWidget: ((context, url, error) => Container()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
