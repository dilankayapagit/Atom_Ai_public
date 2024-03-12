import '../../../services/payment_controller.dart';
import '../../../services/user_data_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/app_bar/appbar_subtitle_2.dart';

import '../../../services/vibtaion_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  var controller = Get.put(UserDataController());
  var paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
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
            title: AppbarSubtitle2(
                text: "lbl_abonnement".tr, margin: getMargin(left: 12)),
          ),
          backgroundColor: ColorConstant.gray900,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: getHorizontalSize(375.00),
                padding: getPadding(top: 22, bottom: 22),
                decoration: AppDecoration.fillBluegray8004c
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: getPadding(left: 24, top: 23),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: controller.userCustomModel.value.icon ??
                                ImageConstant.autoGroup5xwk,
                            height: getSize(
                              56.00,
                            ),
                            width: getSize(
                              56.00,
                            ),
                          ),
                          Padding(
                            padding: getPadding(left: 12, top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    controller.user.value!.displayName ??
                                        controller.user.value!.email!
                                            .split("@")[0],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtMontserratAlternatesSemiBold24
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.24))),
                                Padding(
                                  padding: getPadding(top: 5),
                                  child: Text(
                                    controller.user.value!.email ?? "No Email",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtMulishRomanRegular14Indigo400
                                        .copyWith(
                                      letterSpacing: getHorizontalSize(0.50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    paymentController.packageNew.value.payId == "Free"
                        ? GestureDetector(
                            onTap: () {
                              VibrationService.vibrate();

                              Get.toNamed(AppRoutes.premiumPage);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: getMargin(left: 24, top: 23, right: 24),
                                padding: getPadding(
                                    left: 16, top: 12, right: 16, bottom: 12),
                                decoration: AppDecoration.fillIndigo400
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("AtomAi PRO".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtMulishRomanMedium14Gray10001
                                                .copyWith()),
                                        Padding(
                                          padding: getPadding(top: 10),
                                          child: Text("7 day free trial",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMulishRomanRegular12
                                                  .copyWith()),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: getSize(24.00),
                                      width: getSize(24.00),
                                      margin: getMargin(
                                          left: 12, top: 19, bottom: 19),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // Get.toNamed(AppRoutes.premiumPage);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: getMargin(left: 24, top: 23, right: 24),
                                padding: getPadding(
                                    left: 16, top: 12, right: 16, bottom: 12),
                                decoration: AppDecoration.fillIndigo400
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("lbl_abonnement".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtMulishRomanMedium14Gray10001),
                                        Padding(
                                          padding: getPadding(top: 9),
                                          child: Container(
                                            height: getVerticalSize(8.00),
                                            width: getHorizontalSize(259.00),
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.blueGray8004c,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getHorizontalSize(
                                                            4.00))),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getHorizontalSize(4.00)),
                                              child: LinearProgressIndicator(
                                                value: ((controller
                                                            .userCustomModel
                                                            .value
                                                            .wordCount ??
                                                        0) /
                                                    paymentController
                                                        .package.value.maxTxt!),
                                                backgroundColor:
                                                    ColorConstant.blueGray8004c,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        ColorConstant
                                                            .whiteA700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(top: 10),
                                          child: Text(
                                              "${controller.userCustomModel.value.wordCount ?? 0} ${"words".tr} / ${paymentController.packageNew.value.maxTxt.toString()} ${"words".tr}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMulishRomanRegular12),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: getSize(24.00),
                                      width: getSize(24.00),
                                      margin: getMargin(
                                        left: 12,
                                        top: 19,
                                        bottom: 19,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                width: getHorizontalSize(400.00),
                margin: getMargin(left: 24, top: 23, right: 24),
                padding: getPadding(all: 23),
                decoration: AppDecoration.fillBluegray8004c
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: getPadding(top: 2),
                      child: Row(
                        children: [
                          Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: getMargin(top: 1),
                              color: ColorConstant.gray900,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder12),
                              child: Container(
                                  height: getSize(79.00),
                                  width: getSize(79.00),
                                  decoration: AppDecoration.fillGray900
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder12),
                                  child: Stack(children: [
                                    CustomImageView(
                                        imagePath:
                                            ImageConstant.imgLogoatomai179x78,
                                        height: getVerticalSize(79.00),
                                        width: getHorizontalSize(78.00),
                                        alignment: Alignment.center)
                                  ]))),
                          Padding(
                            padding: getPadding(left: 12, bottom: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("lbl_abonnement2".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtMontserratAlternatesSemiBold24
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.24))),
                                Padding(
                                    padding: getPadding(top: 4),
                                    child: Text(
                                        paymentController
                                            .package.value.payName!.tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtMulishRomanRegular16WhiteA700
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.50)))),
                                GestureDetector(
                                  onTap: () {
                                    VibrationService.vibrate();

                                    Get.toNamed(AppRoutes.premiumPage);
                                  },
                                  child: Padding(
                                    padding: getPadding(top: 8),
                                    child: Row(
                                      children: [
                                        Text("msg_afficher_tous_les".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtMontserratRegular12
                                                .copyWith(
                                                    letterSpacing:
                                                        getHorizontalSize(
                                                            0.64))),
                                        CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowrightIndigo400,
                                            height: getSize(13.00),
                                            width: getSize(13.00),
                                            margin: getMargin(top: 1))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (paymentController.customerInfo.isNotEmpty &&
                        paymentController
                                .customerInfo[0].latestExpirationDate !=
                            null)
                      Padding(
                        padding: getPadding(top: 27),
                        child: Row(
                          children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgCalendar,
                                height: getVerticalSize(22.00),
                                width: getHorizontalSize(25.00)),
                            Padding(
                              padding: getPadding(left: 14, bottom: 4),
                              child: Text(
                                "${"Renouveler".tr} ${paymentController.customerInfo[0].latestExpirationDate!.split("T")[0]}"
                                    .tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtMontserratRegular14.copyWith(
                                  letterSpacing: getHorizontalSize(0.64),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // if (paymentController.customerInfo[0].latestExpirationDate !=
                    //     null)
                    //   Padding(
                    //     padding: getPadding(top: 25),
                    //     child: Row(
                    //       children: [
                    //         CustomImageView(
                    //             svgPath: ImageConstant.imgCreditcardregular,
                    //             height: getVerticalSize(23.00),
                    //             width: getHorizontalSize(25.00)),
                    //         Padding(
                    //           padding: getPadding(left: 14, top: 2, bottom: 2),
                    //           child: Text(
                    //             "lbl_7_99_par_mois".tr,
                    //             overflow: TextOverflow.ellipsis,
                    //             textAlign: TextAlign.left,
                    //             style: AppStyle.txtMontserratRegular14.copyWith(
                    //               letterSpacing: getHorizontalSize(0.64),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                ),
              ),
              // Spacer(),
              // Container(
              //   width: getHorizontalSize(327.00),
              //   margin: getMargin(bottom: 60),
              //   padding: getPadding(left: 30, top: 15, right: 77, bottom: 15),
              //   decoration: AppDecoration.txtFillBluegray80099
              //       .copyWith(borderRadius: BorderRadiusStyle.txtRoundedBorder12),
              //   child: Text("msg_r_silier_l_abonnement".tr,
              //       overflow: TextOverflow.ellipsis,
              //       textAlign: TextAlign.center,
              //       style: AppStyle.txtMulishRomanMedium16),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  onTapArrowleft1() {
    Get.back();
  }
}
