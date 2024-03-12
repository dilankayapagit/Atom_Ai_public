import 'package:atomai/models/user_custom_model.dart';

import '../../../services/user_data_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/app_bar/appbar_subtitle_2.dart';

import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telephone = TextEditingController();
  var controller = Get.put(UserDataController());
  @override
  void initState() {
    super.initState();
    startup();
  }

  startup() async {
    controller.getUserData();
    name = TextEditingController(
        text: controller.userCustomModel.value.name ?? "");
    email = TextEditingController(
        text: controller.userCustomModel.value.email ?? "");
    telephone = TextEditingController(
        text: controller.userCustomModel.value.phoneNumber ?? "");
    setState(() {});
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
                  onTap: onTapArrowleft5),
              title: AppbarSubtitle2(
                  text: "msg_param_tres_du_profil".tr,
                  margin: getMargin(left: 12))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        VibrationService.vibrate();

                        controller.changeProfilePic("msg_modifier_l_image");
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              imagePath:
                                  controller.userCustomModel.value.icon ??
                                      ImageConstant.img1,
                              height: getSize(
                                100.00,
                              ),
                              width: getSize(
                                100.00,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 60,
                                left: 50,
                              ),
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: ColorConstant.floatingActionBtnColor,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.camera,
                                    height: getSize(
                                      20.00,
                                    ),
                                    width: getSize(
                                      20.00,
                                    ),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: getPadding(left: 7, top: 20),
                        child: Text("lbl_nom_pr_nom".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium16.copyWith(
                                letterSpacing: getHorizontalSize(0.30)))),
                    CustomTextFormField(
                      width: 366,
                      focusNode: FocusNode(),
                      controller: name,
                      hintText: "lbl_nom_pr_nom".tr,
                      margin: getMargin(left: 7, top: 7),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Padding(
                        padding: getPadding(left: 7, top: 20),
                        child: Text("lbl_email".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium16.copyWith(
                                letterSpacing: getHorizontalSize(0.30)))),
                    CustomTextFormField(
                      readOnly: true,
                      width: 366,
                      focusNode: FocusNode(),
                      controller: email,
                      hintText: "lbl_email".tr,
                      margin: getMargin(left: 7, top: 7),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Padding(
                        padding: getPadding(left: 7, top: 20),
                        child: Text("lbl_t_l_phone".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium16.copyWith(
                                letterSpacing: getHorizontalSize(0.30)))),
                    CustomTextFormField(
                      width: 366,
                      focusNode: FocusNode(),
                      controller: telephone,
                      hintText: "lbl_t_l_phone".tr,
                      margin: getMargin(left: 7, top: 7),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Padding(
                        padding: getPadding(left: 7, top: 20),
                        child: Text("lbl_mot_de_passe".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsMedium16.copyWith(
                                letterSpacing: getHorizontalSize(0.30)))),
                    GestureDetector(
                      onTap: () {
                        VibrationService.vibrate();

                        Get.toNamed(AppRoutes.changePassScreen);
                      },
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextFormField(
                            readOnly: true,
                            width: 366,
                            focusNode: FocusNode(),
                            controller: TextEditingController(text: "********"),
                            hintText: "lbl_mot_de_passe".tr,
                            margin: getMargin(left: 7, top: 7),
                            textInputType: TextInputType.visiblePassword,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, top: 7),
                            child: CustomImageView(
                              imagePath: ImageConstant.rightArrow,
                              height: getSize(
                                20.00,
                              ),
                              width: getSize(
                                20.00,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        onTap: () {
                          VibrationService.vibrate();
                          controller.setUserDate(
                            UserCustomModel(
                                name: name.text, phoneNumber: telephone.text),
                          );
                          Get.back();
                        },
                        height: 56,
                        width: 350,
                        text: "Save".tr,
                        variant: ButtonVariant.OutlineGray90001,
                        shape: ButtonShape.CircleBorder28,
                        fontStyle: ButtonFontStyle.MulishSemiBold16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        VibrationService.vibrate();
                        controller.dialogDeleteAccount();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "msg_Supprimer_le_compte".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapArrowleft5() {
    Get.back();
  }
}
