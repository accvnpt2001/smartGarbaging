import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smartgarbaging/common/assets/app_colors.dart';
import 'package:smartgarbaging/common/configs/configs.dart';

import '../../common/assets/app_images.dart';
import '../../util/j_text.dart';

class SelectOneBinView extends StatefulWidget {
  const SelectOneBinView({super.key});

  @override
  State<SelectOneBinView> createState() => _SelectOneBinViewState();
}

class _SelectOneBinViewState extends State<SelectOneBinView> {
  LatLng sourceLocation = LatLng(20.9845183, 105.8415858);
  LatLng desLocation = LatLng(20.984858, 105.8429693);
  bool viewPolyLine = true;
  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];
  late StreamSubscription<LocationData> locationSubscription;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor desLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
      sourceLocation = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      polylineCoordinates.add(sourceLocation);
      polylineCoordinates.add(LatLng(20.984858, 105.8429693));
    });

    locationSubscription = location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Configs.googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(desLocation.latitude, desLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
    setState(() {});
  }

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
    getCurrentLocation();
    getPolyPoints();
    setCustomeMarker();
    super.initState();
  }

  @override
  void dispose() {
    locationSubscription.cancel();
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
          setState(() {
            viewPolyLine = !viewPolyLine;
          });
        },
        child: Center(child: Icon(viewPolyLine ? Icons.visibility : Icons.visibility_off)),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.green2,
            ))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 15,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: viewPolyLine ? polylineCoordinates : [],
                  width: 3,
                  color: Colors.deepPurple,
                )
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentlocation"),
                  position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: currentLocationIcon,
                ),
                Marker(
                  markerId: const MarkerId("des"),
                  position: desLocation,
                  icon: desLocationIcon,
                ),
              },
            ),
    );
  }
}
