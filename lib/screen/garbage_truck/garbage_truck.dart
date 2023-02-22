import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartgarbaging/screen/garbage_truck/truck_controller.dart';

import '../../common/assets/app_colors.dart';
import '../../util/j_text.dart';

class GarbageTruck extends StatefulWidget {
  const GarbageTruck({super.key});

  @override
  State<GarbageTruck> createState() => _GarbageTruckState();
}

class _GarbageTruckState extends State<GarbageTruck> {
  late GoogleMapController mapController;
  TruckController truckController = Get.find<TruckController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: JText(
                text: "Collect garbage with truck",
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
              ),
              backgroundColor: AppColors.green2,
            ),
            body: Obx(
              () => truckController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(truckController.currentLocation.latitude, truckController.currentLocation.longitude),
                        zoom: 17,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      markers: truckController.markerList.values.toSet(),
                      circles: {
                        const Circle(
                            circleId: CircleId("1"),
                            center: LatLng(20.985365, 105.8427593),
                            radius: 430,
                            strokeWidth: 2,
                            fillColor: Color.fromARGB(65, 162, 255, 167))
                      },
                    ),
            )));
  }
}
