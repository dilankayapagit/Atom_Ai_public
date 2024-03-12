import 'package:atomai/models/image_genarate_model/artifact.dart';

import '../../../app_export.dart';
import '../controller/generate_note_controller.dart';

// ignore: must_be_immutable
class GenerateNoteItemWidget extends StatelessWidget {
  GenerateNoteItemWidget(this.artifact, {super.key});

  Artifact artifact;

  var controller = Get.find<GenerateImagesController>();

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.memory(
          artifact.imgbytes,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
