import 'dart:ui';

import '../../../app_export.dart';
import '../../../services/vibtaion_service.dart';
import '../../../widgets/custom_button.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.gray900,
          borderRadius: BorderRadius.circular(20),
        ),
        height: size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // CustomImageView(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 32,
                child: Text(
                  "Limit_reached!".tr,
                  style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                    fontSize: 25,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    letterSpacing: getHorizontalSize(0.24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 69,
                child: Text(
                  "Take_it_to_the_next_level\nwith_our_premium_packs.".tr,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    letterSpacing: getHorizontalSize(0.24),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onTap: () {
                    VibrationService.vibrate();
                    Get.back();
                    Get.toNamed(AppRoutes.premiumPage);
                  },
                  height: 56,
                  width: 350,
                  text: "Improve".tr,
                  variant: ButtonVariant.OutlineGray90001,
                  shape: ButtonShape.CircleBorder28,
                  fontStyle: ButtonFontStyle.MulishSemiBold16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
