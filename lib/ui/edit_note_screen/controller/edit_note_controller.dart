import 'dart:developer';
import 'dart:io';

import 'package:atomai/app_export.dart';
import 'package:atomai/models/note_firebase_model.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart';

import '../../../services/share_controller.dart';
import '../../../services/user_data_controller.dart';
import '../../../services/vibtaion_service.dart';
import '../../notes_home_page/controller/notes_home_controller.dart';

class EditNoteController extends GetxController {
  var titleTxtController = TextEditingController().obs;
  var focusNodeQuillEditor = FocusNode().obs;
  var controllerQuill = QuillController.basic().obs;
  var scrollController = ScrollController().obs;

  var userDataController = Get.put(UserDataController());
  var shareController = Get.put(ShareController());

  var parentId = "".obs;
  var noteFirebaseModel = NoteFirebaseModel().obs;
  var massages = <Map<String, String>>[].obs;

  uploadImg(String url) async {
    addSpace();
    final index = controllerQuill.value.selection.baseOffset;
    final length = controllerQuill.value.selection.extentOffset - index;
    controllerQuill.value
        .replaceText(index, length, BlockEmbed.image(url), null);
    addSpace();
    scrollController.value.animateTo(
      scrollController.value.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  saveNote(
      // QuillController quillController,
      ) async {
    log(controllerQuill.value.document.toPlainText());

    if (controllerQuill.value.document.toPlainText().trim().isEmpty) {
      return;
    }
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${userDataController.user.value!.uid}/notes");
      var data = jsonEncode(controllerQuill.value.document.toDelta().toJson());
      if (noteFirebaseModel.value.docId == null) {
        await ref.add(
          NoteFirebaseModel(
                  title: titleTxtController.value.text,
                  note: data,
                  updateAt: FieldValue.serverTimestamp(),
                  parentId: parentId.value == ""
                      ? userDataController.user.value!.uid
                      : parentId.value,
                  locked: locked.value,
                  pinned: pinned.value,
                  noteQuillList: massages)
              .toMap(),
        );
      } else {
        await ref.doc(noteFirebaseModel.value.docId).set(
              NoteFirebaseModel(
                title: titleTxtController.value.text,
                note: data,
                updateAt: FieldValue.serverTimestamp(),
                parentId: parentId.value == ""
                    ? noteFirebaseModel.value.parentId
                    : parentId.value,
                locked: locked.value,
                pinned: pinned.value,
                noteQuillList: massages,
              ).toMap(),
              SetOptions(
                merge: true,
              ),
            );
      }
      var notesHomeController = Get.put(NotesHomeController());
      await notesHomeController.getNotes();
    } catch (e) {
      log(" Notes save$e");
    } finally {
      locked(false);
      pinned(false);
      parentId("");
      noteFirebaseModel(NoteFirebaseModel());
    }
  }

  Future<bool> dialogSelectFolder() async {
    var notesHomeController = Get.put(NotesHomeController());
    await Get.defaultDialog(
      backgroundColor: ColorConstant.gray900,
      title: "déplacer_la_note".tr,
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  VibrationService.vibrate();

                  parentId("");
                  Get.back();
                },
                child: Center(
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgFolder,
                        height: getVerticalSize(
                          30.00,
                        ),
                        width: getHorizontalSize(
                          30.00,
                        ),
                        margin: getMargin(
                          top: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No Folder",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtMulishRegular16.copyWith(
                              letterSpacing: getHorizontalSize(0.12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
                width: size.width * 0.9,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var model = notesHomeController.folderList[index];
                    return GestureDetector(
                      onTap: () {
                        VibrationService.vibrate();

                        parentId(model.folderId);
                        Get.back();
                      },
                      child: Center(
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgGroup36,
                              height: getVerticalSize(
                                30.00,
                              ),
                              width: getHorizontalSize(
                                30.00,
                              ),
                              margin: getMargin(
                                top: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  model.folderName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtMulishRegular16.copyWith(
                                    letterSpacing: getHorizontalSize(0.12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: notesHomeController.folderList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return true;
  }

  addSpace({String st = "\n"}) {
    controllerQuill.value.document
        .insert(controllerQuill.value.document.length - 1, st);
    focusNodeQuillEditor.value.nextFocus();
  }

  Future<String> saveImg(File file) async {
    Get.dialog(
        CustomBlurDialog(
          title: "Uploading Image".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    try {
      String dateTime = DateTime.now().toIso8601String();
      final storage = FirebaseStorage.instance.ref().child(
          'notes/${userDataController.user.value!.uid}/$dateTime${basename(file.path)}');
      await storage.putFile(file);
      return storage.getDownloadURL();
    } catch (e) {
      log("IMG uploader $e");
    } finally {
      Get.back();
    }
    return file.path;
  }

  setQuillControllerDoc(Document quillDocument) {
    var data = quillDocument;
    controllerQuill(QuillController.basic());
    controllerQuill.value.document = data;
    update();
  }

  var pinned = false.obs;
  setPin(bool pinned) {
    this.pinned(pinned);
    update();
  }

  var locked = false.obs;
  setLock(bool isLocked) {
    locked(isLocked);
    update();
  }

  setParentId(String parentId) {
    this.parentId(parentId);
  }

  setNoteFirebaseModel(NoteFirebaseModel noteFirebaseModel) {
    this.noteFirebaseModel(noteFirebaseModel);
    locked(noteFirebaseModel.locked);
    pinned(noteFirebaseModel.pinned);
    update();
  }

  setTitleTxtController(String txt) {
    titleTxtController(TextEditingController(text: txt));
    update();
  }

  var showFirstWidget = 0.obs;
  void toggleWidget(int num) {
    showFirstWidget(num);
  }

  setMassages(List<Map<String, String>> msg) {
    massages(msg.toList());
  }

}
