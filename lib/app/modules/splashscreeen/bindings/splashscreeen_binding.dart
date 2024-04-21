import 'package:get/get.dart';

import '../controllers/splashscreeen_controller.dart';

class SplashscreeenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreeenController>(
      () => SplashscreeenController(),
    );
  }
}
