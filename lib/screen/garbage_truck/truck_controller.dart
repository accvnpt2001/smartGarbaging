import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/common/assets/app_images.dart';
import 'package:smartgarbaging/screen/detail_bin/detail_bin.dart';
import 'package:smartgarbaging/service/getlocator.dart';
import 'package:smartgarbaging/util/bottomsheet.dart';
import 'package:smartgarbaging/util/j_text.dart';

import '../../models/bin.dart';
import '../../service/api/api_service.dart';
import '../detail_bin/detail_bin_controller.dart';
import '../list_bin/list_bin_controller.dart';

class TruckController extends GetxController {
  Map<String, Marker> markerList = {};
  RxBool isLoading = true.obs;
  Rx<Position> currentLocation = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime(2023),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;
  RxList<Bin> listBin = <Bin>[].obs;
  StreamSubscription<Position>? positionStream;

  @override
  void onInit() async {
    currentLocation.value = await Get.find<GetLocatorService>().getCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    positionStream?.cancel();
    print("close");
    super.onClose();
  }

  Future<void> getCurrentLocationNew() async {
    currentLocation.value = await Get.find<GetLocatorService>().getCurrentLocation();
    positionStream = Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 0))
        .listen((Position position) {
      currentLocation.value = position;
      addCenterMarker("main");
      print("tracking position!!!");
    });
  }

  void addMarker(Bin bin) async {
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
        markerId: MarkerId(bin.id),
        position: LatLng(bin.lat, bin.long),
        infoWindow: InfoWindow(title: "${bin.total > 100 ? 100 : bin.total}%", snippet: bin.address),
        icon: bin.total < 50
            ? markerIconGreen
            : bin.total < 80
                ? markerIconYellow
                : markerIconRed,
        onTap: () => BottomSheetCustom.showBottomSheetMarker(bin));

    markerList[bin.id] = marker;
  }

  void addCenterMarker(String id) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppImages.ICON_TRUCK,
    );
    var marker = Marker(
      markerId: MarkerId(id),
      position: LatLng(currentLocation.value.latitude, currentLocation.value.longitude),
      icon: markerIcon,
    );

    markerList[id] = marker;
  }

  Future<void> getDataBin() async {
    isLoading = true.obs;
    addCenterMarker("main");
    var response = await ApiServices().request(RequestGetAllBin(''));
    response.forEach((e) {
      listBin.add(Bin.fromMap(e));
    });
    listBin.forEach((e) {
      addMarker(e);
    });
    isLoading = false.obs;
  }
}
