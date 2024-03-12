import 'dart:developer';
import 'package:atomai/models/user_custom_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:atomai/app_export.dart';

import '../../models/notification_model.dart';

class WebUserController extends GetxController {
  String key =
      "";
  var isPending = false.obs;
  var userModel = UserCustomModel().obs;
  var notifyList = <NotifySendModel>[].obs;
  var isEnable = false.obs;

  Future<bool> getFcmLogs() async {
    var notifySendModelTemp = <NotifySendModel>[];
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${Get.parameters["id"]}/notifications")
          .orderBy(
            "createdAt",
            descending: true,
          );
      await ref.get().then((value) {
        for (var doc in value.docs) {
          notifySendModelTemp.add(
            NotifySendModel.fromMap(
              doc.data(),
            ).copyWith(
              id: doc.id,
            ),
          );
        }
      });
    } catch (e) {
      log(e.toString());
    }
    notifyList(notifySendModelTemp);
    update();
    return true;
  }

  Future<bool> getUser() async {
    var ref = FirebaseFirestore.instance.collection("user");

    try {
      await ref.doc(Get.parameters["id"]).get().then(
        (quary) {
          userModel(
            UserCustomModel.fromMap(
              quary.data() as Map<String, dynamic>,
            ).copyWith(
              userId: quary.id,
            ),
          );
        },
      );
    } catch (e) {
      log(e.toString());
    }

    update();
    return true;
  }

  String constructFCMPayload(NotifySendModel notificationSendModel) {
    return jsonEncode({
      "to": userModel.value.pushToken,
      "priority": "high",
      "notification": {
        "title": notificationSendModel.title,
        "body": notificationSendModel.body,
        "image": notificationSendModel.img,
      }
    });
  }

  Future<void> sendPushMessage(NotifySendModel notificationSendModel) async {
    try {
      var respone = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "key=$key"
        },
        body: constructFCMPayload(notificationSendModel),
      );
      await fcmFirebaseLog(notificationSendModel);
      log(respone.statusCode.toString());
      //log(respone.body);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      log(e.toString());
    }
  }

  Future<bool> fcmFirebaseLog(NotifySendModel notificationSendModel) async {
    try {
      var ref = FirebaseFirestore.instance
          .collection("user/${Get.parameters["id"]}/notifications");

      await ref.add(
        notificationSendModel
            .copyWith(
              createdAt: FieldValue.serverTimestamp(),
              token: userModel.value.pushToken,
            )
            .toMap(),
      );
      await getFcmLogs();
    } catch (e) {
      log(e.toString());
    }
    return true;
  }
}
