import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';
import 'controller/forget_password_succes_reset_controller.dart';
import 'package:atomai/app_export.dart';

class ForgetPasswordSuccesResetScreen
    extends GetWidget<ForgetPasswordSuccesResetController> {
  const ForgetPasswordSuccesResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            padding: getPadding(
              top: 76,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: getHorizontalSize(
                    230.00,
                  ),
                  child: Text(
                    "msg_mot_de_passe_chang".tr,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: AppStyle.txtMontserratAlternatesMedium32.copyWith(
                      letterSpacing: getHorizontalSize(
                        0.30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: getVerticalSize(
                      353.00,
                    ),
                    width: getHorizontalSize(
                      390.00,
                    ),
                    margin: getMargin(
                      top: 35,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.img62,
                          height: getVerticalSize(
                            180.00,
                          ),
                          width: getHorizontalSize(
                            174.00,
                          ),
                          alignment: Alignment.bottomLeft,
                          margin: getMargin(
                            bottom: 8,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.img2133x133,
                          height: getSize(
                            133.00,
                          ),
                          width: getSize(
                            133.00,
                          ),
                          alignment: Alignment.bottomRight,
                          margin: getMargin(
                            bottom: 79,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.img3203x199,
                          height: getVerticalSize(
                            203.00,
                          ),
                          width: getHorizontalSize(
                            199.00,
                          ),
                          alignment: Alignment.topLeft,
                          margin: getMargin(
                            left: 7,
                            top: 3,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.img53,
                          height: getSize(
                            128.00,
                          ),
                          width: getSize(
                            128.00,
                          ),
                          alignment: Alignment.topRight,
                          margin: getMargin(
                            top: 12,
                            right: 17,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: getSize(
                              353.00,
                            ),
                            width: getSize(
                              353.00,
                            ),
                            margin: getMargin(
                              right: 6,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgPlandetravail353x353,
                                  height: getSize(
                                    353.00,
                                  ),
                                  width: getSize(
                                    353.00,
                                  ),
                                  alignment: Alignment.center,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 20,
                                      right: 26,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          margin: getMargin(
                                            left: 75,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          margin: getMargin(
                                            top: 28,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                          margin: getMargin(
                                            top: 45,
                                            right: 15,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          margin: getMargin(
                                            left: 17,
                                            top: 34,
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CustomImageView(
                                                imagePath: ImageConstant.img19,
                                                height: getVerticalSize(
                                                  10.00,
                                                ),
                                                width: getHorizontalSize(
                                                  7.00,
                                                ),
                                                margin: getMargin(
                                                  bottom: 5,
                                                ),
                                              ),
                                              CustomImageView(
                                                imagePath: ImageConstant.img19,
                                                height: getVerticalSize(
                                                  10.00,
                                                ),
                                                width: getHorizontalSize(
                                                  7.00,
                                                ),
                                                margin: getMargin(
                                                  left: 72,
                                                  top: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.img19,
                                          height: getVerticalSize(
                                            10.00,
                                          ),
                                          width: getHorizontalSize(
                                            7.00,
                                          ),
                                          margin: getMargin(
                                            top: 35,
                                            right: 49,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () {
                    VibrationService.vibrate();

                    Get.back();
                  },
                  height: 64,
                  width: 366,
                  text: "lbl_se_connecter".tr,
                  margin: getMargin(
                    top: 41,
                    bottom: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
