import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/common/assets/app_images.dart';
import 'package:smartgarbaging/screen/detail_bin/detail_bin.dart';
import 'package:smartgarbaging/service/getlocator.dart';
import 'package:smartgarbaging/util/j_text.dart';

import '../../models/bin.dart';

class TruckController extends GetxController {
  Map<String, Marker> markerList = {};
  RxBool isLoading = true.obs;
  late Position currentLocation;

  @override
  void onInit() async {
    currentLocation = await Get.find<GetLocatorService>().getCurrentLocation();
    super.onInit();
  }

  Future<void> getCurrentLocationNew() async {
    currentLocation = await Get.find<GetLocatorService>().getCurrentLocation();
  }

  void addMarker(String id, LatLng location, String urlImage, String? description, int percent) async {
    var markerIconGreen = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.IC_TRASH_GREEN,
    );
    var markerIconYellow = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.IC_TRASH_YELLOW,
    );
    var markerIconRed = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.IC_TRASH_RED,
    );
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(title: "${percent}%", snippet: description),
        icon: percent < 50
            ? markerIconGreen
            : percent < 80
                ? markerIconYellow
                : markerIconRed,
        onTap: () => showBottomSheetMarker(id, urlImage, description, percent));

    markerList[id] = marker;
  }

  void addCenterMarker(String id) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.ICON_TRUCK,
    );

    var marker = Marker(
      markerId: MarkerId(id),
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      icon: markerIcon,
    );

    markerList[id] = marker;
  }

  Future<void> fakeData() async {
    isLoading = true.obs;
    addCenterMarker("main");
    fakedata.forEach((element) {
      addMarker(
        element.id,
        LatLng(element.lat, element.long),
        element.imageUrl,
        element.address,
        element.total[0],
      );
    });
    currentLocation = await Get.find<GetLocatorService>().getCurrentLocation();
    isLoading = false.obs;
  }

  void showBottomSheetMarker(String id, String urlImage, String? description, int percent) {
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
                        text: "Information",
                        textColor: AppColors.green2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        lineSpacing: 1.5,
                      ),
                      JText(
                        text: description,
                        textColor: AppColors.grey1,
                        fontSize: 12.sp,
                        pin: EdgeInsets.symmetric(vertical: 5.h),
                      ),
                    ],
                  ),
                  JText(
                    text: "${percent}%",
                    textColor: percent < 60 ? Colors.green : Colors.red,
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
                          imageUrl: urlImage,
                          errorWidget: ((context, url, error) => Container()),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                      onTap: () {
                        Get.to(
                            DetailBin(
                              binData: fakedata[int.parse(id) - 1],
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

List<Bin> fakedata = [];
