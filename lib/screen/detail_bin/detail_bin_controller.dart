import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/models/bin_tail.dart';

import '../../service/api/api_service.dart';
import '../../service/api/base_request/request_model.dart';

class RequestGetBinById extends RequestModel {
  RequestGetBinById(String params) : super('/bin/statistic-trash', RequestMethod.postMethod, params);
}

class RequestFollowBin extends RequestModel {
  RequestFollowBin(String params) : super('/manage', RequestMethod.postMethod, params);
}

class RequestUnFollowBin extends RequestModel {
  RequestUnFollowBin(String params) : super('/manage/delete-manage', RequestMethod.postMethod, params);
}

class DetailBinController extends GetxController {
  RxList<int> organics = <int>[].obs;
  RxList<int> inOrganics = <int>[].obs;
  RxList<int> recyclables = <int>[].obs;
  RxList<int> total = <int>[].obs;
  RxBool isFollowed = false.obs;
  RxBool isLoading = false.obs;

  Future<void> getDataTrash(String id) async {
    isLoading.value = true;
    var body = {
      "binIds": [id],
      "numDay": 7
    };
    String jsonBody = json.encode(body);
    var request = RequestGetBinById(jsonBody);
    EasyLoading.show();
    var response = await ApiServices().request(request);
    var a = BinDetail.fromMap(response[0]);
    organics.value = a.organics;
    inOrganics.value = a.inorganics;
    recyclables.value = a.recyclables;
    for (int i = 0; i < organics.length; i++) {
      int a = (organics[i] + inOrganics[i] + recyclables[i]) ~/ 3;
      total.add(a > 100 ? 100 : a);
    }
    EasyLoading.dismiss();
    isLoading.value = false;
  }

  Future<void> onClickFollowBin(String binId) async {
    var userId = GetStorage().read("userID");
    var body = {"userId": userId, "binId": binId};
    String jsonBody = json.encode(body);
    var request = RequestFollowBin(jsonBody);
    EasyLoading.show();
    var response = await ApiServices().request(request);
    isFollowed.value = true;
    EasyLoading.dismiss();
  }

  Future<void> onClickUnFollowBin(String binId) async {
    var userId = GetStorage().read("userID");
    var body = {"userId": userId, "binId": binId};
    String jsonBody = json.encode(body);
    var request = RequestUnFollowBin(jsonBody);
    EasyLoading.show();
    var response = await ApiServices().request(request);
    isFollowed.value = false;
    EasyLoading.dismiss();
  }

  checkFollowBin(String binId) {
    List<String> listId = GetStorage().read("listIDUserBin");
    if (listId.contains(binId)) isFollowed.value = true;
  }
}
