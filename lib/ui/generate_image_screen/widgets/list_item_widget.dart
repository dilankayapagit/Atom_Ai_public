import 'package:atomai/ui/generate_image_screen/controller/generate_note_controller.dart';

import '../../../app_export.dart';
import '../models/size_list_model.dart';

// ignore: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {super.key});
  var controller = Get.put(GenerateImagesController());

  SizeListModel listItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IntrinsicWidth(
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: getHorizontalSize(
              107,
            ),
            margin: getMargin(
              right: 12,
            ),
            padding: getPadding(
              left: 20,
              top: 9,
              right: 20,
              bottom: 9,
            ),
            decoration: AppDecoration.txtOutlineGray90001.copyWith(
                borderRadius: BorderRadiusStyle.txtCircleBorder19,
                color:
                    controller.selectSize.value.title == listItemModelObj.title
                        ? ColorConstant.floatingActionBtnColor
                        : null),
            child: Text(
              listItemModelObj.title ?? "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMulishRomanMedium14.copyWith(
                letterSpacing: getHorizontalSize(
                  0.14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
