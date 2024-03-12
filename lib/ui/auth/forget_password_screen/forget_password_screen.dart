import 'package:form_validator/form_validator.dart';

import '../../../services/vibtaion_service.dart';
import '../../../widgets/web_sites_page.dart';
import 'controller/forget_password_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

// ignore_for_file: must_be_immutable
class ForgetPasswordScreen extends GetWidget<ForgetPasswordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailValidator = ValidationBuilder().email().maxLength(50).build();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: ColorConstant.gray900,
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      width: size.width,
                      padding:
                          getPadding(left: 25, top: 56, right: 25, bottom: 56),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgArrowleft,
                                height: getSize(24.00),
                                width: getSize(24.00),
                                onTap: () {
                                  VibrationService.vibrate();

                                  onTapImgArrowleft();
                                }),
                            Container(
                              width: size.width * 0.9,
                              margin: getMargin(left: 5, top: 51),
                              child: Text(
                                "msg_il_semble_que_vous_avez".tr,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                                style: AppStyle
                                    .txtMontserratAlternatesSemiBold32
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(0.53),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: getHorizontalSize(357.00),
                                    margin: getMargin(
                                      top: 14,
                                      left: 5,
                                    ),
                                    child: Text("msg_veuillez_saisir".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtMulishRomanRegular16Indigo5099
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.30))))),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: getPadding(left: 5, top: 16),
                                child: Text("lbl_email".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsMedium16.copyWith(
                                        letterSpacing:
                                            getHorizontalSize(0.30)))),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                                width: 366,
                                focusNode: FocusNode(),
                                controller: controller.emailOneController,
                                hintText: "lbl_email".tr,
                                margin: getMargin(left: 3, top: 7),
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.emailAddress,
                                validator: emailValidator),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                                onTap: () async {
                                  VibrationService.vibrate();

                                  if (!(_formKey.currentState!.validate())) {
                                    return;
                                  }
                                  if (await controller.sendResetForm()) return;
                                  Get.offNamed(AppRoutes
                                      .forgetPasswordSuccesResetScreen);
                                },
                                height: 64,
                                width: 366,
                                text: "lbl_envoyer_le_code".tr,
                                margin: getMargin(left: 3, top: 30)),
                            GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                Get.to(
                                  () => const WebSitesPage(
                                    name: "lbl_centre_d_aide",
                                    url: "https://atomai.fr/help-center/",
                                  ),
                                );
                              },
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(top: 31, bottom: 5),
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "msg_vous_avez_un_probl_me2"
                                                        .tr,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.indigo50,
                                                    fontSize: getFontSize(14),
                                                    fontFamily: 'Mulish',
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.26))),
                                            TextSpan(
                                                text: " ".tr,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.indigo50,
                                                    fontSize: getFontSize(14),
                                                    fontFamily: 'Mulish',
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.26))),
                                            TextSpan(
                                                text: "lbl_contactez_nous".tr,
                                                style: TextStyle(
                                                    color:
                                                        ColorConstant.indigo400,
                                                    fontSize: getFontSize(14),
                                                    fontFamily: 'Mulish',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.26)))
                                          ]),
                                          textAlign: TextAlign.left))),
                            )
                          ]))),
            )));
  }

  onTapImgArrowleft() {
    Get.back();
  }
}
