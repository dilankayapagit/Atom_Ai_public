import '../controller/language_controller.dart';
import '../models/listflag_item_model.dart';
import 'package:atomai/app_export.dart';

// ignore: must_be_immutable
class ListflagItemWidget extends StatelessWidget {
  ListflagItemWidget(this.listflagItemModelObj, {super.key});

  ListflagItemModel listflagItemModelObj;

  var controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        all: 16,
      ),
      decoration: AppDecoration.outlineIndigo400.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            listflagItemModelObj.img ?? ImageConstant.imgUsPng,
            height: getSize(
              32.00,
            ),
            width: getSize(
              32.00,
            ),
          ),
          Padding(
            padding: getPadding(
              left: 16,
              top: 5,
              bottom: 2,
            ),
            child: Text(
              listflagItemModelObj.name ?? "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsMedium16Indigo5099.copyWith(
                letterSpacing: getHorizontalSize(
                  0.30,
                ),
              ),
            ),
          ),
          const Spacer(),
          controller.listflagItemModel.value.name != listflagItemModelObj.name
              ? CustomImageView(
                  svgPath: ImageConstant.imgGlobe,
                  height: getSize(
                    32.00,
                  ),
                  width: getSize(
                    32.00,
                  ),
                )
              : CustomImageView(
                  svgPath: ImageConstant.imgContrast,
                  height: getSize(
                    32.00,
                  ),
                  width: getSize(
                    32.00,
                  ),
                  color: ColorConstant.floatingActionBtnColor,
                ),
        ],
      ),
    );
  }
}
