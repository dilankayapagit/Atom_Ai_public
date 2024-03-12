import 'controller/splach_controller.dart';
import 'package:atomai/app_export.dart';

class SplachScreen extends GetWidget<SplachController> {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: getPadding(left: 34, right: 34),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getVerticalSize(291.00),
                    width: getHorizontalSize(298.00),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgDesignsanstitre,
                            height: getSize(264.00),
                            width: getSize(264.00),
                            alignment: Alignment.topCenter),
                        CustomImageView(
                            imagePath: ImageConstant.imgLogoatomai,
                            height: getVerticalSize(287.00),
                            width: getHorizontalSize(298.00),
                            alignment: Alignment.center)
                      ],
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoatomai83x345,
                    height: getVerticalSize(83.00),
                    width: getHorizontalSize(345.00),
                    margin: getMargin(top: 2),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.img73,
                    height: getVerticalSize(122.00),
                    width: getHorizontalSize(344.00),
                    margin: getMargin(top: 8),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_designed_by".tr,
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
                              fontSize: getFontSize(16),
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                          TextSpan(
                            text: " ",
                            style: TextStyle(
                              color: ColorConstant.whiteA700,
                              fontSize: getFontSize(16),
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w700,
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                          TextSpan(
                            text: "lbl_pcm_agency".tr,
                            style: TextStyle(
                              color: ColorConstant.indigo400,
                              fontSize: getFontSize(16),
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              letterSpacing: getHorizontalSize(0.30),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
