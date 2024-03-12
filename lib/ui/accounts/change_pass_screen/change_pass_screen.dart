import '../../../services/vibtaion_service.dart';
import 'controller/change_pass_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var controller = Get.put(ChangePassController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                margin: getMargin(left: 24, top: 15, bottom: 16),
                onTap: onTapArrowleft6),
            title: Padding(
                padding: getPadding(left: 12),
                child: Text("msg_modifier_le_mot_pw_change".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtMulishRomanMedium16Indigo504c))),
        body: Form(
          key: _formKey,
          child: Container(
              padding: getPadding(left: 25, top: 42, right: 25, bottom: 42),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("msg_modifier_le_mot_pw_change".tr,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtMontserratAlternatesBold22),
                    CustomTextFormField(
                        width: 400,
                        focusNode: FocusNode(),
                        controller: controller.oldPasswordController,
                        hintText: "msg_mot_de_passe_actuel".tr,
                        margin: getMargin(top: 32),
                        shape: TextFormFieldShape.RoundedBorder12,
                        padding: TextFormFieldPadding.PaddingT19,
                        fontStyle: TextFormFieldFontStyle.MulishRomanRegular16,
                        suffix: Container(
                            margin: getMargin(
                                left: 30, top: 19, right: 22, bottom: 19),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgIcon24Lock)),
                        validator: (value) {
                          if (value == "") {
                            return "Please_enter_valid_Password".tr;
                          }
                          return null;
                        },
                        suffixConstraints:
                            BoxConstraints(maxHeight: getVerticalSize(62.00))),
                    CustomTextFormField(
                        width: 400,
                        focusNode: FocusNode(),
                        controller: controller.newPasswordOneController,
                        hintText: "msg_entrez_le_nouveau".tr,
                        margin: getMargin(top: 32),
                        shape: TextFormFieldShape.RoundedBorder12,
                        padding: TextFormFieldPadding.PaddingT19,
                        fontStyle: TextFormFieldFontStyle.MulishRomanRegular16,
                        suffix: Container(
                            margin: getMargin(
                                left: 30, top: 19, right: 22, bottom: 19),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgIcon24Lock)),
                        validator: (value) {
                          if (value == "") {
                            return "Please_enter_valid_Password".tr;
                          }
                          return null;
                        },
                        suffixConstraints:
                            BoxConstraints(maxHeight: getVerticalSize(62.00))),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: CustomButton(
                          onTap: () {
                            VibrationService.vibrate();

                            if (!(_formKey.currentState!.validate())) return;

                            controller.changePassword();
                          },
                          height: 64,
                          width: 326,
                          text: "lbl_confirmer".tr,
                          padding: ButtonPadding.PaddingAll22,
                          fontStyle: ButtonFontStyle.MulishRomanMedium14),
                    )
                  ])),
        ),
      ),
    );
  }

  onTapArrowleft6() {
    Get.back();
  }
}
