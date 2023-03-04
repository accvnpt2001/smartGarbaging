import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/service/api/api_service.dart';
import 'package:smartgarbaging/util/app_routes.dart';

import '../../common/assets/app_colors.dart';
import '../../service/api/base_request/request_model.dart';
import '../../util/j_text.dart';
import '../home/home_controller.dart';

class RequestLogin extends RequestModel {
  RequestLogin(String params) : super('/auth/login', RequestMethod.postMethod, params);
}

class RequestRegister extends RequestModel {
  RequestRegister(String params) : super('/auth/register', RequestMethod.postMethod, params);
}

class AuthController extends GetxController {
  RxBool signInMode = true.obs;
  RxBool isLoginFailed = false.obs;
  RxBool isRegisterFailed = false.obs;
  TextEditingController account = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController accountRegis = TextEditingController();
  TextEditingController passwordRegis = TextEditingController();
  TextEditingController confirmPasswordRegis = TextEditingController();

  void loginOnclick() async {
    var body = {"username": account.text, "password": password.text};
    String jsonBody = json.encode(body);
    var request = RequestLogin(jsonBody);
    EasyLoading.show(status: "Loading ...");
    var response = await ApiServices().request(request);
    if (response != "Wrong password" && response != "User not exist") {
      GetStorage().write("token", response['token']);
      GetStorage().write("accountName", response['username']);
      GetStorage().write("userID", response['_id']);
      registerDeviceIdUser(response['_id']);
      Get.toNamed(RouterNames.HOME);
    } else {
      isLoginFailed.value = true;
      Get.snackbar(
        "Đăng nhập thất bại",
        "Tài khoản không tồn tại hoặc mật khẩu không chính xác",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        isDismissible: false,
      );
    }
    EasyLoading.dismiss();
  }

  void signUpOnclick() async {
    if (confirmPasswordRegis.text != passwordRegis.text) {
      isRegisterFailed.value = true;
      return;
    }
    var body = {"username": accountRegis.text, "password": passwordRegis.text, "isAdmin": false};
    String jsonBody = json.encode(body);
    var request = RequestLogin(jsonBody);
    var response = await ApiServices().request(request);
    if (response != "User not exist") {
      Get.snackbar(
        "Wellcome ${response['username']}",
        "Bạn đã đăng ký thành công",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        isDismissible: false,
      );
      isRegisterFailed.value = false;
    } else {
      Get.snackbar(
        "Đăng ký thất bại",
        "Tài khoản không tồn tại",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        isDismissible: false,
      );
    }
  }

  void registerDeviceIdUser(String userId) async {
    var deviceId = GetStorage().read("deviceId");
    var body = {"deviceId": deviceId};
    String jsonBody = json.encode(body);
    var request = RequestUpdateDeviceId(jsonBody);
    request.route = "${request.route}$userId";
    var response = await ApiServices().request(request);
    print(response);
  }
}
