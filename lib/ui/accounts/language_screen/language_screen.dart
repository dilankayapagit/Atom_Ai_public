import 'package:form_validator/form_validator.dart';
import 'package:jiffy/jiffy.dart';

import '../../../services/vibtaion_service.dart';
import '../language_screen/widgets/listflag_item_widget.dart';
import 'controller/language_controller.dart';
import 'models/listflag_item_model.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/app_bar/appbar_subtitle_2.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  var controller = Get.put(LanguageController());

  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // controller.startup();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorConstant.gray900,
          appBar: CustomAppBar(
              height: getVerticalSize(56.00),
              leadingWidth: 48,
              leading: AppbarImage(
                height: getSize(24.00),
                width: getSize(24.00),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 24, top: 16, bottom: 16),
                onTap: () {
                  Get.back();
                },
              ),
              title: AppbarSubtitle2(
                  text: "lbl_langue".tr, margin: getMargin(left: 12))),
          body: SingleChildScrollView(
            child: Padding(
              padding: getPadding(left: 24, top: 20, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {});
                      },
                      controller: textEditingController,
                      style: TextStyle(
                        color: ColorConstant.indigo5099,
                        fontSize: getFontSize(
                          16,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: _buildDecoration(),
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 24),
                    child: Text(
                      "msg_langue_s_l_ctionn_e".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsRegular14Indigo5099.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: getMargin(top: 14),
                    padding: getPadding(all: 10),
                    child:
                        ListflagItemWidget(controller.listflagItemModel.value),
                  ),
                  Padding(
                    padding: getPadding(top: 24),
                    child: Text(
                      "lbl_langues".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtRobotoRegular14.copyWith(
                        letterSpacing: getHorizontalSize(0.30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 18),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                          .languageModelObj.value.listflagItemList.length,
                      itemBuilder: (context, index) {
                        ListflagItemModel model = controller
                            .languageModelObj.value.listflagItemList[index];
                        if (textEditingController.text != "" &&
                            !(model.name!.toLowerCase().contains(
                                textEditingController.text.toLowerCase()))) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                              onTap: () async {
                                VibrationService.vibrate();

                                controller.updateLang(model);
                                await Jiffy.setLocale(model.langCode ?? "");
                                ValidationBuilder.setLocale(
                                    model.langCode ?? "");

                                Get.updateLocale(Locale(
                                    model.langCode ?? "", model.countryCode));
                              },
                              child: ListflagItemWidget(model)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintStyle: TextStyle(
        color: ColorConstant.indigo5099,
        fontSize: getFontSize(
          16,
        ),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      fillColor: ColorConstant.blueGray8004c,
      hintText: "lbl_rechercher".tr,
      filled: true,
      isDense: true,
      suffix: IconButton(
        onPressed: () {
          VibrationService.vibrate();

          textEditingController.clear();
          setState(() {});
        },
        icon: Icon(
          Icons.clear,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          8.00,
        ),
      ),
      borderSide: BorderSide.none,
    );
  }

  onTapArrowleft4() {
    Get.back();
  }
}
