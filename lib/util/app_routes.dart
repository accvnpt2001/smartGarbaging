import 'package:get/get.dart';
import 'package:smartgarbaging/screen/auth/login_view.dart';
import 'package:smartgarbaging/screen/detail_bin/detail_bin.dart';
import 'package:smartgarbaging/screen/garbage_truck/garbage_truck.dart';
import 'package:smartgarbaging/screen/garbage_truck/truck_controller.dart';
import 'package:smartgarbaging/screen/home/home_binding.dart';
import 'package:smartgarbaging/screen/home/home_view.dart';
import 'package:smartgarbaging/screen/home/select_bin_view.dart';
import 'package:smartgarbaging/screen/list_bin/list_bin.dart';
import 'package:smartgarbaging/screen/splash/splash_view.dart';

import '../screen/list_bin/list_bin_binding.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(
      name: RouterNames.SFLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouterNames.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouterNames.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouterNames.GARBAGE_TRUCK,
      page: () => GarbageTruck(),
    ),
    GetPage(
      name: RouterNames.DETAIL_BIN,
      page: () => DetailBin(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterNames.LIST_BIN,
      page: () => ListBin(),
      binding: ListBinBinding(),
    ),
    GetPage(
      name: RouterNames.SELECT_ONE_BIN_VIEW,
      page: () => SelectOneBinView(),
    )
  ];
}

class RouterNames {
  RouterNames._();
  static const SFLASH = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const GARBAGE_TRUCK = '/garbarge_truck';
  static const DETAIL_BIN = '/detail_bin';
  static const LIST_BIN = '/list_bin';
  static const SELECT_ONE_BIN_VIEW = '/select_one_bin';
}
