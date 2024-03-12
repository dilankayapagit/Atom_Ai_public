// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:atomai/app_export.dart';

import '../../../services/payment_controller.dart';
import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/web_sites_page.dart';

// ignore_for_file: must_be_immutable
class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  var controller = Get.put(PaymentController());

  var indexPage = 0;

  @override
  void initState() {
    super.initState();
    controller.getOfferings();
  }

  @override
  Widget build(BuildContext context) {
    var payModelCustom = PaymentController.payModelCustom[indexPage];
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Obx(
          () => Center(
            child: SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 30,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomImageView(
                          onTap: () {
                            VibrationService.vibrate();

                            if (FirebaseAuth.instance.currentUser == null) {
                              Get.toNamed(AppRoutes.registerOptionScreen);
                            } else {
                              Get.back();
                            }
                          },
                          imagePath:
                              "assets/icons_png/BLACK/remove circle pay.png",
                          height: 25,
                          width: 25,
                          fit: BoxFit.scaleDown,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ToggleSwitch(
                    minWidth: 100,
                    minHeight: 50,
                    cornerRadius: 30.0,
                    activeBgColors: [
                      [ColorConstant.indigo400],
                      [ColorConstant.indigo400],
                      [ColorConstant.indigo400],
                    ],
                    activeFgColor: ColorConstant.soundColor,
                    inactiveBgColor: ColorConstant.soundColor,
                    inactiveFgColor: ColorConstant.indigo400,
                    initialLabelIndex: indexPage,
                    totalSwitches: 3,
                    activeBorders: [
                      Border.all(
                        width: 4,
                        color: ColorConstant.soundColor,
                      ),
                      Border.all(
                        width: 4,
                        color: ColorConstant.soundColor,
                      ),
                      Border.all(
                        width: 4,
                        color: ColorConstant.soundColor,
                      ),
                    ],
                    labels: const ['Lite', 'Pro', 'Advanced'],
                    radiusStyle: true,
                    onToggle: (index) {
                      indexPage = index ?? 0;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: getHorizontalSize(
                      319.00,
                    ),
                    child: Text(
                      payModelCustom.titleText!.tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtMulishRomanRegular16.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 150,
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            initialPage: indexPage,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              indexPage = index;
                              setState(() {});
                            },
                          ),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgCheckmark,
                                        height: getSize(
                                          18.00,
                                        ),
                                        width: getSize(
                                          18.00,
                                        ),
                                        margin: getMargin(
                                          bottom: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            getPadding(left: 24, right: 24),
                                        child: SizedBox(
                                          width: size.width * 0.7,
                                          child: Text(
                                            payModelCustom.packages![0].tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            style: AppStyle
                                                .txtMontserratRegular18
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.64,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgCheckmark,
                                        height: getSize(
                                          18.00,
                                        ),
                                        width: getSize(
                                          18.00,
                                        ),
                                        margin: getMargin(
                                          bottom: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            getPadding(left: 24, right: 24),
                                        child: SizedBox(
                                          width: size.width * 0.7,
                                          child: Text(
                                            payModelCustom.packages![1].tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            style: AppStyle
                                                .txtMontserratRegular18
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.64,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgCheckmark,
                                        height: getSize(
                                          18.00,
                                        ),
                                        width: getSize(
                                          18.00,
                                        ),
                                        margin: getMargin(
                                          bottom: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            getPadding(left: 24, right: 24),
                                        child: SizedBox(
                                          width: size.width * 0.7,
                                          child: Text(
                                            payModelCustom.packages![2].tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            style: AppStyle
                                                .txtMontserratRegular18
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.64,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageView(
                                        svgPath: ImageConstant.imgCheckmark,
                                        height: getSize(
                                          18.00,
                                        ),
                                        width: getSize(
                                          18.00,
                                        ),
                                        margin: getMargin(
                                          bottom: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            getPadding(left: 24, right: 24),
                                        child: SizedBox(
                                          width: size.width * 0.7,
                                          child: Text(
                                            payModelCustom.packages![3].tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            maxLines: 3,
                                            style: AppStyle
                                                .txtMontserratRegular18
                                                .copyWith(
                                              letterSpacing: getHorizontalSize(
                                                0.64,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onTap: () async {
                      var result = await controller
                          .makePurchases(payModelCustom.yearIndex ?? 0);
                      if (result == false) {
                        return;
                      }
                      if (FirebaseAuth.instance.currentUser == null) {
                        Get.toNamed(AppRoutes.registerOptionScreen);
                      } else {
                        Get.back();
                      }
                    },
                    height: 64,
                    width: 366,
                    text:
                        "${"7_days_trial_then".tr} ${controller.packs[payModelCustom.yearIndex ?? 0]}/${"Yearly".tr}",
                    // text: payModelCustom.payYearly!.tr,
                    fontStyle: ButtonFontStyle.PoppinsMedium18,
                  ),
                  Padding(
                    padding: getPadding(top: 14, bottom: 14),
                    child: Text(
                      payModelCustom.paySmallDescription!.tr,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtMulishRomanRegular14Indigo50.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.26,
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      VibrationService.vibrate();

                      var result = await controller
                          .makePurchases(payModelCustom.monthIndex ?? 0);
                      if (result == false) {
                        return;
                      }
                      if (FirebaseAuth.instance.currentUser == null) {
                        Get.toNamed(AppRoutes.registerOptionScreen);
                      } else {
                        Get.back();
                      }
                    },
                    height: 64,
                    width: 366,
                    text:
                        "${"7_days_trial_then".tr} ${controller.packs[payModelCustom.monthIndex ?? 0]}/${"Monthly".tr}",
                    margin: getMargin(
                      top: 20,
                    ),
                    variant: ButtonVariant.OutlineWhiteA700,
                    fontStyle: ButtonFontStyle.PoppinsMedium18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            VibrationService.vibrate();

                            if (FirebaseAuth.instance.currentUser == null) {
                              Get.toNamed(AppRoutes.registerOptionScreen);
                            } else {
                              Get.back();
                            }
                          },
                          child: Text(
                            "msg_continuer_gratuitement".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium14Indigo400,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "⬤",
                          style: AppStyle.txtMulishRomanMedium14.copyWith(
                            letterSpacing: getHorizontalSize(0.3),
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            VibrationService.vibrate();

                            controller.restorePayment();
                          },
                          child: Text(
                            "restore_payment".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium14.copyWith(
                              letterSpacing: getHorizontalSize(0.3),
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: getPadding(
                      top: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.imgLock,
                          height: getVerticalSize(
                            13.00,
                          ),
                          width: getHorizontalSize(
                            12.00,
                          ),
                          margin: getMargin(
                            top: 2,
                            bottom: 2,
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 3,
                          ),
                          child: Text(
                            "msg_s_curis_avec_itunes".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMontserratRegular14.copyWith(
                              letterSpacing: getHorizontalSize(
                                0.64,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: getHorizontalSize(
                      370.00,
                    ),
                    margin: getMargin(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "• 1 Month ( ${controller.packs[payModelCustom.monthIndex ?? 0]} ) or 1 Year( ${controller.packs[payModelCustom.yearIndex ?? 0]} ) durations. ",
                            style: TextStyle(
                              color: ColorConstant.indigo5099,
                              fontSize: getFontSize(
                                13,
                              ),
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              letterSpacing: getHorizontalSize(
                                0.30,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: payModelCustom.description!.tr,
                            style: TextStyle(
                              color: ColorConstant.indigo5099,
                              fontSize: getFontSize(
                                13,
                              ),
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              letterSpacing: getHorizontalSize(
                                0.30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          VibrationService.vibrate();

                          Get.to(() => const WebSitesPage(
                                name: "msg_politique_de_confidentialit2",
                                url: "https://atomai.fr/privacy-policy/",
                              ));
                        },
                        child: Padding(
                          padding: getPadding(
                            top: 20,
                          ),
                          child: Text(
                            "lbl_privacy_policy".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium14Indigo400
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          VibrationService.vibrate();

                          Get.to(() => const WebSitesPage(
                                name: "msg_conditions_de_service_end_eula",
                                url:
                                    "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
                              ));
                        },
                        child: Padding(
                          padding: getPadding(
                            top: 20,
                          ),
                          child: Text(
                            "msg_conditions_de_service_end_eula".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium14Indigo400
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
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
