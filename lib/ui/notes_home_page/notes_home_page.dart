import 'dart:developer';
import 'dart:math' as math;

import 'package:atomai/models/folder_custom_model.dart';
import 'package:atomai/services/user_data_controller.dart';
import 'package:atomai/ui/idea_genarator/controller/idea_genarator_controller.dart';
import 'package:atomai/ui/notes_home_page/widgets/empty_folder_widgte.dart';
import 'package:atomai/ui/notes_home_page/widgets/empty_note_widget.dart';
import 'package:atomai/ui/notes_home_page/widgets/folder_home_widget.dart';
import 'package:atomai/ui/notes_home_page/widgets/note_home_widgte.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

import '../../models/note_firebase_model.dart';
import '../../services/get_key_from_store.dart';
import '../../services/payment_controller.dart';
import '../../services/vibtaion_service.dart';
import '../edit_note_screen/controller/edit_note_controller.dart';
import '../generate_note_screen/controller/generate_note_controller.dart';
import 'bottom_sheet/bottom_sheet_search.dart';
import 'controller/notes_home_controller.dart';
import 'package:atomai/app_export.dart';

import 'widgets/bottom_settings_widget.dart';
import 'widgets/folder_inside_page.dart';

// ignore_for_file: must_be_immutable
class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage>
    with SingleTickerProviderStateMixin {
  var controller = Get.put(NotesHomeController());
  var userDataController = Get.put(UserDataController());
  var generateNoteController = Get.put(GenerateNoteController());
  var editNoteController = Get.put(EditNoteController());
  var paymentController = Get.put(PaymentController());
  var ideaGenaratorController = Get.put(IdeaGenaratorController());
  final FocusNode focusNodeSearch = FocusNode();
  var getKeyFromStore = Get.put(GetKeyFromStore());

  int selectedPage = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    startUp();
  }

  ScrollController scrollController = ScrollController();
  startUp() async {
    _tabController =
        TabController(initialIndex: selectedPage, vsync: this, length: 2);
    getKeyFromStore.getKey();
    userDataController.getUserData();
    // controller.getNotes();
    // controller.getFolder();
    controller.subscribeToFolders();
    controller.subscribeToChanges();

    paymentController.getSubscribeStatus();
    userDataController.resetWordCount();
    paymentController.getOfferings();
    await ideaGenaratorController.getCategory();
    await ideaGenaratorController.getPrompts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.editMode.value || controller.isSearch.value) {
          controller.updateEditMode(false);
          controller.isSearch(false);
          controller.resetSelected();
          return false;
        }
        return true;
      },
      child: Obx(
        () => SafeArea(
          top: false,
          bottom: false,
          child: DefaultTabController(
            initialIndex: selectedPage,
            length: 2,
            child: Scaffold(
              backgroundColor: ColorConstant.gray900,
              appBar: CustomAppBar(
                title: Text(
                  "lbl_notes".tr,
                  style: AppStyle.txtMontserratAlternatesSemiBold24,
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
                      focusNodeSearch.requestFocus();
                      controller.isSearch(!controller.isSearch.value);
                    },
                    child: SvgPicture.asset(
                      ImageConstant.imgSearchIndigo50,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      VibrationService.vibrate();
                      Get.toNamed(AppRoutes.accountScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        userDataController.userCustomModel.value.icon ??
                            ImageConstant.autoGroup5xwk,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  onTap: (int num) {
                    selectedPage = num;
                    VibrationService.vibrate();

                    log(num.toString());
                  },
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
                    ),
                    Tab(
                      child: Text(
                        "lbl_dossier".tr,
                      ),
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Stack(
                          children: [
                            controller.notesList.isEmpty
                                ? const EmptyNoteWidget()
                                : GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemCount: controller.notesList.length,
                                    itemBuilder: (context, index) {
                                      NoteFirebaseModel model =
                                          controller.notesList[index];
                                      return Container(
                                        decoration: AppDecoration
                                            .outlineGray90001
                                            .copyWith(
                                          boxShadow: [
                                            if (controller.editMode.value)
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: const Offset(
                                                    4, 8), // Shadow position
                                              ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: GestureDetector(
                                          onLongPress: () {
                                            VibrationService.vibrate();

                                            controller
                                                .selectFile(model.docId ?? "");
                                            controller.updateEditMode(true);
                                          },
                                          onTap: () async {
                                            VibrationService.vibrate();

                                            if (controller.editMode.value) {
                                              controller.selectFile(
                                                  model.docId ?? "");
                                              return;
                                            }
                                            if (model.locked ?? false) {
                                              try {
                                                final LocalAuthentication auth =
                                                    LocalAuthentication();

                                                final bool didAuthenticate =
                                                    await auth.authenticate(
                                                  localizedReason:
                                                      'Please authenticate to show locked notes.',
                                                );
                                                if (!didAuthenticate) {
                                                  return;
                                                }
                                              } catch (e) {
                                                log("${e}auth local");
                                              }
                                            }
                                            editNoteController
                                                .setTitleTxtController(
                                                    model.title ?? "");
                                            editNoteController
                                                .setQuillControllerDoc(
                                                    model.noteQuill.document);
                                            editNoteController
                                                .setNoteFirebaseModel(model);
                                            // editNoteController.setNewMap(
                                            //     model.noteQuillList);
                                            Get.toNamed(
                                                AppRoutes.editNoteScreen);
                                            controller.updateEditMode(false);
                                          },
                                          child: NoteHomeWidget(
                                            model,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: controller.editMode.value ||
                                        controller.isSearch.value
                                    ? 75
                                    : 50,
                                right: 10,
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
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

                                      editNoteController.setNoteFirebaseModel(
                                          NoteFirebaseModel());
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
                            ),
                            if (controller.isSearch.value)
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomSheetSearchHome(
                                    index: 0,
                                    forcusNode: focusNodeSearch,
                                  )),
                            const Align(
                                alignment: Alignment.bottomCenter,
                                child: BottomSettingsWidget()),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: controller.folderList.isEmpty
                                  ? EmptyFolderWidget()
                                  : SizedBox(
                                      width: size.width,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
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
                                            decoration: AppDecoration
                                                .outlineGray90001
                                                .copyWith(
                                              boxShadow: [
                                                if (controller.editMode.value)
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 4,
                                                    offset: const Offset(4,
                                                        8), // Shadow position
                                                  ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  onLongPress: () {
                                                    controller.updateEditMode(
                                                        !controller
                                                            .editMode.value);
                                                  },
                                                  onTap: () {
                                                    VibrationService.vibrate();

                                                    Get.to(
                                                      () => FolderInsidePage(
                                                        folderId:
                                                            model.folderId ??
                                                                "",
                                                        folderName:
                                                            model.folderName ??
                                                                "",
                                                      ),
                                                    );
                                                  },
                                                  child: FolderHomeWidget(
                                                    model,
                                                  ),
                                                ),
                                                if (controller.editMode.value)
                                                  GestureDetector(
                                                    onTap: () {
                                                      VibrationService
                                                          .vibrate();

                                                      controller.dialogDelete(
                                                          model.folderId ?? "",
                                                          isFolder: true);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .floatingActionBtnColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(20),
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: controller.editMode.value ||
                                          controller.isSearch.value
                                      ? 75
                                      : 50,
                                  right: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
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

                                      controller.dialogCreateFolder();
                                    },
                                    child: CustomImageView(
                                      imagePath:
                                          ImageConstant.folderFileAddPlus,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (controller.isSearch.value)
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomSheetSearchHome(
                                    index: 1,
                                    forcusNode: focusNodeSearch,
                                  )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // if (controller.isSearch.value)
                  //   Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: BottomSheetSearchHome(
                  //         index: _tabController.index,
                  //       )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generateRandomString({int length = 10000}) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = math.Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}
