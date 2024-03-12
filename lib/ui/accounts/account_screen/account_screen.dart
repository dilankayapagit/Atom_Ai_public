import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../services/payment_controller.dart';
import '../../../services/user_data_controller.dart';
import '../../../services/vibtaion_service.dart';
import '../../../widgets/web_sites_page.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/app_bar/appbar_subtitle_2.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var controller = Get.put(UserDataController());
  var paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    controller.getUserData();
    paymentController.getSubscribeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          // systemUiOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: ColorConstant.blueGray8004c,
          //   statusBarIconBrightness: Brightness.dark,
          //   statusBarBrightness: Brightness.dark,
          // ),
          colour: ColorConstant.blueGray8004c,
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
              text: "lbl_notes".tr, margin: getMargin(left: 12)),
        ),
        backgroundColor: ColorConstant.gray900,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  padding: getPadding(top: 22, bottom: 22),
                  decoration: AppDecoration.fillBluegray8004c
                      .copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder24,
                      )
                      .copyWith(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: getPadding(left: 24, top: 23),
                          child: Row(children: [
                            CustomImageView(
                              imagePath:
                                  controller.userCustomModel.value.icon ??
                                      ImageConstant.autoGroup5xwk,
                              height: getSize(
                                82.00,
                              ),
                              width: getSize(
                                82.00,
                              ),
                            ),
                            Padding(
                                padding: getPadding(left: 12, top: 2),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          (controller.user.value!.displayName ??
                                                  controller
                                                      .user.value!.email ??
                                                  "Anon")
                                              .split("@")[0],
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtMontserratAlternatesSemiBold24
                                              .copyWith(
                                                  letterSpacing:
                                                      getHorizontalSize(0.24))),
                                      if (!FirebaseAuth
                                          .instance.currentUser!.isAnonymous)
                                        Padding(
                                            padding: getPadding(top: 5),
                                            child: Text(
                                                controller.user.value!.email ??
                                                    "No Email",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtMulishRomanRegular14Indigo400
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                0.50)))),
                                      if (FirebaseAuth
                                          .instance.currentUser!.isAnonymous)
                                        GestureDetector(
                                          onTap: () {
                                            VibrationService.vibrate();

                                            Get.toNamed(
                                                AppRoutes.registerOptionScreen);
                                          },
                                          child: Padding(
                                              padding: getPadding(top: 5),
                                              child: Text(
                                                  controller
                                                          .user.value!.email ??
                                                      "Please_sign_in_or_sign_up"
                                                          .tr
                                                          .replaceAll(
                                                              "Please ", ""),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtMulishRomanRegular14Indigo400
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.50)))),
                                        )
                                    ]))
                          ])),
                      paymentController.packageNew.value.payId == "Free"
                          ? GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                Get.toNamed(AppRoutes.premiumPage);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin:
                                      getMargin(left: 24, top: 23, right: 24),
                                  padding: getPadding(
                                      left: 16, top: 12, right: 16, bottom: 12),
                                  decoration: AppDecoration.fillIndigo400
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("AtomAi_premium".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtMulishRomanMedium14Gray10001
                                                  .copyWith()),
                                          SizedBox(
                                            width: size.width * 0.4,
                                            child: Padding(
                                              padding: getPadding(top: 10),
                                              child: Text(
                                                  "Essai_gratuit_de_7_jours".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtMulishRomanRegular12
                                                      .copyWith()),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.3),
                                        child: CustomImageView(
                                          svgPath: ImageConstant
                                              .imgArrowrightWhiteA700,
                                          height: getSize(24.00),
                                          width: getSize(24.00),
                                          margin: getMargin(
                                              left: 12, top: 19, bottom: 19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                Get.toNamed(AppRoutes.subscriptionScreen);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin:
                                      getMargin(left: 24, top: 23, right: 24),
                                  padding: getPadding(
                                      left: 16, top: 12, right: 16, bottom: 12),
                                  decoration: AppDecoration.fillIndigo400
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder20),
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
                                                  color: ColorConstant
                                                      .blueGray8004c,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          getHorizontalSize(
                                                              4.00))),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        getHorizontalSize(
                                                            4.00)),
                                                child: LinearProgressIndicator(
                                                  value: ((controller
                                                              .userCustomModel
                                                              .value
                                                              .wordCount ??
                                                          0) /
                                                      paymentController.package
                                                          .value.maxTxt!),
                                                  backgroundColor: ColorConstant
                                                      .blueGray8004c,
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
                                      CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightWhiteA700,
                                        height: getSize(24.00),
                                        width: getSize(24.00),
                                        margin: getMargin(
                                            left: 12, top: 19, bottom: 19),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: getPadding(left: 24, top: 29),
                        child: Text("lbl_param_tres".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium16WhiteA700
                                .copyWith(
                                    letterSpacing: getHorizontalSize(1.00))))),
                Padding(
                  padding: getPadding(left: 24, top: 29, right: 24),
                  child: Container(
                      decoration: AppDecoration.fillBluegray8004c.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder12),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                Get.toNamed(AppRoutes.profileSettingScreen);
                              },
                              child: Container(
                                  padding: getPadding(
                                      left: 12, top: 15, right: 12, bottom: 15),
                                  decoration:
                                      AppDecoration.fillBluegray8004c.copyWith(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 3),
                                            child: Text(
                                                "msg_param_tres_du_profil".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtMulishRomanMedium16Indigo5099)),
                                        CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowrightWhiteA700,
                                            height: getSize(24.00),
                                            width: getSize(24.00))
                                      ])),
                            ),
                            GestureDetector(
                              onTap: () {
                                VibrationService.vibrate();

                                Get.toNamed(AppRoutes.languageScreen);
                              },
                              child: Container(
                                  margin: getMargin(top: 4),
                                  padding: getPadding(
                                      left: 12, top: 15, right: 12, bottom: 15),
                                  decoration:
                                      AppDecoration.fillBluegray8004c.copyWith(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: getPadding(top: 4),
                                            child: Text("lbl_langue".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtMulishRomanMedium16Indigo5099)),
                                        CustomImageView(
                                            svgPath: ImageConstant
                                                .imgArrowrightWhiteA700,
                                            height: getSize(24.00),
                                            width: getSize(24.00))
                                      ])),
                            )
                          ])),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: getPadding(left: 24, top: 19),
                        child: Text("msg_information_g_n_rale".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRomanMedium16WhiteA700
                                .copyWith(
                                    letterSpacing: getHorizontalSize(1.00))))),
                Padding(
                  padding: getPadding(left: 24, top: 29, right: 24),
                  child: Container(
                    // width: getHorizontalSize(327.00),
                    // margin: getMargin(left: 24, top: 19, right: 24),
                    decoration: AppDecoration.fillBluegray8004c.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                          child: Container(
                              padding: getPadding(
                                  left: 12, top: 16, right: 12, bottom: 16),
                              decoration:
                                  AppDecoration.fillBluegray8004c.copyWith(
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: getPadding(top: 1, bottom: 1),
                                        child: Text("lbl_centre_d_aide".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtMulishRomanMedium16Indigo5099)),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightWhiteA700,
                                        height: getSize(24.00),
                                        width: getSize(24.00))
                                  ])),
                        ),
                        GestureDetector(
                          onTap: () {
                            VibrationService.vibrate();

                            Get.to(() => const WebSitesPage(
                                  name: "msg_termes_et_conditions",
                                  url:
                                      "https://atomai.fr/terms-and-conditions/",
                                ));
                          },
                          child: Container(
                              margin: getMargin(top: 4),
                              padding: getPadding(
                                  left: 12, top: 16, right: 12, bottom: 16),
                              decoration: AppDecoration.fillBluegray8004c,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: getPadding(top: 1, bottom: 1),
                                        child: Text(
                                            "msg_termes_et_conditions".tr,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtMulishRomanMedium16Indigo5099)),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightWhiteA700,
                                        height: getSize(24.00),
                                        width: getSize(24.00))
                                  ])),
                        ),
                        GestureDetector(
                          onTap: () {
                            VibrationService.vibrate();

                            Get.to(() => const WebSitesPage(
                                  name: "msg_politique_de_confidentialit2",
                                  url: "https://atomai.fr/privacy-policy/",
                                ));
                          },
                          child: Container(
                            margin: getMargin(top: 4),
                            padding: getPadding(
                                left: 12, top: 15, right: 12, bottom: 15),
                            decoration:
                                AppDecoration.fillBluegray8004c.copyWith(
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(top: 3),
                                    child: Text(
                                        "msg_politique_de_confidentialit2".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtMulishRomanMedium16Indigo5099)),
                                CustomImageView(
                                    svgPath:
                                        ImageConstant.imgArrowrightWhiteA700,
                                    height: getSize(24.00),
                                    width: getSize(24.00))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                  child: Container(
                    decoration: AppDecoration.fillBluegray8004c.copyWith(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        VibrationService.vibrate();

                        try {
                          Purchases.logOut();
                          FirebaseAuth.instance.signOut();
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          log(e.toString());
                        } finally {
                          Get.offAllNamed(AppRoutes.onboardingScreen);
                        }
                      },
                      child: Container(
                        margin: getMargin(top: 4),
                        padding: getPadding(
                            left: 12, top: 15, right: 12, bottom: 15),
                        decoration: AppDecoration.fillBluegray8004c.copyWith(
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: getPadding(top: 3),
                              child: Text(
                                "lbl_se_d_connecter".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.3,
                            ),
                            CustomImageView(
                              svgPath: ImageConstant.imgTrash,
                              height: getSize(24.00),
                              width: getSize(24.00),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapArrowleft2() {
    Get.back();
  }
}
