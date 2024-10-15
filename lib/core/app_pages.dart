import 'package:get/get.dart';
import 'package:yewlow_apps/core/app_bindings.dart';
import 'package:yewlow_apps/modules/auth/login-view.dart';

import '../modules/home/home-view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AppBindings(),
    ),
  ];
}
