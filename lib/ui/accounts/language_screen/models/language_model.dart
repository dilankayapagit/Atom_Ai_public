import 'package:get/get.dart';

import '../../../../utils/image_constant.dart';
import 'listflag_item_model.dart';

class LanguageModel {
  var listflagItemList = [
    ListflagItemModel(
      countryCode: 'US',
      img: ImageConstant.imgUsPng,
      langCode: 'en',
      name: 'English (US)',
    ),
    ListflagItemModel(
      countryCode: 'FR',
      img: ImageConstant.img112,
      langCode: 'fr',
      name: 'Français',
    ),
     ListflagItemModel(
      countryCode: 'ES',
      img: ImageConstant.img54,
      langCode: 'es',
      name: 'español',
    ),
    
  ].obs;
}
