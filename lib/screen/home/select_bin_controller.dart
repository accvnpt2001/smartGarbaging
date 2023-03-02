import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/configs/configs.dart';
import '../../service/getlocator.dart';

class SelectBinController extends GetxController {
  RxBool viewPolyLine = true.obs;
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
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  StreamSubscription<Position>? positionStream;

  @override
  void onInit() async {
    await getCurrentLocationNew();
    polylineCoordinates.add(LatLng(currentLocation.value.latitude, currentLocation.value.longitude));
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
      polylineCoordinates.remove(LatLng(currentLocation.value.latitude, currentLocation.value.longitude));
      currentLocation.value = position;
      polylineCoordinates.add(LatLng(currentLocation.value.latitude, currentLocation.value.longitude));
      print("tracking position!!! ${currentLocation.value.latitude}");
    });
  }

  void getPolyPoints(double desLat, double desLong) async {
    PolylinePoints polylinePoints = PolylinePoints();
    polylineCoordinates.add(LatLng(desLat, desLong));
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Configs.googleApiKey,
      PointLatLng(currentLocation.value.latitude, currentLocation.value.longitude),
      PointLatLng(desLat, desLong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }
  }
}
