import 'package:form_validator/form_validator.dart';

import '../../../services/vibtaion_service.dart';
import 'controller/login_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValidator = ValidationBuilder().email().maxLength(50).build();

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
              padding: getPadding(left: 17, top: 56, right: 17, bottom: 56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageView(
                      svgPath: ImageConstant.imgArrowleft,
                      height: getSize(24.00),
                      width: getSize(24.00),
                      margin: getMargin(left: 4),
                      onTap: () {
                        onTapImgArrowleft();
                      }),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: getVerticalSize(104.00),
                          width: getHorizontalSize(338.00),
                          margin: getMargin(top: 15),
                          child: Stack(alignment: Alignment.center, children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgDesignsanstitre,
                                height: getSize(88.00),
                                width: getSize(88.00),
                                alignment: Alignment.centerLeft,
                                margin: getMargin(left: 14)),
                            CustomImageView(
                                imagePath: ImageConstant.imgLogoatomai1,
                                height: getVerticalSize(104.00),
                                width: getHorizontalSize(338.00),
                                alignment: Alignment.center)
                          ]))),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: getHorizontalSize(235.00),
                          margin: getMargin(top: 18),
                          child: Text("msg_login_now_to_access".tr,
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: AppStyle.txtMulishRomanRegular14Indigo5099
                                  .copyWith(
                                      letterSpacing:
                                          getHorizontalSize(0.26))))),
                  Padding(
                      padding: getPadding(left: 7, top: 99),
                      child: Text("lbl_email".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16.copyWith(
                              letterSpacing: getHorizontalSize(0.30)))),
                  CustomTextFormField(
                    width: 366,
                    focusNode: FocusNode(),
                    validator: emailValidator,
                    controller: controller.emailOneController,
                    hintText: "lbl_email".tr,
                    margin: getMargin(left: 7, top: 7),
                    textInputType: TextInputType.emailAddress,
                  ),
                  Padding(
                      padding: getPadding(left: 7, top: 18),
                      child: Text("lbl_mot_de_passe".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16.copyWith(
                              letterSpacing: getHorizontalSize(0.30)))),
                  Obx(
                    () => CustomTextFormField(
                      width: 366,
                      focusNode: FocusNode(),
                      controller: controller.passwordOneController,
                      hintText: "lbl".tr,
                      margin: getMargin(left: 7, top: 4),
                      padding: TextFormFieldPadding.PaddingT18,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      suffix: InkWell(
                        onTap: () {
                          VibrationService.vibrate();

                          controller.isShowPassword.value =
                              !controller.isShowPassword.value;
                        },
                        child: Container(
                          margin: getMargin(
                              left: 30, top: 20, right: 16, bottom: 20),
                          child: CustomImageView(
                            svgPath: controller.isShowPassword.value
                                ? ImageConstant.imgDashboard
                                : ImageConstant.imgDashboard,
                          ),
                        ),
                      ),
                      suffixConstraints:
                          BoxConstraints(maxHeight: getVerticalSize(64.00)),
                      validator: (value) {
                        if (value == "") {
                          return "Please_enter_valid_Password".tr;
                        }
                        return null;
                      },
                      isObscureText: !controller.isShowPassword.value,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      Get.toNamed(AppRoutes.forgetPasswordScreen);
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: getPadding(top: 17),
                            child: Text("msg_mot_de_passe_oubli".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtMulishRomanMedium14Indigo400
                                    .copyWith(
                                        letterSpacing:
                                            getHorizontalSize(0.30))))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onTap: () async {
                        VibrationService.vibrate();

                        if (!(_formKey.currentState!.validate())) return;
                        if (!(await controller.userLogIn())) return;

                        Get.offAllNamed(AppRoutes.notesHomePage);
                      },
                      height: 64,
                      width: 366,
                      text: "lbl_se_connecter".tr,
                      margin: getMargin(left: 7, top: 40)),
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      Get.offNamed(AppRoutes.registerScreen);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(top: 31, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "msg_vous_n_avez_pas2".tr,
                                  style: TextStyle(
                                      color: ColorConstant.indigo50,
                                      fontSize: getFontSize(14),
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: getHorizontalSize(0.26))),
                              TextSpan(
                                  text: " ",
                                  style: TextStyle(
                                      color: ColorConstant.indigo400,
                                      fontSize: getFontSize(14),
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: getHorizontalSize(0.26))),
                              TextSpan(
                                  text: "lbl_s_inscrire".tr,
                                  style: TextStyle(
                                      color: ColorConstant.indigo400,
                                      fontSize: getFontSize(14),
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: getHorizontalSize(0.26)))
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
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

  onTapImgArrowleft() {
    Get.back();
  }
}
