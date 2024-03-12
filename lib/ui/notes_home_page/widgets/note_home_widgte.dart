import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/note_firebase_model.dart';
import '../../../services/vibtaion_service.dart';
import '../../../widgets/text_editor_custom.dart';
import '../controller/notes_home_controller.dart';
import 'package:atomai/app_export.dart';

// ignore: must_be_immutable
class NoteHomeWidget extends StatefulWidget {
  NoteHomeWidget(this.noteFirebaseModel, {super.key});
  NoteFirebaseModel noteFirebaseModel;

  @override
  State<NoteHomeWidget> createState() => _NoteHomeWidgetState();
}

class _NoteHomeWidgetState extends State<NoteHomeWidget> {
  late QuillController _controllerQuill;
  final FocusNode _focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  var controller = Get.find<NotesHomeController>();

  @override
  void initState() {
    super.initState();
    _controllerQuill = QuillController(
      document: widget.noteFirebaseModel.noteQuill.document,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerQuill.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: getPadding(
          left: 12,
          top: 10,
          right: 12,
          bottom: 10,
        ),
        decoration: AppDecoration.outlineGray90001.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * .35,
                      child: Text(
                        widget.noteFirebaseModel.title ?? "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                            AppStyle.txtMontserratAlternatesSemiBold16.copyWith(
                          letterSpacing: getHorizontalSize(
                            0.16,
                          ),
                        ),
                      ),
                    ),
                    if ((widget.noteFirebaseModel.pinned ?? false) &&
                        !controller.editMode.value)
                      Expanded(
                        child: CustomImageView(
                          imagePath: "assets/icons_png/BLACK/Pin - 1.png",
                          height: 20,
                          width: 25,
                          fit: BoxFit.scaleDown,
                          color: ColorConstant.whiteA700,
                        ),
                      ),
                  ],
                ),
                if (controller.editMode.value &&
                    controller.fileListSelect
                        .contains(widget.noteFirebaseModel.docId))
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomImageView(
                        onTap: () {
                          VibrationService.vibrate();

                          controller
                              .selectFile(widget.noteFirebaseModel.docId ?? "");
                        },
                        imagePath:
                            "assets/icons_png/BLACK/Check circle - 1.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.scaleDown,
                        color: ColorConstant.floatingActionBtnColor),
                  ),
                if (controller.editMode.value &&
                    !controller.fileListSelect
                        .contains(widget.noteFirebaseModel.docId))
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomImageView(
                        onTap: () {
                          VibrationService.vibrate();

                          controller
                              .selectFile(widget.noteFirebaseModel.docId ?? "");
                        },
                        imagePath: "assets/icons_png/BLACK/circle.png",
                        height: 25,
                        width: 25,
                        fit: BoxFit.scaleDown,
                        color: ColorConstant.whiteA700),
                  )
              ],
            ),
            Flexible(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  !(widget.noteFirebaseModel.locked ?? false)
                      ? Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: size.width * .5,
                            height: size.height * 0.15,
                            child: TextEditorCustom(
                              controllerQuill: _controllerQuill,
                              focusNode: _focusNode,
                              scrollController: scrollController,
                              isReadOnly: true,
                              showCursor: false,
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: size.width * .5,
                            height: size.height * 0.15,
                            child: SvgPicture.asset(
                              ImageConstant.imgLockBlueGray700,
                              height: 10,
                              width: 10,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * .5,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd(Get.locale!.languageCode).format(
                      (widget.noteFirebaseModel.updateAt ?? Timestamp.now())
                          .toDate()),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtMulishRegular11.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.11,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                      controller.getFolderName(
                          widget.noteFirebaseModel.parentId ?? ""),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtMulishRegular11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
