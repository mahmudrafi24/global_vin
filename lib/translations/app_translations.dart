import 'package:global_vin/translations/en_translations.dart';
import 'package:global_vin/translations/bn_translations.dart';

class AppTranslations {
  static Map<String, Map<String, String>> get translations => {
        'en_US': EnTranslations.map,
        'bn_BD': BnTranslations.map,
      };
}
