import 'package:get/get.dart';

import 'en_us/en_us_translations.dart';
import 'es_es/es_es_translations.dart';
import 'fr_fr/fr_fr_translations.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'fr_FR': frFr,
        'es_ES': esEs,
      };
}
