import 'package:get/get.dart';
import 'package:yewlow_apps/core/controller/home-controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
