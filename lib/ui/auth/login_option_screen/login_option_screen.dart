import 'dart:io';

import 'package:flutter/gestures.dart';

import '../../../services/vibtaion_service.dart';
import 'controller/login_option_controller.dart';
import 'package:atomai/app_export.dart';

class LoginOptionScreen extends GetWidget<LoginOptionController> {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.gray900,
        body: Container(
          width: size.width,
          padding: getPadding(
            left: 24,
            top: 30,
            right: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getVerticalSize(
                  104.00,
                ),
                width: getHorizontalSize(
                  338.00,
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
              Container(
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
                  style: AppStyle.txtMulishRomanRegular14Indigo5099.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.26,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
              ),
              GestureDetector(
                onTap: () {
                  VibrationService.vibrate();

                  Get.toNamed(AppRoutes.loginScreen);
                },
                child: Container(
                  padding: getPadding(
                    left: 16,
                    top: 15,
                    right: 16,
                    bottom: 15,
                  ),
                  decoration: AppDecoration.outlineIndigo50.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder32,
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: getMargin(
                          top: 2,
                        ),
                        padding: getPadding(
                          left: 8,
                          top: 10,
                          right: 8,
                          bottom: 10,
                        ),
                        decoration: AppDecoration.fillIndigo50.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: const EdgeInsets.all(0),
                              color: ColorConstant.indigo400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.roundedBorder2,
                              ),
                              child: Container(
                                height: getVerticalSize(
                                  12.00,
                                ),
                                width: getHorizontalSize(
                                  16.00,
                                ),
                                padding: getPadding(
                                  all: 1,
                                ),
                                decoration:
                                    AppDecoration.fillIndigo400.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder2,
                                ),
                                child: Stack(
                                  children: [
                                    CustomImageView(
                                      svgPath: ImageConstant.imgArrowdown,
                                      height: getVerticalSize(
                                        5.00,
                                      ),
                                      width: getHorizontalSize(
                                        11.00,
                                      ),
                                      alignment: Alignment.topCenter,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 45,
                          top: 6,
                          // right: 82,
                          bottom: 6,
                        ),
                        child: Text(
                          "msg_connexion_avec_l_email".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                            color: Colors.white,
                            letterSpacing: getHorizontalSize(
                              0.30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (Platform.isIOS)
                GestureDetector(
                  onTap: () async {
                    VibrationService.vibrate();

                    controller.signInWithApple();
                  },
                  child: Container(
                    margin: getMargin(top: 16),
                    padding: getPadding(all: 16),
                    decoration: AppDecoration.outlineBluegray100.copyWith(
                        borderRadius: BorderRadiusStyle.circleBorder32),
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          margin: const EdgeInsets.all(0),
                          color: ColorConstant.whiteA700,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.blueGray100,
                                  width: getHorizontalSize(1.00)),
                              borderRadius: BorderRadiusStyle.circleBorder16),
                          child: Container(
                            height: getSize(32.00),
                            width: getSize(32.00),
                            //padding: getPadding(all: 6),
                            decoration:
                                AppDecoration.outlineBluegray1001.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder16,
                            ),
                            child: Stack(
                              children: [
                                CustomImageView(
                                  svgPath: ImageConstant.appleLogo,
                                  height: getSize(25.00),
                                  width: getSize(25.00),
                                  color: Colors.black,
                                  //fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                              left: 45, top: 7, right: 86, bottom: 3),
                          child: Text(
                            "msg_connectez_vous_avec_apple".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                              color: ColorConstant.blueGray800,
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // GestureDetector(
              //   onTap: () {
              //     controller.signInWithFacebook();
              //   },
              //   child: Container(
              //     margin: getMargin(
              //       top: 16,
              //     ),
              //     padding: getPadding(
              //       all: 16,
              //     ),
              //     decoration: AppDecoration.fillLightblueA700.copyWith(
              //       borderRadius: BorderRadiusStyle.circleBorder32,
              //     ),
              //     child: Row(
              //       children: [
              //         CustomImageView(
              //           svgPath: ImageConstant.imgPlus,
              //           height: getSize(
              //             32.00,
              //           ),
              //           width: getSize(
              //             32.00,
              //           ),
              //         ),
              //         Padding(
              //           padding: getPadding(
              //             left: 45,
              //             top: 6,
              //             right: 49,
              //             bottom: 4,
              //           ),
              //           child: Text(
              //             "msg_connectez_vous_avec".tr,
              //             overflow: TextOverflow.ellipsis,
              //             textAlign: TextAlign.left,
              //             style: AppStyle.txtMulishRomanSemiBold16.copyWith(
              //               color: Colors.white,
              //               letterSpacing: getHorizontalSize(
              //                 0.30,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () async {
                  VibrationService.vibrate();

                  controller.signInWithGoogle();
                },
                child: Container(
                  margin: getMargin(top: 16),
                  padding: getPadding(all: 16),
                  decoration: AppDecoration.outlineBluegray100
                      .copyWith(borderRadius: BorderRadiusStyle.circleBorder32),
                  child: Row(
                    children: [
                      Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 0,
                          margin: const EdgeInsets.all(0),
                          color: ColorConstant.whiteA700,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.blueGray100,
                                  width: getHorizontalSize(1.00)),
                              borderRadius: BorderRadiusStyle.circleBorder16),
                          child: Container(
                              height: getSize(32.00),
                              width: getSize(32.00),
                              padding: getPadding(all: 6),
                              decoration: AppDecoration.outlineBluegray1001
                                  .copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.circleBorder16),
                              child: Stack(children: [
                                CustomImageView(
                                  svgPath: ImageConstant.imgGoogle,
                                  height: getSize(19.00),
                                  width: getSize(19.00),
                                  alignment: Alignment.center,
                                )
                              ]))),
                      Padding(
                        padding:
                            getPadding(left: 45, top: 7, right: 60, bottom: 3),
                        child: Text(
                          "msg_connectez_vous_avec2".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                            color: ColorConstant.blueGray800,
                            letterSpacing: getHorizontalSize(0.30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 34,
                  bottom: 3,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "msg_vous_n_avez_pas2".tr,
                        style: TextStyle(
                          color: ColorConstant.indigo50,
                          fontSize: getFontSize(
                            16,
                          ),
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                          letterSpacing: getHorizontalSize(
                            0.26,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "  ",
                        style: TextStyle(
                          color: ColorConstant.indigo400,
                          fontSize: getFontSize(
                            16,
                          ),
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                          letterSpacing: getHorizontalSize(
                            0.26,
                          ),
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            VibrationService.vibrate();

                            Get.toNamed(AppRoutes.registerOptionScreen);
                          },
                        text: "lbl_s_inscrire".tr,
                        style: TextStyle(
                          color: ColorConstant.indigo400,
                          fontSize: getFontSize(
                            20,
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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  VibrationService.vibrate();

                  controller.signInWithAnon();
                },
                child: Text(
                  "Skip".tr,
                  style: TextStyle(
                    color: ColorConstant.red900,
                    fontSize: getFontSize(
                      20,
                    ),
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    letterSpacing: getHorizontalSize(
                      0.26,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
