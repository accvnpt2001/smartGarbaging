// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/models/bin.dart';
import 'package:smartgarbaging/util/chart.dart';
import 'package:smartgarbaging/util/j_text.dart';

class DetailBin extends StatefulWidget {
  Bin? binData;
  DetailBin({
    Key? key,
    this.binData,
  }) : super(key: key);

  @override
  State<DetailBin> createState() => _DetailBinState();
}

class _DetailBinState extends State<DetailBin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JText(
                    text: "Adress",
                    textColor: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    textAlign: TextAlign.start,
                    pin: EdgeInsets.only(top: 10.h),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 70.w,
                      height: 25.h,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: JText(
                          text: "Follow",
                          textColor: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              JText(
                text: widget.binData?.address ?? "no infor",
                textColor: AppColors.grey1,
                fontSize: 15.sp,
                pin: EdgeInsets.symmetric(vertical: 10.h),
                textAlign: TextAlign.start,
                width: Get.width,
              ),
              SizedBox(
                height: 100.h,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                            ),
                          ),
                      imageUrl: widget.binData?.imageUrl ?? "",
                      errorWidget: (context, url, error) => Container()),
                ),
              ),
              Divider(
                height: 20.h,
                thickness: 1.2,
                indent: 10,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JText(
                    text: "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    fontSize: 12.sp,
                    textColor: Colors.blueGrey,
                  ),
                  JText(
                    pin: EdgeInsets.symmetric(vertical: 10.h),
                    text: "75%",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.redAccent,
                  ),
                ],
              ),
              Expanded(child: ChartView())
            ],
          ),
        ),
      ),
    );
  }
}
