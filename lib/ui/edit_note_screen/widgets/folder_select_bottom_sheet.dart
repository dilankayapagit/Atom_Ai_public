import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/folder_custom_model.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/app_style.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_utils.dart';
import '../../notes_home_page/controller/notes_home_controller.dart';
import '../../notes_home_page/widgets/folder_home_widget.dart';
import '../controller/edit_note_controller.dart';

class EditNotesFunctions {
  var controller = Get.put(EditNoteController());
  var notesHomeController = Get.put(NotesHomeController());

  bottomGetWidget() {
    Get.bottomSheet(
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
                              itemCount: notesHomeController.folderList.length,
                              itemBuilder: (context, index) {
                                FolderCustomModel model =
                                    notesHomeController.folderList[index];

                                return Container(
                                  decoration:
                                      AppDecoration.outlineGray90001.copyWith(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.setParentId(
                                              model.folderId ?? "");
                                          Get.back();
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
        backgroundColor: Colors.transparent);
  }
}
