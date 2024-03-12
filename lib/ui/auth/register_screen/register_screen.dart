import '../../../services/vibtaion_service.dart';
import 'controller/register_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';
import 'package:form_validator/form_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var controller = Get.put(RegisterController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailValidator = ValidationBuilder().email().maxLength(50).build();
  final phoneValidator = ValidationBuilder().phone().maxLength(20).build();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
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
        ),
        backgroundColor: ColorConstant.gray900,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Form(
            key: _formKey,
            child: Container(
              width: size.width,
              padding: getPadding(
                left: 21,
                top: 20,
                right: 21,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(
                        104.00,
                      ),
                      width: getHorizontalSize(
                        338.00,
                      ),
                      margin: getMargin(
                        top: 15,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgDesignsanstitre,
                            height: getSize(
                              88.00,
                            ),
                            width: getSize(
                              88.00,
                            ),
                            alignment: Alignment.centerLeft,
                            margin: getMargin(
                              left: 14,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgLogoatomai1,
                            height: getVerticalSize(
                              104.00,
                            ),
                            width: getHorizontalSize(
                              338.00,
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: getHorizontalSize(
                        235.00,
                      ),
                      margin: getMargin(
                        top: 18,
                      ),
                      child: Text(
                        "msg_login_now_to_access".tr,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style:
                            AppStyle.txtMulishRomanRegular14Indigo50.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 3,
                      top: 28,
                    ),
                    child: Text(
                      "lbl_full_name".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.30,
                        ),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    width: 366,
                    focusNode: FocusNode(),
                    controller: controller.fullNameController,
                    hintText: "lbl_full_name".tr,
                    margin: getMargin(
                      left: 3,
                      top: 6,
                    ),
                    onChanged: (st) {},
                    validator: (value) {
                      if (value == "") {
                        return "Please_enter_valid_User_Name".tr;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: getPadding(
                      left: 3,
                      top: 16,
                    ),
                    child: Text(
                      "lbl_email".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.30,
                        ),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    width: 366,
                    focusNode: FocusNode(),
                    controller: controller.emailTwoController,
                    hintText: "lbl_email".tr,
                    margin: getMargin(
                      left: 3,
                      top: 7,
                    ),
                    textInputType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  Padding(
                    padding: getPadding(
                      left: 3,
                      top: 17,
                    ),
                    child: Text(
                      "lbl_t_l_phone".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.30,
                        ),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    validator: phoneValidator,
                    width: 366,
                    textInputType: TextInputType.phone,
                    focusNode: FocusNode(),
                    controller: controller.phoneController,
                    hintText: "lbl_t_l_phone".tr,
                    margin: getMargin(
                      left: 3,
                      top: 5,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 3,
                      top: 18,
                    ),
                    child: Text(
                      "lbl_mot_de_passe".tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.30,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      width: 366,
                      focusNode: FocusNode(),
                      controller: controller.passwordOneController,
                      hintText: "lbl".tr,
                      margin: getMargin(
                        left: 3,
                        top: 4,
                      ),
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
                            left: 30,
                            top: 20,
                            right: 16,
                            bottom: 20,
                          ),
                          child: CustomImageView(
                            svgPath: controller.isShowPassword.value
                                ? ImageConstant.imgDashboard
                                : ImageConstant.imgDashboard,
                          ),
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: getVerticalSize(
                          64.00,
                        ),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "Please_enter_valid_Password".tr;
                        }
                        return null;
                      },
                      isObscureText: !controller.isShowPassword.value,
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (!(_formKey.currentState!.validate())) return;
                      controller.register();
                    },
                    height: 64,
                    width: 366,
                    text: "lbl_s_inscrire".tr,
                    margin: getMargin(
                      left: 3,
                      top: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          top: 34,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "msg_vous_avez_un_compte2".tr,
                                style: TextStyle(
                                  color: ColorConstant.indigo50,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: getHorizontalSize(
                                    0.26,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: " ".tr,
                                style: TextStyle(
                                  color: ColorConstant.indigo50,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: getHorizontalSize(
                                    0.26,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: "lbl_se_connecter2".tr,
                                style: TextStyle(
                                  color: ColorConstant.indigo400,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: getHorizontalSize(
                                    0.26,
                                  ),
                                ),
                              ),
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
}
