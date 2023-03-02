import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smartgarbaging/service/api/api_service.dart';

import '../../models/bin.dart';
import '../../service/api/base_request/request_model.dart';

class RequestGetAllBin extends RequestModel {
  RequestGetAllBin(String params) : super('/bin', RequestMethod.getMethod, params);
}

class ListBinController extends GetxController {
  RxList<Bin> listbin = <Bin>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() async {
    isLoading.value = true;
    EasyLoading.show(status: "Loading bins ....");
    var response = await ApiServices().request(RequestGetAllBin(''));
    response.forEach((e) {
      listbin.add(Bin.fromMap(e));
    });
    EasyLoading.dismiss();
    isLoading.value = false;
    super.onReady();
  }
}
