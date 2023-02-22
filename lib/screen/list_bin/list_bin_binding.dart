import 'package:get/get.dart';
import 'package:smartgarbaging/screen/list_bin/list_bin_controller.dart';

class ListBinBinding implements Bindings {
  @override
  void dependencies() async {
    if (Get.isRegistered<ListBinController>()) await Get.delete<ListBinController>();
    Get.put(ListBinController());
  }
}
