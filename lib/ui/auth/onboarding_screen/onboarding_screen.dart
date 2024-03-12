// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';

import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

import '../../../services/payment_controller.dart';
import '../../../services/vibtaion_service.dart';
import 'controller/onboarding_controller.dart';
import 'models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController buttonCarouselController = CarouselController();
  int _current = 0;

  var controller = Get.put(OnboardingController());
  var paymentController = Get.put(PaymentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentController.getOfferings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              CarouselSlider.builder(
                carouselController: buttonCarouselController,
                itemCount: OnboardingModel.listOnBording.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  var onBordingModel = OnboardingModel.listOnBording[itemIndex];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: size.width * .6,
                          child: Text(
                            "${onBordingModel.topText}".tr,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: AppStyle.txtMontserratAlternatesMedium32
                                .copyWith(
                              fontSize: 20,
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        onBordingModel.img ?? "",
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: getHorizontalSize(313.00),
                          child: Text(
                            "${onBordingModel.bottomText}".tr,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: AppStyle.txtMulishRomanRegular16.copyWith(
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 0.9,
                  height: 450,
                  aspectRatio: 16 / 12,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    OnboardingModel.listOnBording.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      buttonCarouselController.animateToPage(entry.key);
                    },
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? ColorConstant.blueGray100
                                  : ColorConstant.indigo400)
                              .withOpacity(_current == entry.key ? 0.9 : 0.2)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: Text(
                  "msg_commencez_votre".tr,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtMulishRomanRegular14.copyWith(
                    letterSpacing: getHorizontalSize(0.26),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  onTap: () {
                    VibrationService.vibrate();

                    Get.toNamed(AppRoutes.premiumPage);
                  },
                  height: 64,
                  width: 366,
                  text: "msg_s_abonner_avec_un".tr,
                  margin: getMargin(top: 23)),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    VibrationService.vibrate();

                    Get.toNamed(AppRoutes.loginOptionScreen);
                  },
                  child: Text(
                    "lbl_se_connecter".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtMulishRomanMedium14.copyWith(
                      letterSpacing: getHorizontalSize(0.3),
                      fontSize: 14,
                    ),
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

                    Get.toNamed(AppRoutes.loginOptionScreen);
                  },
                  child: Text(
                    "Skip".tr,
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
              // Container(
              //     width: getHorizontalSize(363.00),
              //     margin: getMargin(top: 9),
              //     child: RichText(
              //         text: TextSpan(
              //           children: [
              //             TextSpan(
              //               text: "msg_en_commen_ant_un2".tr,
              //               style: TextStyle(
              //                 color: ColorConstant.indigo5099,
              //                 fontSize: getFontSize(10),
              //                 fontFamily: 'Mulish',
              //                 fontWeight: FontWeight.w400,
              //                 letterSpacing: getHorizontalSize(0.30),
              //               ),
              //             ),
              //             TextSpan(
              //               text: "msg_conditions_de_service".tr,
              //               style: TextStyle(
              //                 color: ColorConstant.indigo400,
              //                 fontSize: getFontSize(10),
              //                 fontFamily: 'Mulish',
              //                 fontWeight: FontWeight.w400,
              //                 letterSpacing: getHorizontalSize(0.30),
              //               ),
              //             ),
              //             TextSpan(
              //               text: "msg_et_reconnaissez".tr,
              //               style: TextStyle(
              //                 color: ColorConstant.indigo5099,
              //                 fontSize: getFontSize(10),
              //                 fontFamily: 'Mulish',
              //                 fontWeight: FontWeight.w400,
              //                 letterSpacing: getHorizontalSize(
              //                   0.30,
              //                 ),
              //               ),
              //             ),
              //             TextSpan(
              //               text: "msg_politique_de_confidentialit".tr,
              //               style: TextStyle(
              //                 color: ColorConstant.indigo400,
              //                 fontSize: getFontSize(10),
              //                 fontFamily: 'Mulish',
              //                 fontWeight: FontWeight.w400,
              //                 letterSpacing: getHorizontalSize(0.30),
              //               ),
              //             ),
              //             TextSpan(
              //               text: "msg_si_vous_n_annulez".tr,
              //               style: TextStyle(
              //                 color: ColorConstant.indigo5099,
              //                 fontSize: getFontSize(10),
              //                 fontFamily: 'Mulish',
              //                 fontWeight: FontWeight.w400,
              //                 letterSpacing: getHorizontalSize(0.30),
              //               ),
              //             ),
              //           ],
              //         ),
              //         textAlign: TextAlign.left))
            ],
          ),
        ),
      ),
    );
  }
}
