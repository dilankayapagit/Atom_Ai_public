import 'dart:developer';
import 'dart:io';

import 'package:atomai/app_export.dart';
import 'package:atomai/models/note_firebase_model.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

import '../../../models/folder_custom_model.dart';
import '../../../services/user_data_controller.dart';
import '../../../services/vibtaion_service.dart';
import '../../edit_note_screen/controller/edit_note_controller.dart';
import '../widgets/search_note_widget.dart';

class NotesHomeController extends GetxController {
  var editNoteController = Get.put(EditNoteController());
  var userDataController = Get.put(UserDataController());

  var editMode = false.obs;
  var notesList = <NoteFirebaseModel>[].obs;
  var folderList = <FolderCustomModel>[].obs;
  var notesListSearch = <NoteFirebaseModel>[].obs;

  var fileListSelect = <String>[].obs;
  var shareFileList = <XFile>[].obs;

  var floatingValueChnage = false.obs;
  var isSearch = false.obs;

  Future<bool> shareSeleted() async {
    shareFileList.clear();
    Get.dialog(
        CustomBlurDialog(
          title: "Loading".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    try {
      for (var fileId in fileListSelect) {
        for (var file in notesList) {
          if (file.docId == fileId) {
            await convertToHtml(file);
          }
        }
      }
      Get.back();
      Share.shareXFiles(shareFileList, subject: shareFileList[0].name);
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  Future<bool> convertToHtml(NoteFirebaseModel noteFirebaseModel) async {
    try {
      final deltaOps = noteFirebaseModel.noteQuill.document.toDelta().toJson();
      final converter = QuillDeltaToHtmlConverter(
        deltaOps as List<Map<String, dynamic>>,
        ConverterOptions.forEmail(),
      );
      final html = converter.convert();
      Directory tempDir = await getTemporaryDirectory();
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          html, tempDir.path, noteFirebaseModel.title ?? "");

      shareFileList.add(XFile(generatedPdfFile.path));
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  Future<bool> moveSeleted() async {
    Get.dialog(
        CustomBlurDialog(
          title: "Loading".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    for (var element in fileListSelect) {
      await moveLock(element);
    }
    await getNotes();
    parentId("");
    Get.back();
    return true;
  }

  var parentId = "".obs;

  Future<bool> moveLock(String id) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${userDataController.user.value!.uid}/notes");

      await ref.doc(id).set(
        {
          "parentId": parentId.value,
          "updateAt": FieldValue.serverTimestamp(),
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  lockSeleted() async {
    Get.dialog(
        CustomBlurDialog(
          title: "Loading".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);

    for (var element in fileListSelect) {
      await setLock(element);
    }
    await getNotes();
    fileListSelect.clear();
    Get.back();
  }

  Future<bool> setLock(String id) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${userDataController.user.value!.uid}/notes");

      await ref.doc(id).set(
        {
          "locked": true,
          "updateAt": FieldValue.serverTimestamp(),
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  pinSeleted() async {
    Get.dialog(
        CustomBlurDialog(
          title: "Loading".tr,
          child: const CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    for (var element in fileListSelect) {
      await setPin(element);
    }
    await getNotes();
    fileListSelect.clear();
    Get.back();
  }

  Future<bool> setPin(String id) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${userDataController.user.value!.uid}/notes");

      await ref.doc(id).set(
        {
          "pinned": true,
          "updateAt": FieldValue.serverTimestamp(),
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  deleteSeleted() async {
    await Get.dialog(
        CustomBlurDialog(
          btnEnable: true,
          title: "Voulez_vous_supprimer_cette_note".tr,
          child: Obx(
            () => Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    VibrationService.vibrate();
                    Get.back();
                  },
                  child: Container(
                    width: size.width * 0.392,
                    height: 64,
                    decoration: BoxDecoration(
                      color: ColorConstant.gray900,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "lbl_annuler".tr,
                        style: AppStyle.txtMulishRegular16,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: ColorConstant.gray900,
                  width: 4.8,
                ),
                isDeleting.value
                    ? SizedBox(
                        width: size.width * 0.392,
                        height: 64,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          try {
                            VibrationService.vibrate();

                            updateEditMode(false);
                            isDeleting(true);

                            for (var element in fileListSelect) {
                              await deleteNote(element);
                            }
                            await getNotes();
                          } catch (e) {
                            log(e.toString());
                          } finally {
                            fileListSelect.clear();

                            Get.back();
                            isDeleting(false);
                          }
                        },
                        child: Container(
                          width: size.width * 0.392,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "lbl_ok".tr,
                              style: AppStyle.txtPoppinsMedium16,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }

  bool selectFile(String id) {
    if (!fileListSelect.contains(id)) {
      fileListSelect.add(id);
    } else {
      fileListSelect.remove(id);
    }
    update();
    return true;
  }

  var noteTitle = "".obs;

  bool getSearchNote() {
    notesListSearch([]);
    for (var element in notesList) {
      if (element.title!.contains(noteTitle.value)) {
        notesListSearch.add(element);
      }
    }
    update();
    return true;
  }

  var folderListSearch = <FolderCustomModel>[].obs;

  bool getSearchFolder(String folderName) {
    folderListSearch([]);
    for (var element in folderList) {
      if (element.folderName!.contains(folderName)) {
        folderListSearch.add(element);
      }
    }
    update();
    return true;
  }

  String getFolderName(String folderId) {
    for (var element in folderList) {
      if (element.folderId == folderId) {
        return element.folderName ?? "";
      }
    }
    return "";
  }

  subscribeToFolders() async {
    var ref = FirebaseFirestore.instance
        .collection("user/${userDataController.user.value!.uid}/folders")
        .orderBy(
          "createAt",
          descending: true,
        );

    ref.snapshots().listen((querySnapshot) async {
      folderList.clear();
      await Future.delayed(const Duration(milliseconds: 50));

      folderList.value = querySnapshot.docs.map((doc) {
        return FolderCustomModel.fromMap(doc.data()).copyWith(
          folderId: doc.id,
        );
      }).toList();
    });
  }

  Future<bool> getFolder() async {
    // subscribeToFolders();
    // var folderListTemp = <FolderCustomModel>[];
    // var ref = FirebaseFirestore.instance
    //     .collection("user/${userDataController.user.value!.uid}/folders")
    //     .orderBy(
    //       "createAt",
    //       descending: true,
    //     );
    // try {
    //   await ref.get().then((docs) async {
    //     for (var doc in docs.docs) {
    //       folderListTemp.add(FolderCustomModel.fromMap(doc.data()).copyWith(
    //         folderId: doc.id,
    //       ));
    //     }
    //   });
    //   folderList(folderListTemp);
    // } catch (e) {
    //   log(e.toString());
    // }

    // update();
    return true;
  }

  void subscribeToChanges() async {
    var ref = FirebaseFirestore.instance
        .collection("user/${userDataController.user.value!.uid}/notes")
        .orderBy(
          "updateAt",
          descending: true,
        );

    ref.snapshots().listen((querySnapshot) async {
      var notesListTemp = <NoteFirebaseModel>[];

      notesList.clear();
      await Future.delayed(const Duration(milliseconds: 50));

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        var myJSON = await jsonDecode(data["note"]);
        notesListTemp.add(
          NoteFirebaseModel.fromMap(data).copyWith(
            docId: doc.id,
            noteQuill: QuillController(
              document: Document.fromJson(myJSON),
              selection: const TextSelection.collapsed(offset: 0),
            ),
          ),
        );
      }

      notesList.value = sortItems(notesListTemp);
      getCurrentNotesById();
      getSearchNote();
    });
  }

  Future<bool> getNotes() async {
    // var notesListTemp = <NoteFirebaseModel>[];
    // var ref = FirebaseFirestore.instance
    //     .collection("user/${userDataController.user.value!.uid}/notes")
    //     .orderBy(
    //       "updateAt",
    //       descending: true,
    //     );
    // notesList.clear();
    // try {
    //   await ref.get().then((docs) async {
    //     for (var doc in docs.docs) {
    //       var data = doc.data();
    //       var myJSON = await jsonDecode(data["note"]);
    //       notesListTemp.add(
    //         NoteFirebaseModel.fromMap(data).copyWith(
    //           docId: doc.id,
    //           // noteQuillList: setNewMap(myJSON["noteQuillList"]),
    //           noteQuill: QuillController(
    //             document: Document.fromJson(myJSON),
    //             selection: const TextSelection.collapsed(offset: 0),
    //           ),
    //         ),
    //       );
    //     }
    //   });

    //   notesList(sortItems(notesListTemp));
    //   await getCurrentNotesById();
    //   getSearchNote();
    // } catch (e) {
    //   log(e.toString());
    // }

    // update();
    return true;
  }

  // List<Map<String, String>> setNewMap(List<Map<String, dynamic>>? msg) {
  //   List<Map<String, String>> convertedList = msg!.map((originalMap) {
  //     Map<String, String> convertedMap = {};

  //     originalMap.forEach((key, value) {
  //       convertedMap[key] = value.toString(); // Convert the value to a String
  //     });
  //     return convertedMap;
  //   }).toList();
  //   print(convertedList.toString());
  //   return convertedList;
  // }

  List<NoteFirebaseModel> sortItems(List<NoteFirebaseModel> items) {
    items.sort((a, b) {
      if ((a.pinned ?? false) && !(b.pinned ?? false)) {
        return -1;
      } else if (!(a.pinned ?? false) && (b.pinned ?? false)) {
        return 1;
      } else {
        return 0;
      }
    });
    return items;
  }

  Future<bool> createFolder(FolderCustomModel folderCustomModel) async {
    var ref = FirebaseFirestore.instance
        .collection("user/${userDataController.user.value!.uid}/folders");
    try {
      await ref.add(folderCustomModel
          .copyWith(createAt: FieldValue.serverTimestamp())
          .toMap());
      await getFolder();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  Future<bool> deleteNote(String noteId) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${userDataController.user.value!.uid}/notes");
      await ref.doc(noteId).delete();
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  Future<bool> deleteFolder(String folderId) async {
    var ref = FirebaseFirestore.instance
        .collection("user/${userDataController.user.value!.uid}/folders");
    await ref.doc(folderId).delete();
    await getNotesFromId(folderId);
    return true;
  }

  Future<bool> getNotesFromId(String folderId) async {
    var ref = FirebaseFirestore.instance
        .collection("user/${userDataController.user.value!.uid}/notes")
        .where("parentId", isEqualTo: folderId);
    await ref.get().then((value) async {
      for (var element in value.docs) {
        await deleteNote(element.id);
      }
    });
    return true;
  }

  updateEditMode(bool mode) {
    editMode(mode);
    update();
  }

  Future<bool> searchDialog({int? index}) async {
    TextEditingController textEditingController = TextEditingController();
    bool isWrong = true;

    await Get.defaultDialog(
      cancel: Row(
        children: [
          GestureDetector(
            onTap: () async {
              VibrationService.vibrate();

              Get.back();
            },
            child: Container(
              width: size.width * 0.392,
              height: 64,
              decoration: BoxDecoration(
                color: ColorConstant.gray90001,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Text(
                  "lbl_annuler".tr,
                  style: AppStyle.txtPoppinsMedium16,
                ),
              ),
            ),
          ),
          Container(
            color: ColorConstant.indigo400,
            width: 4.8,
          ),
          GestureDetector(
            onTap: () async {
              VibrationService.vibrate();

              if (textEditingController.text == "") {
                Fluttertoast.showToast(
                    msg: "Please enter valid Name",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                return;
              }
              Get.off(SearchWidget(
                  name: textEditingController.text, index: index ?? 0));
            },
            child: Container(
              width: size.width * 0.392,
              height: 64,
              decoration: BoxDecoration(
                color: ColorConstant.indigo400,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Text(
                  "lbl_ok".tr,
                  style: AppStyle.txtPoppinsMedium16,
                ),
              ),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: ColorConstant.gray900,
      title: "lbl_rechercher".tr,
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: CustomTextFormField(
        width: 303,
        focusNode: FocusNode(),
        controller: textEditingController,
        hintText: "lbl_rechercher".tr,
        margin: getMargin(
          top: 29,
        ),
        validator: (value) {
          if (value == "") {
            return "Please enter valid Name";
          }
          return null;
        },
        fontStyle: TextFormFieldFontStyle.MulishRegular16,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
      ),
    );

    return isWrong;
  }

//
  var isCreatingFolder = false.obs;
  Future<bool> dialogCreateFolder() async {
    final formKey = GlobalKey<FormState>();
    TextEditingController textEditingController = TextEditingController();

    await Get.dialog(
        CustomBlurDialog(
          btnEnable: true,
          titleHeight: 20,
          title: "msg_nouveau_dossier".tr,
          child: Obx(
            () => Column(
              children: [
                Form(
                  key: formKey,
                  child: CustomTextFormField(
                    width: 303,
                    focusNode: FocusNode(),
                    controller: textEditingController,
                    hintText: "msg_nouveau_dossier".tr,
                    validator: (value) {
                      for (var folder in folderList) {
                        if (folder.folderName == textEditingController.text) {
                          return "Folder_Already_Exist".tr;
                        }
                      }
                      return null;
                    },
                    margin: getMargin(
                      top: 29,
                    ),
                    fontStyle: TextFormFieldFontStyle.MulishRegular16,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        VibrationService.vibrate();

                        Get.back();
                      },
                      child: Container(
                        width: size.width * 0.392,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorConstant.gray900,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "lbl_annuler".tr,
                            style: AppStyle.txtMulishRegular16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorConstant.gray900,
                      width: 4.8,
                    ),
                    isCreatingFolder.value
                        ? SizedBox(
                            width: size.width * 0.392,
                            height: 64,
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : GestureDetector(
                            onTap: () async {
                              VibrationService.vibrate();

                              if (formKey.currentState!.validate()) {
                                isCreatingFolder(true);
                                await createFolder(
                                  FolderCustomModel(
                                    folderName: textEditingController.text,
                                  ),
                                );
                                Get.back();
                                isCreatingFolder(false);
                              }
                            },
                            child: Container(
                              width: size.width * 0.392,
                              height: 64,
                              decoration: BoxDecoration(
                                color: ColorConstant.indigo400,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "lbl_ok".tr,
                                  style: AppStyle.txtPoppinsMedium16,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false);

    return true;
  }

  //
  var isDeleting = false.obs;

  Future<bool> dialogDelete(String id, {bool isFolder = false}) async {
    bool isDone = false;

    await Get.dialog(
        CustomBlurDialog(
          btnEnable: true,
          title: "Voulez_vous_supprimer_ce_cas".tr,
          child: Obx(
            () => Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    VibrationService.vibrate();

                    Get.back();
                  },
                  child: Container(
                    width: size.width * 0.392,
                    height: 64,
                    decoration: BoxDecoration(
                      color: ColorConstant.gray900,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "lbl_annuler".tr,
                        style: AppStyle.txtMulishRegular16,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: ColorConstant.gray900,
                  width: 4.8,
                ),
                isDeleting.value
                    ? SizedBox(
                        width: size.width * 0.392,
                        height: 64,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          VibrationService.vibrate();

                          isDone = true;
                          isDeleting(true);
                          if (isFolder) {
                            await deleteFolder(id);
                            await getFolder();
                          } else {
                            await deleteNote(id);
                          }

                          await getNotes();
                          isDeleting(false);
                          Get.back();
                        },
                        child: Container(
                          width: size.width * 0.392,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "lbl_ok".tr,
                              style: AppStyle.txtPoppinsMedium14,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        barrierDismissible: false);

    return isDone;
  }

  var folderId = "".obs;
  var noteByIdList = <NoteFirebaseModel>[].obs;

  getCurrentNotesById() {
    var noteByIdTemp = <NoteFirebaseModel>[];

    for (var note in notesList) {
      if (note.parentId == folderId.value) {
        noteByIdTemp.add(note);
      }
    }
    noteByIdList(noteByIdTemp);
    update();
  }

  resetSelected() {
    fileListSelect([]);
    update();
  }
}
