import 'dart:io';
import 'dart:ui';

import 'package:flutter_quill/flutter_quill.dart' hide Text;
import '../../../app_export.dart';
import '../controller/edit_note_controller.dart';

class BottomImageSelector extends StatefulWidget {
  final QuillController quillController;
  final FocusNode focusNodeQuillEditor;
  const BottomImageSelector({
    super.key,
    required this.quillController,
    required this.focusNodeQuillEditor,
  });

  @override
  State<BottomImageSelector> createState() => _BottomImageSelectorState();
}

class _BottomImageSelectorState extends State<BottomImageSelector> {
  var controller = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              Get.back();
              uploadImg(true);
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.dropdown,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              height: 65,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: "assets/icons_png/BLACK/Image up.png",
                      color: Colors.white,
                      height: 30,
                      width: 30,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Import_an_image".tr,
                      style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                        color: Colors.white,
                        letterSpacing: getHorizontalSize(0.24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: ColorConstant.gray900,
            height: 2,
          ),
          GestureDetector(
            onTap: () async {
              Get.back();
              Get.toNamed(AppRoutes.generateImageScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.dropdown,
              ),
              height: 65,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: "assets/icons_png/BLACK/Image plus.png",
                      color: Colors.white,
                      height: 30,
                      width: 30,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Generate_an_image".tr,
                      style: AppStyle.txtMulishRomanSemiBold16.copyWith(
                        color: Colors.white,
                        letterSpacing: getHorizontalSize(0.24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  uploadImg(bool isGallery) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image;
    if (isGallery) {
      image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      image = await picker.pickImage(source: ImageSource.camera);
    }
    if (image != null) {
      addSpace();
      String url = await controller.saveImg(File(image.path));
      final index = widget.quillController.selection.baseOffset;
      final length = widget.quillController.selection.extentOffset - index;
      widget.quillController
          .replaceText(index, length, BlockEmbed.image(url), null);
      addSpace();
    }
  }

  addSpace({String st = "\n\n"}) {
    widget.quillController.document
        .insert(widget.quillController.document.length - 1, st);
    widget.focusNodeQuillEditor.nextFocus();
  }
}
