import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:atomai/models/user_custom_model.dart';
import 'package:atomai/services/payment_controller.dart';
import 'package:atomai/services/vibtaion_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDataController extends GetxController {
  var userCustomModel = UserCustomModel().obs;
  var user = FirebaseAuth.instance.currentUser.obs;
  var icon = ImageConstant.img1.obs;
  var paymentController = Get.put(PaymentController());

  var imgs = [
    ImageConstant.img1,
    ImageConstant.img6,
    ImageConstant.img4,
    ImageConstant.img5,
    ImageConstant.img382x82,
    ImageConstant.img7,
  ];

  Future<bool> setUserDate(UserCustomModel userModelUpdated) async {
    try {
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      await user.value!.updateDisplayName(userModelUpdated.name);
      await firebaseFirestore.doc(user.value!.uid).set(
        {
          "phoneNumber": userModelUpdated.phoneNumber,
          "name": userModelUpdated.name,
          "updatedAt": FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      getUserData();
      user(FirebaseAuth.instance.currentUser);
    } on FirebaseAuthException catch (e) {
      log("Change Name $e");
      Fluttertoast.showToast(
          msg: e.message ?? "",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      log("Change Name $e");
    }
    return true;
  }

  setPushToekn() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var firebaseFirestore = FirebaseFirestore.instance.collection("user");

    await firebaseFirestore.doc(userId).set(
      {
        "pushToken": await FirebaseMessaging.instance.getToken(),
      },
      SetOptions(merge: true),
    );
  }

  resetWordCount() async {
    await getUserData();
    if (paymentController.packageNew.value.payId == "atomai_free") {
      return;
    }
    if (paymentController.packageNew.value.type == "y") {
      try {
        log("updated${userCustomModel.value.wordCntReset}");
        DateTime wordCntReset = userCustomModel.value.wordCntReset;
        if ((DateTime.now().year - wordCntReset.year) >= 1) {
          var userId = FirebaseAuth.instance.currentUser!.uid;

          var firebaseFirestore = FirebaseFirestore.instance.collection("user");

          await firebaseFirestore.doc(userId).set(
            {
              "wordCount": 0,
              "imgCount": 0,
              "wordCntReset": FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );

          log("message");
        }
      } catch (e) {
        log(e.toString());
      }
    } else {
      try {
        log("updated${userCustomModel.value.wordCntReset}");
        DateTime wordCntReset = userCustomModel.value.wordCntReset;
        if ((DateTime.now().month - wordCntReset.month) >= 1) {
          var userId = FirebaseAuth.instance.currentUser!.uid;

          var firebaseFirestore = FirebaseFirestore.instance.collection("user");

          await firebaseFirestore.doc(userId).set(
            {
              "wordCount": 0,
              "imgCount": 0,
              "wordCntReset": FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true),
          );

          log("message");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  setFirebaseUser() async {
    user(FirebaseAuth.instance.currentUser);
  }

  Future<bool> deleteNote(String noteId) async {
    var user = FirebaseAuth.instance.currentUser!;

    var ref = FirebaseFirestore.instance.collection("user/${user.uid}/notes");
    await ref.doc(noteId).delete();
    return true;
  }

  Future<bool> deleteFolder(String folderId) async {
    var user = FirebaseAuth.instance.currentUser!;

    var ref = FirebaseFirestore.instance.collection("user/${user.uid}/folders");
    await ref.doc(folderId).delete();
    await getNotesFromId(folderId);
    return true;
  }

  Future<bool> getNotesFromId(String folderId) async {
    var user = FirebaseAuth.instance.currentUser!;

    var ref = FirebaseFirestore.instance
        .collection("user/${user.uid}/notes")
        .where("parentId", isEqualTo: folderId);
    await ref.get().then((value) async {
      for (var element in value.docs) {
        await deleteNote(element.id);
      }
    });
    return true;
  }

  Future<bool> deleteAccount() async {
    var user = FirebaseAuth.instance.currentUser!;

    try {
      var firebaseFirestoreUser = FirebaseFirestore.instance.collection("user");
      var ref =
          FirebaseFirestore.instance.collection("user/${user.uid}/folders");

      await ref.get().then((value) async {
        for (var element in value.docs) {
          await deleteFolder(element.id);
        }
      });
      await firebaseFirestoreUser.doc(user.uid).delete();
    } catch (e) {
      log(e.toString());
    }

    return true;
  }

  Future<bool> getUserData() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!;
      var firebaseFirestore = FirebaseFirestore.instance.collection("user");
      await firebaseFirestore.doc(userId.uid).get().then((document) {
        if (document.exists) {
          userCustomModel(
            UserCustomModel.fromMap(
              document.data() ?? {},
            ),
          );
        }
      });
      update();
    } catch (e) {
      log("userdata $e");
    }

    return true;
  }

  updateImg(String st) {
    icon(st);
    update();
  }

  changeProfilePic(String name) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var firebaseFirestore = FirebaseFirestore.instance.collection("user");
    updateImg(userCustomModel.value.icon ?? "");
    await Get.defaultDialog(
      cancel: Row(
        children: [
          GestureDetector(
            onTap: () {
              VibrationService.vibrate();

              Get.back();
            },
            child: Container(
              width: size.width * 0.392,
              height: 64,
              decoration: BoxDecoration(
                color: ColorConstant.gray90001,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
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

              Get.back();
              try {
                firebaseFirestore.doc(user.value!.uid).set(
                  {
                    "icon": icon.value,
                  },
                  SetOptions(merge: true),
                );
                getUserData();
                update();
              } on FirebaseAuthException catch (e) {
                log("Change Name $e");
                Fluttertoast.showToast(
                    msg: e.message ?? "",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } catch (e) {
                log("Change Name $e");
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
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: ColorConstant.gray900,
      title: name.tr,
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: size.height * 0.23,
            width: size.width * 0.7,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: imgs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    VibrationService.vibrate();

                    updateImg(imgs[index]);
                  },
                  child: Obx(
                    () => Container(
                      decoration: icon.value == imgs[index]
                          ? BoxDecoration(
                              border: Border.all(
                                width: 3.0,
                                color: Colors.white,
                              ),
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Image.asset(
                        imgs[index],
                        height: 82,
                        width: 82,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  var isDeleting = false.obs;
  Future<bool> dialogDeleteAccount() async {
    bool isDone = false;
    await Get.defaultDialog(
        cancel: Obx(
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
                    color: ColorConstant.gray90001,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
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
              isDeleting.value
                  ? SizedBox(
                      width: size.width * 0.392,
                      height: 64,
                      child: const Center(child: CircularProgressIndicator()))
                  : GestureDetector(
                      onTap: () async {
                        VibrationService.vibrate();

                        isDone = true;
                        isDeleting(true);
                        //
                        await deleteAccount();
                        await FirebaseAuth.instance.signOut();
                        isDeleting(false);
                        Get.offAllNamed(AppRoutes.onboardingScreen);
                      },
                      child: Container(
                        width: size.width * 0.392,
                        height: 64,
                        decoration: BoxDecoration(
                          color: ColorConstant.red300,
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
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: ColorConstant.gray900,
        title: "".tr,
        titleStyle: AppStyle.txtMulishRegular14.copyWith(
            letterSpacing: getHorizontalSize(0.14),
            fontSize: 16,
            color: Colors.white),
        content: Text(
          "Delete_Account".tr,
          style: AppStyle.txtMulishRegular14.copyWith(
              letterSpacing: getHorizontalSize(0.14),
              fontSize: 16,
              color: Colors.white),
        ));
    return isDone;
  }
}
