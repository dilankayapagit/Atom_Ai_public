import 'package:atomai/admin/web_user_page/web_user_controller.dart';
import 'package:atomai/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/notification_model.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../utils/size_utils.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';

class WebUserPage extends StatefulWidget {
  const WebUserPage({super.key});

  @override
  State<WebUserPage> createState() => _WebUserPageState();
}

class _WebUserPageState extends State<WebUserPage> {
  var controller = Get.put(WebUserController());
  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getFcmLogs();
  }

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController img = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.isEnable(false);
          setState(() {});
        },
        child: Scaffold(
          appBar: CustomAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CustomImageView(
                  imagePath: controller.userModel.value.icon,
                  height: getVerticalSize(
                    50.00,
                  ),
                  width: getHorizontalSize(
                    50.00,
                  ),
                  fit: BoxFit.scaleDown,
                  margin: EdgeInsets.zero,
                ),
              ),
            ],
            centerTitle: false,
            title: Text(
              controller.userModel.value.name ?? "",
            ),
          ),
          body: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "User Details",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 15,
                          bottom: 15,
                        ),
                        child: SizedBox(
                          width: 450,
                          child: Container(
                            decoration: AppDecoration.outlineGray90001.copyWith(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 75,
                                  child: Text(
                                    controller.userModel.value.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtMulishRegular16Indigo50
                                        .copyWith(
                                      letterSpacing: getHorizontalSize(
                                        0.16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    controller.userModel.value.email ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtMulishRegular16Indigo50
                                        .copyWith(
                                      letterSpacing: getHorizontalSize(
                                        0.16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 75,
                                  child: Text(
                                    "${DateFormat.yMMMd().format(controller.userModel.value.createdAt ?? DateTime.now())} ",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtMulishRegular16Indigo50
                                        .copyWith(
                                      letterSpacing: getHorizontalSize(
                                        0.16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Messages",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: SizedBox(
                          width: 448,
                          child: ListView.builder(
                            clipBehavior: Clip.antiAlias,
                            physics: const BouncingScrollPhysics(),
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: controller.notifyList.length,
                            itemBuilder: (context, index) {
                              NotifySendModel model =
                                  controller.notifyList[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Container(
                                  decoration:
                                      AppDecoration.outlineGray90001.copyWith(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                  ),
                                  height: 40,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        child: Text(
                                          (index + 1).toString(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtMulishRegular16Indigo50
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          model.title ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtMulishRegular16Indigo50
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          model.body ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtMulishRegular16Indigo50
                                              .copyWith(
                                            letterSpacing: getHorizontalSize(
                                              0.16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${DateFormat.yMMMd().format(model.createdAt.toDate() ?? DateTime.now())} ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtMulishRegular16Indigo50
                                            .copyWith(
                                          letterSpacing: getHorizontalSize(
                                            0.16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Image.network(
                                        model.img ?? "",
                                        height: 48,
                                        width: 48,
                                        fit: BoxFit.scaleDown,
                                        errorBuilder: (a, b, c) {
                                          return const SizedBox(
                                            height: 48,
                                            width: 48,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isEnable.value)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: AppDecoration.outlineGray90001.copyWith(
                        color: ColorConstant.black900.withOpacity(0.6)),
                    child: Center(
                      child: Container(
                        height: 350,
                        width: 250,
                        decoration: AppDecoration.outlineGray90001.copyWith(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.blueGray900,
                              offset: const Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send FCM",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style:
                                  AppStyle.txtMulishRegular16Indigo50.copyWith(
                                letterSpacing: getHorizontalSize(
                                  0.16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                controller: title,
                                style: AppStyle.txtMulishRegular16Indigo50
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.16,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  hintText: "Title",
                                  hintStyle: AppStyle.txtMulishRegular16Indigo50
                                      .copyWith(
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                style: AppStyle.txtMulishRegular16Indigo50
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.16,
                                  ),
                                ),
                                controller: body,
                                decoration: InputDecoration(
                                  hintText: "Body",
                                  hintStyle: AppStyle.txtMulishRegular16Indigo50
                                      .copyWith(
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                style: AppStyle.txtMulishRegular16Indigo50
                                    .copyWith(
                                  letterSpacing: getHorizontalSize(
                                    0.16,
                                  ),
                                ),
                                controller: img,
                                decoration: InputDecoration(
                                  hintText: "Images",
                                  hintStyle: AppStyle.txtMulishRegular16Indigo50
                                      .copyWith(
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
                            controller.isPending.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
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
                                      controller.isPending(true);
                                      await controller.sendPushMessage(
                                        NotifySendModel(
                                          title: title.text,
                                          body: body.text,
                                          img: img.text,
                                        ),
                                      );
                                      controller.isEnable(false);
                                      controller.isPending(false);
                                      title = TextEditingController();
                                      body = TextEditingController();
                                      img  = TextEditingController();
                                    },
                                    child: const Text("Send"),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorConstant.floatingActionBtnColor,
            onPressed: () {
              controller.isEnable(true);
            },
            label: Text("Send Massages",
                style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                  letterSpacing: getHorizontalSize(
                    0.16,
                  ),
                )),
            icon: Icon(
              Icons.mail,
              color: ColorConstant.indigo50,
            ),
          ),
        ),
      ),
    );
  }
}
