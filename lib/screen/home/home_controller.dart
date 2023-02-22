import 'package:get/get.dart';
import 'package:smartgarbaging/screen/garbage_truck/truck_controller.dart';

import '../../util/app_routes.dart';

class HomeController extends GetxController {
  RxBool loadingTruckData = false.obs;

  void getDataTruck() async {
    loadingTruckData.value = true;
    await Get.find<TruckController>().getCurrentLocationNew();
    await Get.find<TruckController>().fakeData();
    loadingTruckData.value = false;
    Get.toNamed(RouterNames.GARBAGE_TRUCK);
  }
}
