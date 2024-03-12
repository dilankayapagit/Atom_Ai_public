import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/folder_custom_model.dart';
import '../../../services/vibtaion_service.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/app_style.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/custom_image_view.dart';
import '../../edit_note_screen/widgets/folder_select_bottom_sheet.dart';
import '../controller/notes_home_controller.dart';
import 'folder_home_widget.dart';

class BottomSettingsWidget extends StatefulWidget {
  const BottomSettingsWidget({super.key});

  @override
  State<BottomSettingsWidget> createState() => _BottomSettingsWidgetState();
}

class _BottomSettingsWidgetState extends State<BottomSettingsWidget> {
  var controller = Get.put(NotesHomeController());
  EditNotesFunctions editNotesFunctions = EditNotesFunctions();
  Widget _buildThirdWidget() {
    return Container(
      key: const ValueKey(3),
      decoration: BoxDecoration(
        color: ColorConstant.gray900,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      height: 75,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomImageView(
                onTap: () async {
                  VibrationService.vibrate();

                  controller.updateEditMode(false);
                  await controller.pinSeleted();
                  controller.resetSelected();
                },
                imagePath: "assets/icons_png/WHITE/Pin.png",
                color: Colors.white.withOpacity(0.3),
                height: 30,
                width: 30,
              ),
              CustomImageView(
                onTap: () async {
                  VibrationService.vibrate();

                  controller.updateEditMode(false);
                  await controller.lockSeleted();
                  controller.resetSelected();
                },
                imagePath: "assets/icons_png/WHITE/Lock - 1.png",
                color: Colors.white.withOpacity(0.3),
                height: 30,
                width: 30,
              ),
              CustomImageView(
                onTap: () async {
                  VibrationService.vibrate();

                  controller.updateEditMode(false);
                  await bottomGetWidget();
                  controller.resetSelected();
                },
                imagePath: "assets/icons_png/WHITE/Folder File Right.png",
                color: Colors.white.withOpacity(0.3),
                height: 30,
                width: 30,
              ),
              CustomImageView(
                onTap: () async {
                  VibrationService.vibrate();

                  controller.updateEditMode(false);

                  controller.shareSeleted();

                  controller.resetSelected();
                },
                imagePath: "assets/icons_png/WHITE/Upload.png",
                color: Colors.white.withOpacity(0.3),
                height: 30,
                width: 30,
              ),
              CustomImageView(
                onTap: () async {
                  VibrationService.vibrate();
                  await controller.deleteSeleted();
                  controller.resetSelected();
                },
                imagePath: "assets/icons_png/WHITE/Delete.png",
                color: Colors.white.withOpacity(0.3),
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: controller.editMode.value ? _buildThirdWidget() : null,
      ),
    );
  }

  Future<bool> bottomGetWidget() async {
    await Get.bottomSheet(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.gray900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DefaultTabController(
            length: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TabBar(
                      indicatorColor: ColorConstant.orange300,
                      dividerColor: Colors.transparent,
                      labelColor: ColorConstant.orange300,
                      unselectedLabelStyle: AppStyle.txtMulishRegular16,
                      labelStyle: AppStyle.txtMulishRomanSemiBold16Orange,
                      tabs: [
                        Tab(
                          child: Text(
                            "lbl_tous".tr,
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Obx(() => GridView.builder(
                            //controller: scrollController,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: controller.folderList.length,
                            itemBuilder: (context, index) {
                              FolderCustomModel model =
                                  controller.folderList[index];

                              return Container(
                                decoration:
                                    AppDecoration.outlineGray90001.copyWith(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        VibrationService.vibrate();

                                        Get.back();
                                        controller
                                            .parentId(model.folderId ?? "");
                                        controller.moveSeleted();
                                      },
                                      child: FolderHomeWidget(
                                        model,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // isScrollControlled: true,
      backgroundColor: ColorConstant.gray900,
    );
    return true;
  }
}
