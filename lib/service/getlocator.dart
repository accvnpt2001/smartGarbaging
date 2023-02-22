import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class GetLocatorService extends GetxService {
  Future getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      Location location = Location();
      bool enabled = await location.requestService();
      if (!enabled) return Future.error("Location service is disabled!");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanly denied!");
    }

    return await Geolocator.getCurrentPosition();
  }
}
