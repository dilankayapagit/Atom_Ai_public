import '../../../../utils/image_constant.dart';

class OnboardingModel {
  final String? topText;
  final String? bottomText;
  final String? img;
  OnboardingModel({
    this.topText,
    this.bottomText,
    this.img,
  });

  static List<OnboardingModel> listOnBording = [
    OnboardingModel(
        topText: "msg_g_n_rer_des_textes",
        bottomText: "msg_utilisez_la_derni_re",
        img: ImageConstant.onboarding),
    OnboardingModel(
        topText: "msg_sauvegarder_vos",
        bottomText: "msg_modifiez_vos_textes",
        img: ImageConstant.onboarding1),
    OnboardingModel(
        topText: "msg_faites_votre_to_do",
        bottomText: "msg_cr_ez_et_organisez",
        img: ImageConstant.onboarding2),
    OnboardingModel(
        topText: "msg_keep_your_data_safety",
        bottomText: "msg_unlock_your_limit",
        img: ImageConstant.onboarding3),
  ];
}
