import 'package:form_validator/form_validator.dart';

import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

import 'web_login_controller.dart';

// ignore_for_file: must_be_immutable
class WebLoginPage extends StatefulWidget {
  const WebLoginPage({super.key});

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  var controller = Get.put(WebLoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValidator = ValidationBuilder().email().maxLength(50).build();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: 500,
                // height: 300,
                padding: getPadding(left: 17, top: 40, right: 17, bottom: 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLogoatomai1,
                      height: 100,
                      width: 200,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: getHorizontalSize(235.00),
                        margin: getMargin(top: 18),
                        child: Text(
                          "msg_login_now_to_access".tr,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: AppStyle.txtMulishRomanRegular14Indigo5099
                              .copyWith(
                            letterSpacing: getHorizontalSize(0.26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 7, top: 99),
                      child: Text(
                        "lbl_email".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsMedium16.copyWith(
                          letterSpacing: getHorizontalSize(0.30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(0.30),
                      ),
                      focusNode: FocusNode(),
                      validator: emailValidator,
                      controller: controller.emailOneController,
                      decoration: InputDecoration(
                        hintText: "lbl_email".tr,
                        fillColor: _setFillColor(),
                        border: OutlineInputBorder(
                          borderRadius: _setOutlineBorderRadius(),
                          borderSide: BorderSide(
                            color: ColorConstant.blueGray100,
                          ),
                        ),
                        filled: true,
                        enabledBorder: _setBorderStyle(),
                        focusedBorder: _setBorderStyle(),
                        disabledBorder: _setBorderStyle(),
                        //alignLabelWithHint: true,
                        contentPadding: getPadding(
                          left: 19,
                          top: 19,
                          bottom: 19,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConstant.indigo5099,
                          fontSize: getFontSize(
                            20,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        isDense: true,
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 7, top: 18),
                      child: Text(
                        "lbl_mot_de_passe".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsMedium16.copyWith(
                          letterSpacing: getHorizontalSize(0.30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: FocusNode(),
                      style: AppStyle.txtPoppinsMedium16.copyWith(
                        letterSpacing: getHorizontalSize(0.30),
                      ),
                      controller: controller.passwordOneController,
                      decoration: InputDecoration(
                        hintText: "lbl".tr,
                        fillColor: _setFillColor(),
                        border: OutlineInputBorder(
                          borderRadius: _setOutlineBorderRadius(),
                          borderSide: BorderSide(
                            color: ColorConstant.blueGray100,
                          ),
                        ),
                        filled: true,
                        enabledBorder: _setBorderStyle(),
                        focusedBorder: _setBorderStyle(),
                        disabledBorder: _setBorderStyle(),
                        //alignLabelWithHint: true,
                        contentPadding: getPadding(
                          left: 19,
                          top: 19,
                          bottom: 19,
                        ),
                        hintStyle: TextStyle(
                          color: ColorConstant.indigo5099,
                          fontSize: getFontSize(
                            20,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onTap: () async {
                          controller.userLogIn();
                        },
                        height: 64,
                        width: 366,
                        text: "lbl_se_connecter".tr,
                        margin: getMargin(left: 7, top: 40)),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _setFillColor() {
    return ColorConstant.blueGray8004c;
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(
      getHorizontalSize(
        15.00,
      ),
    );
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: _setOutlineBorderRadius(),
      borderSide: BorderSide.none,
    );
  }

  onTapImgArrowleft() {
    Get.back();
  }
}
