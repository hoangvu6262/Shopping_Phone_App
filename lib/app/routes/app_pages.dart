import 'package:get/get.dart';
import 'package:shopping_phone/app/ui/page/authentication/auth.dart';
import 'package:shopping_phone/app/ui/page/authentication/update_profile.dart';
import 'package:shopping_phone/app/ui/page/cart/cart_page.dart';
import 'package:shopping_phone/app/ui/page/details/details.dart';
import 'package:shopping_phone/app/ui/page/details/details_page.dart';
import 'package:shopping_phone/app/ui/page/home/home_page.dart';
import 'package:shopping_phone/app/ui/page/splashscreen/splashscreen.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => Splash(),
    ),
    GetPage(
      name: Routes.INITIAL,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => AuthenticationScreen(),
    ),
    GetPage(
      name: Routes.UPDATE_PROFILE,
      page: () => UpdateProfilePage(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartPage(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DetailsScreen(item: Get.arguments),
    ),
  ];
}
