// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/models/bin.dart';
import 'package:smartgarbaging/screen/home/select_bin_controller.dart';
import 'package:smartgarbaging/util/bottomsheet.dart';

import '../../common/assets/app_images.dart';
import '../../util/j_text.dart';

class SelectOneBinView extends StatefulWidget {
  Bin bin;
  SelectOneBinView({
    Key? key,
    required this.bin,
  }) : super(key: key);

  @override
  State<SelectOneBinView> createState() => _SelectOneBinViewState();
}

class _SelectOneBinViewState extends State<SelectOneBinView> {
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor desLocationIcon = BitmapDescriptor.defaultMarker;
  SelectBinController controller = Get.put(SelectBinController());

  void setCustomeMarker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, AppImages.ICON_CUR_LOCATION).then((value) {
      currentLocationIcon = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, AppImages.IC_TRASH_GREEN).then((value) {
      desLocationIcon = value;
    });
  }

  @override
  void initState() {
    setCustomeMarker();
    controller.getPolyPoints(widget.bin.lat, widget.bin.long);
    super.initState();
  }

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: JText(
            text: "Slected Smart Bin Location",
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
          backgroundColor: AppColors.green2,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.viewPolyLine.value = !controller.viewPolyLine.value;
          },
          child: Center(child: Icon(controller.viewPolyLine.value ? Icons.visibility : Icons.visibility_off)),
        ),
        body: Obx(
          () => controller.currentLocation.value.latitude == 0
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.green2,
                ))
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(controller.currentLocation.value.latitude, controller.currentLocation.value.longitude),
                    zoom: 15,
                  ),
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      points: controller.viewPolyLine.value ? controller.polylineCoordinates : [],
                      width: 3,
                      color: Colors.deepPurple,
                    )
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentlocation"),
                      position:
                          LatLng(controller.currentLocation.value.latitude, controller.currentLocation.value.longitude),
                      icon: currentLocationIcon,
                    ),
                    Marker(
                        markerId: const MarkerId("des"),
                        position: LatLng(widget.bin.lat, widget.bin.long),
                        infoWindow: InfoWindow(
                            title: "${widget.bin.total > 100 ? 100 : widget.bin.total}%", snippet: widget.bin.address),
                        icon: desLocationIcon,
                        onTap: () => BottomSheetCustom.showBottomSheetMarker(widget.bin)),
                  },
                ),
        ));
  }
}
