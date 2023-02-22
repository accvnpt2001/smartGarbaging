import 'package:get/get.dart';
import 'package:smartgarbaging/screen/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
