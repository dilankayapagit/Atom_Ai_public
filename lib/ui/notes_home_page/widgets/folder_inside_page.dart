// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atomai/ui/notes_home_page/widgets/note_home_widgte.dart';
import 'package:local_auth/local_auth.dart';

import '../../../models/note_firebase_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/user_data_controller.dart';
import '../../../services/vibtaion_service.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/app_style.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_subtitle_2.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../edit_note_screen/controller/edit_note_controller.dart';
import '../../generate_note_screen/controller/generate_note_controller.dart';
import '../controller/notes_home_controller.dart';
import '../notes_home_page.dart';
import 'bottom_settings_widget.dart';
import 'empty_note_widget.dart';

class FolderInsidePage extends StatefulWidget {
  const FolderInsidePage({
    Key? key,
    required this.folderId,
    required this.folderName,
  }) : super(key: key);
  final String folderId;
  final String folderName;

  @override
  State<FolderInsidePage> createState() => _FolderInsidePageState();
}

class _FolderInsidePageState extends State<FolderInsidePage> {
  var controller = Get.put(NotesHomeController());
  var userDataController = Get.put(UserDataController());
  var generateNoteController = Get.put(GenerateNoteController());
  var editNoteController = Get.put(EditNoteController());

  @override
  void initState() {
    super.initState();
    controller.folderId(widget.folderId);
    controller.getCurrentNotesById();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.editMode.value) {
          controller.updateEditMode(false);
          controller.resetSelected();
          return false;
        }
        controller.folderId("");
        return true;
      },
      child: Obx(
        () => SafeArea(
          top: false,
          bottom: false,
          child: DefaultTabController(
            length: 1,
            child: Scaffold(
              floatingActionButton: Padding(
                padding:
                    EdgeInsets.only(bottom: controller.editMode.value ? 60 : 0),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: ColorConstant.floatingActionBtnColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    heroTag: ValueKey(generateRandomString()),
                    onPressed: () {
                      VibrationService.vibrate();

                      editNoteController
                          .setNoteFirebaseModel(NoteFirebaseModel());
                      editNoteController.setParentId(widget.folderId);
                      generateNoteController.startUp();
                      Get.toNamed(AppRoutes.generateNoteScreen);
                    },
                    child: SvgPicture.asset(
                      ImageConstant.imgPlusWhiteA700,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              appBar: CustomAppBar(
                height: getVerticalSize(100.00),
                leadingWidth: 48,
                leading: AppbarImage(
                  height: getSize(24.00),
                  width: getSize(24.00),
                  svgPath: ImageConstant.imgArrowleft,
                  margin: getMargin(left: 24, top: 10, bottom: 10),
                  onTap: () {
                    Get.back();
                  },
                ),
                title: AppbarSubtitle2(
                  text: "lbl_notes".tr,
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      controller.updateEditMode(!controller.editMode.value);
                      controller.resetSelected();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        !controller.editMode.value
                            ? "lbl_modifier".tr
                            : "msg_finished".tr,
                        style: AppStyle.txtMulishRegular16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();

                      controller.searchDialog();
                    },
                    child: SvgPicture.asset(
                      ImageConstant.imgSearchIndigo50,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: ColorConstant.orange300,
                  dividerColor: Colors.transparent,
                  labelColor: ColorConstant.orange300,
                  unselectedLabelStyle: AppStyle.txtMulishRegular16,
                  labelStyle: AppStyle.txtMulishRomanSemiBold16Orange,
                  tabs: [
                    Tab(
                      child: Text(
                        widget.folderName,
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: ColorConstant.gray900,
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                ),
                child: TabBarView(
                  children: [
                    Stack(children: [
                      controller.notesList.isEmpty
                          ? EmptyNoteWidget(
                              folderId: widget.folderId,
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemCount: controller.noteByIdList.length,
                              itemBuilder: (context, index) {
                                NoteFirebaseModel model =
                                    controller.noteByIdList[index];

                                return Container(
                                  decoration:
                                      AppDecoration.outlineGray90001.copyWith(
                                    boxShadow: [
                                      if (controller.editMode.value)
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(
                                              4, 8), // Shadow position
                                        ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      VibrationService.vibrate();

                                      controller.resetSelected();
                                      controller.selectFile(model.docId ?? "");
                                      controller.updateEditMode(true);
                                    },
                                    onTap: () async {
                                      VibrationService.vibrate();

                                      if (controller.editMode.value) {
                                        //  controller.resetSelected();
                                        controller
                                            .selectFile(model.docId ?? "");
                                        controller.updateEditMode(true);
                                        return;
                                      }
                                      if (model.locked ?? false) {
                                        try {
                                          final LocalAuthentication auth =
                                              LocalAuthentication();

                                          final bool didAuthenticate =
                                              await auth.authenticate(
                                                  localizedReason:
                                                      'Please authenticate to show locked notes.');
                                          if (!didAuthenticate) {
                                            return;
                                          }
                                        } catch (e) {
                                          log("${e}auth local");
                                        }
                                      }
                                      editNoteController.setTitleTxtController(
                                          model.title ?? "");
                                      editNoteController.setQuillControllerDoc(
                                          model.noteQuill.document);
                                      editNoteController
                                          .setNoteFirebaseModel(model);
                                      // editNoteController
                                      //     .setNewMap(model.noteQuillList);
                                      Get.toNamed(AppRoutes.editNoteScreen);
                                      controller.updateEditMode(false);
                                    },
                                    child: NoteHomeWidget(
                                      model,
                                    ),
                                  ),
                                );
                              },
                            ),
                      const Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomSettingsWidget())
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
