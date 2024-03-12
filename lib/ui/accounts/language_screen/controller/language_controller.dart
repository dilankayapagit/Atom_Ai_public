import 'package:atomai/app_export.dart';
import 'package:atomai/ui/accounts/language_screen/models/language_model.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';

import '../models/listflag_item_model.dart';

class LanguageController extends GetxController {
  Rx<LanguageModel> languageModelObj = LanguageModel().obs;
  var listflagItemModel = ListflagItemModel().obs;
  var box = GetStorage();

  updateLang(ListflagItemModel listflagItemModel) {
    this.listflagItemModel(listflagItemModel);
    box.write("lang", listflagItemModel.name);
    update();
  }

  startup() async {
    ListflagItemModel model = languageModelObj.value.listflagItemList[0];
    var name = box.read("lang");

    for (var element in languageModelObj.value.listflagItemList) {
      if (element.name == name) {
        model = element;
        listflagItemModel(model);
        Get.updateLocale(
          Locale(
            model.langCode ?? "",
            model.countryCode,
          ),
        );
        await Jiffy.setLocale(model.langCode ?? "");
        ValidationBuilder.setLocale(model.langCode ?? "");

        return;
      }
    }
    listflagItemModel(model);
    box.write("lang", model.name);
    Get.updateLocale(
      Locale(
        model.langCode ?? "",
        model.countryCode,
      ),
    );
    await Jiffy.setLocale(model.langCode ?? "");
    ValidationBuilder.setLocale(model.langCode ?? "");
    update();
  }

  @override
  void onReady() {
    super.onReady();
    startup();
  }
}
