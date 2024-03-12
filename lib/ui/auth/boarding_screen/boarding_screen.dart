import '../../../services/vibtaion_service.dart';
import 'controller/boarding_controller.dart';
import 'package:atomai/app_export.dart';
import 'package:atomai/widgets/custom_button.dart';

class BoardingScreen extends GetWidget<BoardingController> {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.onboarding2,
              height: getVerticalSize(
                size.height * 0.5,
              ),
              width: getHorizontalSize(
                size.width * 0.9,
              ),
              alignment: Alignment.center,
            ),
            Padding(
              padding: getPadding(
                top: 30,
              ),
              child: Text(
                "msg_notes_quotidiennes".tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratAlternatesSemiBold24.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.24,
                  ),
                ),
              ),
            ),
            Container(
              width: getHorizontalSize(
                324.00,
              ),
              margin: getMargin(
                top: 16,
              ),
              child: Text(
                "msg_prenez_des_notes".tr,
                maxLines: null,
                textAlign: TextAlign.center,
                style: AppStyle.txtMulishRegular16.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                VibrationService.vibrate();

                Get.offAllNamed(AppRoutes.notesHomePage);
              },
              height: 56,
              width: 157,
              text: "lbl_commencez".tr,
              // margin: getMargin(
              //   top: 26,
              //   bottom: 10,
              // ),
              variant: ButtonVariant.OutlineGray90001,
              shape: ButtonShape.CircleBorder28,
              fontStyle: ButtonFontStyle.MulishSemiBold16,
            ),
          ],
        ),
      ),
    );
  }
}
