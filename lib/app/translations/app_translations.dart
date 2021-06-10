import 'package:shopping_phone/app/translations/en_US/en_us_translations.dart';
import 'package:shopping_phone/app/translations/vi_VN/vi_vn_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en_US': enUS,
    'vi_VN': viVN
  };
}
