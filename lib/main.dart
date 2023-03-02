import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartgarbaging/app_delegate.dart';
import 'package:smartgarbaging/screen/list_bin/list_bin_controller.dart';
import 'package:smartgarbaging/service/firebase_messing.dart';
import 'package:smartgarbaging/service/getlocator.dart';

void main() async {
  Get.put(GetLocatorService());
  Get.put(FirebaseMessagingService());
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessagingService().initService();
  // Get.put(TruckController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppDelegate();
  }
}
