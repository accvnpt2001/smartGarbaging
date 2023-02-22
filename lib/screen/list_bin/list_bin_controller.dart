import 'dart:convert';

import 'package:get/get.dart';
import 'package:smartgarbaging/service/api/api_service.dart';

import '../../models/bin.dart';
import '../../service/api/base_request/request_model.dart';

class RequestGetAllBin extends RequestModel {
  RequestGetAllBin(String params) : super('/bin', RequestMethod.getMethod, params);
}

class ListBinController extends GetxController {
  RxList<Bin> listbin = <Bin>[].obs;

  @override
  void onReady() async {
    var response = await ApiServices().request(RequestGetAllBin('')) as List<dynamic>;
    response.forEach((element) {
      listbin.add(Bin.fromJson(json.encode(element)));
    });
    print(listbin.value);
    super.onReady();
  }
}
