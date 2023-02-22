// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/screen/list_bin/item_bin.dart';
import 'package:smartgarbaging/screen/list_bin/list_bin_controller.dart';
import 'package:smartgarbaging/util/j_text.dart';

import '../../models/bin.dart';

class ListBin extends StatelessWidget {
  const ListBin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ListBinController>();

    return SafeArea(
      child: Material(
        child: Scaffold(
          backgroundColor: AppColors.background_home,
          appBar: AppBar(
            backgroundColor: AppColors.green2,
            title: JText(
              text: "Smart bin",
              textColor: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.green2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Obx(() => controller.listbin.isEmpty && !controller.isLoading.value
                        ? Center(
                            child: JText(
                              text: "Bins is empty",
                              fontSize: 20.sp,
                              textColor: Colors.white,
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: ((context, index) => ItemBin(
                                  binData: controller.listbin[index],
                                )),
                            itemCount: controller.listbin.length,
                          )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
