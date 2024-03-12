import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:atomai/app_export.dart';
import 'package:atomai/models/user_custom_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/notification_model.dart';
import '../../services/get_key_from_store.dart';

class HomePageController extends GetxController {
  var userModelList = <UserCustomModel>[].obs;

  String key =
      "";
  var getKeyFromStore = Get.put(GetKeyFromStore());

  chnageKeyDialog() {
    TextEditingController openAiTokenKey =
        TextEditingController(text: getKeyFromStore.openAiToken.value);
    TextEditingController stableDiffusionTokenKey =
        TextEditingController(text: getKeyFromStore.stableDiffusionToken.value);
    Get.defaultDialog(
        backgroundColor: ColorConstant.blueGray900,
        title: "",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chnage Keys",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                letterSpacing: getHorizontalSize(
                  0.16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: openAiTokenKey,
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
                decoration: InputDecoration(
                  label: const Text("CHAT GPT"),
                  labelStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
                controller: stableDiffusionTokenKey,
                decoration: InputDecoration(
                  label: const Text("STABLE DIFFUSION"),
                  labelStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                  hintStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("key")
                    .doc("keys")
                    .set({
                  "openAiToken": openAiTokenKey.text,
                  "stableDiffusionToken": stableDiffusionTokenKey.text
                }, SetOptions(merge: true));
                await getKeyFromStore.getKey();
                Get.back();
              },
              child: const Text("Save"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              child: const Text("Back"),
            ),
          ],
        ));
  }

  sendNotification() {
    TextEditingController title = TextEditingController();
    TextEditingController body = TextEditingController();
    TextEditingController img = TextEditingController();
    Get.defaultDialog(
        backgroundColor: ColorConstant.blueGray900,
        title: "",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Send FCM",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                letterSpacing: getHorizontalSize(
                  0.16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: title,
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
                controller: body,
                decoration: InputDecoration(
                  hintText: "Body",
                  hintStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                ),
                controller: img,
                decoration: InputDecoration(
                  hintText: "Images",
                  hintStyle: AppStyle.txtMulishRegular16Indigo50.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (title.text == "" && body.text == "") {
                  Fluttertoast.showToast(
                      msg: "Please add all the details",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return;
                }

                await sendPushMessage(
                  NotifySendModel(
                    title: title.text,
                    body: body.text,
                    img: img.text,
                  ),
                );

                Get.back();
              },
              child: const Text("Send"),
            ),
          ],
        ));
  }

  String constructFCMPayload(NotifySendModel notificationSendModel) {
    List<String?> pushTokenList =
        userModelList.map((user) => user.pushToken).toList();

    return jsonEncode({
      "registration_ids": pushTokenList,
      "priority": "high",
      "notification": {
        "title": notificationSendModel.title,
        "body": notificationSendModel.body,
        "image": notificationSendModel.img,
      }
    });
  }

  Future<void> sendPushMessage(
    NotifySendModel notificationSendModel,
  ) async {
    try {
      var respone = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "key=$key"
        },
        body: constructFCMPayload(
          notificationSendModel,
        ),
      );

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

  Future<bool> getUsers() async {
    var ref = FirebaseFirestore.instance.collection("user");
    var userModelListTemp = <UserCustomModel>[];

    try {
      await ref.orderBy("createdAt", descending: true).get().then((quary) {
        for (var doc in quary.docs) {
          userModelListTemp.add(UserCustomModel.fromMap(doc.data()));
        }
      });
    } catch (e) {
      log(e.toString());
    }
    userModelList(userModelListTemp);
    update();
    return true;
  }
}
