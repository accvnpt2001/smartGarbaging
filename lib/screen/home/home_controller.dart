import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/screen/garbage_truck/truck_controller.dart';

import '../../models/bin.dart';
import '../../service/api/api_service.dart';
import '../../service/api/base_request/request_model.dart';
import '../../util/app_routes.dart';

class RequestGetBinUser extends RequestModel {
  RequestGetBinUser(String params) : super('/bin/get-bins-by-user-id?userId=', RequestMethod.getMethod, params);
}

class RequestUpdateDeviceId extends RequestModel {
  RequestUpdateDeviceId(String params) : super('/user/', RequestMethod.putMethod, params);
}

class HomeController extends GetxController {
  RxBool loadingTruckData = false.obs;
  RxBool loadingUserBin = false.obs;
  RxList<Bin> listUserBin = <Bin>[].obs;

  void getDataTruck() async {
    loadingTruckData.value = true;
    await Get.find<TruckController>().getCurrentLocationNew();
    await Get.find<TruckController>().getDataBin();
    loadingTruckData.value = false;
    Get.toNamed(RouterNames.GARBAGE_TRUCK);
  }

  @override
  void onReady() async {
    loadListUserBin();
    super.onReady();
  }

  void loadListUserBin() async {
    var userId = GetStorage().read("userID");
    var request = RequestGetBinUser('');
    request.route = "${request.route}$userId";
    loadingUserBin.value = true;
    var response = await ApiServices().request(request);
    listUserBin.clear();
    List<String> listIDUserBin = [];
    response.forEach((e) {
      listUserBin.add(Bin.fromMapUserId(e));
    });
    listUserBin.sort(((a, b) => a.total < b.total ? 1 : 0));
    listUserBin.forEach((e) {
      listIDUserBin.add(e.id);
    });
    GetStorage().write("listIDUserBin", listIDUserBin);
    loadingUserBin.value = false;
  }

  void logout() async {
    EasyLoading.show(status: "Logging out ...");
    var userId = GetStorage().read("userID");
    var body = {"deviceId": ""};
    String jsonBody = json.encode(body);
    var request = RequestUpdateDeviceId(jsonBody);
    request.route = "${request.route}$userId";
    var response = await ApiServices().request(request);
    print(response);
    GetStorage().write("token", null);
    GetStorage().write("accountName", null);
    EasyLoading.dismiss();
    Get.offAllNamed(RouterNames.LOGIN);
  }
}
