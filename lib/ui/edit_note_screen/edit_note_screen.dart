import 'dart:developer';

import 'package:atomai/ui/edit_note_screen/widgets/bottom_sheet_custom.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:jiffy/jiffy.dart';

import 'package:atomai/app_export.dart';
import 'package:atomai/ui/notes_home_page/controller/notes_home_controller.dart';

import '../../services/share_controller.dart';
import '../../services/vibtaion_service.dart';
import '../../widgets/app_bar/appbar_subtitle_2.dart';
import '../../widgets/text_editor_custom.dart';
import '../generate_note_screen/controller/generate_note_controller.dart';
import 'controller/edit_note_controller.dart';
import 'models/custom_popup_menuItem.dart';
import 'widgets/folder_select_bottom_sheet.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  var controller = Get.put(EditNoteController());
  var notesHomeController = Get.put(NotesHomeController());
  var shareController = Get.put(ShareController());
  var generateNoteController = Get.put(GenerateNoteController());

  EditNotesFunctions editNotesFunctions = EditNotesFunctions();
  final FocusNode focusNodeSearch = FocusNode();

  @override
  void initState() {
    super.initState();
    controller.scrollController(ScrollController());
    controller.focusNodeQuillEditor(FocusNode());
  }

  @override
  void dispose() {
    super.dispose();
    controller.focusNodeQuillEditor.value.dispose();
    // controller.controllerQuill.value.dispose();
    controller.toggleWidget(0);
  }

  getBack() async {
    Get.dialog(
      CustomBlurDialog(
        title: "Saving.".tr,
        child: const CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      await controller.saveNote();
    } catch (e) {
      log(e.toString());
    } finally {
      Get.back();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await getBack();
        return true;
      },
      child: GestureDetector(
        onVerticalDragDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Obx(
          () => SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: ColorConstant.gray900,
              appBar: CustomAppBar(
                height: getVerticalSize(56.00),
                leadingWidth: 48,
                leading: AppbarImage(
                  height: getSize(24.00),
                  width: getSize(24.00),
                  svgPath: ImageConstant.imgArrowleft,
                  margin: getMargin(left: 24, top: 16, bottom: 16),
                  onTap: () async {
                    VibrationService.vibrate();
                    await getBack();
                  },
                ),
                title: AppbarSubtitle2(
                  text: "lbl_notes".tr,
                  margin: getMargin(left: 12),
                ),
                actions: [
                  PopupMenuButton(
                    onOpened: () {
                      VibrationService.vibrate();
                    },
                    color: Colors.transparent,
                    icon: CustomImageView(
                      height: getSize(25.00),
                      width: getSize(25.00),
                      svgPath: ImageConstant.imgUpload,
                      fit: BoxFit.contain,
                    ),
                    elevation: 0,
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem>[
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () async {
                              VibrationService.vibrate();

                              Get.back();
                              FocusManager.instance.primaryFocus?.unfocus();
                              shareController.shareFile(
                                  controller.controllerQuill.value,
                                  controller.titleTxtController.value.text,
                                  context: context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.dropdown,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Document pdf - 2.png",
                                      color: Colors.white,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "msg_Partager_en_PDF".tr,
                                      style: AppStyle.txtMulishRomanSemiBold16
                                          .copyWith(
                                        color: Colors.white,
                                        letterSpacing: getHorizontalSize(0.24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () async {
                              VibrationService.vibrate();
                              Get.back();
                              FocusManager.instance.primaryFocus?.unfocus();
                              shareController.shareFile(
                                  controller.controllerQuill.value,
                                  controller.titleTxtController.value.text,
                                  isTextOnly: true,
                                  context: context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.dropdown,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Document - 1.png",
                                      color: Colors.white,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        "msg_Partager_du_texte_uniquement".tr,
                                        style: AppStyle.txtMulishRomanSemiBold16
                                            .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                          letterSpacing:
                                              getHorizontalSize(0.24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                  PopupMenuButton(
                    onOpened: () {
                      VibrationService.vibrate();
                    },
                    color: Colors.transparent,
                    icon: CustomImageView(
                      height: getSize(25.00),
                      width: getSize(25.00),
                      svgPath: ImageConstant.imgVolume,
                      fit: BoxFit.contain,
                    ),
                    elevation: 0,
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem>[
                        CustomPopupMenuItem(
                          child: Obx(
                            () => Container(
                              width: size.width * 0.4,
                              height: size.height * 0.11,
                              decoration: BoxDecoration(
                                color: ColorConstant.dropdown,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (!controller.pinned.value)
                                      GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setPin(true);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 80,
                                          height: 50,
                                          child: Column(
                                            children: [
                                              CustomImageView(
                                                imagePath:
                                                    "assets/icons_png/WHITE/Pin.png",
                                                color: ColorConstant.whiteA700,
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              Text(
                                                "Pin".tr,
                                                style: AppStyle
                                                    .txtMulishRomanSemiBold16
                                                    .copyWith(
                                                  color: Colors.white,
                                                  letterSpacing:
                                                      getHorizontalSize(0.24),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (controller.pinned.value)
                                      GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setPin(false);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 80,
                                          height: 50,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                child: CustomImageView(
                                                  onTap: () {
                                                    VibrationService.vibrate();

                                                    controller.setPin(false);
                                                    setState(() {});
                                                  },
                                                  imagePath:
                                                      "assets/icons_png/WHITE/Pin remove.png",
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                              Text(
                                                "Unpin".tr,
                                                style: AppStyle
                                                    .txtMulishRomanSemiBold16
                                                    .copyWith(
                                                  color: Colors.white,
                                                  letterSpacing:
                                                      getHorizontalSize(0.24),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    Container(
                                      height: 200,
                                      color: ColorConstant.gray900,
                                      width: 2,
                                    ),
                                    if (!controller.locked.value)
                                      GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setLock(true);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 80,
                                          height: 50,
                                          child: Column(
                                            children: [
                                              CustomImageView(
                                                imagePath:
                                                    "assets/icons_png/WHITE/Lock - 1.png",
                                                color: ColorConstant.whiteA700,
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              Text(
                                                "msg_cr_er_un_mot_de".tr,
                                                style: AppStyle
                                                    .txtMulishRomanSemiBold16
                                                    .copyWith(
                                                  color: Colors.white,
                                                  letterSpacing:
                                                      getHorizontalSize(0.24),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (controller.locked.value)
                                      GestureDetector(
                                        onTap: () {
                                          VibrationService.vibrate();

                                          controller.setLock(false);
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: 80,
                                          height: 50,
                                          child: Column(
                                            children: [
                                              CustomImageView(
                                                imagePath:
                                                    "assets/icons_png/WHITE/Lock hide 1.png",
                                                color: ColorConstant.whiteA700,
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              Text(
                                                "msg_Déverrouiller".tr,
                                                style: AppStyle
                                                    .txtMulishRomanSemiBold16
                                                    .copyWith(
                                                  color: Colors.white,
                                                  letterSpacing:
                                                      getHorizontalSize(0.24),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: Divider(
                            color: ColorConstant.gray900,
                            height: 2,
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () {
                              VibrationService.vibrate();
                              Get.back();
                              editNotesFunctions.bottomGetWidget();
                            },
                            child: Container(
                              color: ColorConstant.dropdown,
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Folder.png",
                                      color: ColorConstant.whiteA700,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "déplacer_la_note".tr,
                                      style: AppStyle.txtMulishRomanSemiBold16
                                          .copyWith(
                                        color: Colors.white,
                                        letterSpacing: getHorizontalSize(0.24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: Divider(
                            color: ColorConstant.gray900,
                            height: 2,
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () async {
                              VibrationService.vibrate();

                              Get.back();
                              controller.toggleWidget(2);
                              focusNodeSearch.requestFocus();
                              var data =
                                  controller.controllerQuill.value.document;
                              controller.controllerQuill.value =
                                  QuillController.basic();
                              controller.controllerQuill.value.document = data;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.dropdown,
                              ),
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Search.png",
                                      color: Colors.white,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "lbl_research".tr,
                                      style: AppStyle.txtMulishRomanSemiBold16
                                          .copyWith(
                                        color: Colors.white,
                                        letterSpacing: getHorizontalSize(0.24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: Divider(
                            color: ColorConstant.gray900,
                            height: 2,
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () {
                              VibrationService.vibrate();

                              Get.back();
                              generateNoteController
                                  .setMassages(controller.massages);
                              generateNoteController.setQuillControllerDoc(
                                  controller.controllerQuill.value.document);
                              generateNoteController.setTitle(
                                  controller.titleTxtController.value.text);
                              Get.offNamed(AppRoutes.generateNoteScreen);
                            },
                            child: Container(
                              color: ColorConstant.dropdown,
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Storyadd.png",
                                      color: ColorConstant.whiteA700,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Generate_my_note".tr,
                                      style: AppStyle.txtMulishRomanSemiBold16
                                          .copyWith(
                                        color: Colors.white,
                                        letterSpacing: getHorizontalSize(0.24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: Divider(
                            color: ColorConstant.gray900,
                            height: 2,
                          ),
                        ),
                        CustomPopupMenuItem(
                          child: GestureDetector(
                            onTap: () async {
                              VibrationService.vibrate();
                              Get.back();
                              if (await notesHomeController.dialogDelete(
                                  controller.noteFirebaseModel.value.docId ??
                                      "")) {
                                Get.offAllNamed(AppRoutes.notesHomePage);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.dropdown,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              width: 215,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          "assets/icons_png/WHITE/Delete.png",
                                      color: Colors.red,
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "supprimer".tr,
                                      style: AppStyle.txtMulishRomanSemiBold16
                                          .copyWith(
                                        color: Colors.red,
                                        letterSpacing: getHorizontalSize(0.24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ];
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    padding: getPadding(
                      left: 15,
                      top: 10,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextField(
                          controller: controller.titleTxtController.value,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtMulishSemiBold24.copyWith(
                            letterSpacing: getHorizontalSize(0.24),
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "lbl_input_title".tr,
                            hintStyle: AppStyle.txtMulishSemiBold24.copyWith(
                              letterSpacing: getHorizontalSize(0.24),
                            ),
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                        Padding(
                          padding: getPadding(top: 9),
                          child: Text(
                              "${Jiffy.now().format(pattern: "MMMM do yyyy, hh:mm a")} |  ${controller.controllerQuill.value.document.toPlainText().split(" ").length} ${"words".tr}"
                                  .tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtMulishRegular12),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: SizedBox(
                            height: size.height,
                            width: size.width,
                            child: TextEditorCustom(
                              controllerQuill: controller.controllerQuill.value,
                              focusNode: controller.focusNodeQuillEditor.value,
                              // focusNode: controller.focusNodeQuillEditor.value,
                              scrollController:
                                  controller.scrollController.value,
                            ),
                          ),
                        ),
                        if (controller.showFirstWidget.value == 0)
                          const SizedBox(
                            height: 60,
                          ),
                        if (controller.showFirstWidget.value == 1)
                          const SizedBox(
                            height: 120,
                          ),
                        if (controller.showFirstWidget.value == 2)
                          const SizedBox(
                            height: 60,
                          ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomOptionsSheetCustom(
                        quillController: controller.controllerQuill.value,
                        focusNodeQuillEditor:
                            controller.focusNodeQuillEditor.value,
                        // focusNodeQuillEditor:
                        //     controller.focusNodeQuillEditor.value,
                        focusNodeSearch: focusNodeSearch,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
