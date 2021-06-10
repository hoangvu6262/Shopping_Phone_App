import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controller/appController.dart';
import 'app/controller/auth_controller.dart';
import 'app/controller/cart_controller.dart';
import 'app/controller/order_controller.dart';
import 'app/controller/product_controller.dart';
import 'app/controller/category_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/constants/firebase.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/page/widgets/bottom_app_bar.dart';
import 'app/ui/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(CartController());
    Get.put(OrderController());
    Get.put(CategoryController());
    Get.put(ProductController());
  });
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: SharedBottomAppBar(),
    locale: Locale('en', 'US'),
    translationsKeys: AppTranslation.translations,
  ));
}
