import '../../../app_export.dart';
import '../../../models/image_genarate_model/artifact.dart';
import '../controller/detail_iamge_controller.dart';

// ignore: must_be_immutable
class DetailNoteItemWidget extends StatelessWidget {
  DetailNoteItemWidget(this.detailNoteItemModelObj, {super.key});

  Artifact detailNoteItemModelObj;

  var controller = Get.find<DetailNImageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(
        230,
      ),
      width: getHorizontalSize(
        158,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.blueGray8004c,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            12,
          ),
        ),
      ),
    );
  }
}
