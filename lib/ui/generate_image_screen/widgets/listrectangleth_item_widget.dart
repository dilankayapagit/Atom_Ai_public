import '../../../app_export.dart';
import '../controller/generate_note_controller.dart';
import '../models/image_style_model.dart';

// ignore: must_be_immutable
class ListrectanglethItemWidget extends StatelessWidget {
  ListrectanglethItemWidget(this.imageStyleModel, {super.key});

  ImageStyleModel imageStyleModel;
  var controller = Get.put(GenerateImagesController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IntrinsicWidth(
        child: Padding(
          padding: getPadding(
            right: 12,
            bottom: 1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    // width: 2,
                    color:
                        controller.selectedStyle.value.id == imageStyleModel.id
                            ? ColorConstant.floatingActionBtnColor
                            : ColorConstant.blueGray8004c,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  // Adjust the radius as needed
                  child: CustomImageView(
                    imagePath: imageStyleModel.img,
                    height: getVerticalSize(
                      50,
                    ),
                    width: getHorizontalSize(
                      75,
                    ),
                    radius: BorderRadius.circular(
                      getHorizontalSize(
                        10,
                      ),
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 12,
                ),
                child: Text(
                  imageStyleModel.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtMulishRomanMedium14Gray10001.copyWith(
                    color:
                        controller.selectedStyle.value.id == imageStyleModel.id
                            ? ColorConstant.floatingActionBtnColor
                            : ColorConstant.whiteA700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
