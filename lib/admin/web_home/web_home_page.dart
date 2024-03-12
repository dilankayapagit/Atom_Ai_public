import 'package:atomai/admin/web_router.dart';

import '../../app_export.dart';
import 'home_page_controller.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  var controller = Get.put(HomePageController());
  @override
  void initState() {
    super.initState();
    controller.getUsers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.getUsers();
  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.sendNotification();
          },
          icon: const Icon(Icons.email),
          label: const Text("Send massages"),
        ),
        appBar: CustomAppBar(
          actions: [
            TextButton(
              onPressed: () {
                controller.chnageKeyDialog();
              },
              child: Text(
                "Chnage Keys",
                style: AppStyle.txtPoppinsMedium16.copyWith(
                  letterSpacing: getHorizontalSize(0.30),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(
                    "${WebRouters.webHomePage}${WebRouters.webAddPrompt}");
              },
              child: Text(
                "Add prompt",
                style: AppStyle.txtPoppinsMedium16.copyWith(
                  letterSpacing: getHorizontalSize(0.30),
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgLogoatomai,
              height: getVerticalSize(
                50.00,
              ),
              width: getHorizontalSize(
                50.00,
              ),
              fit: BoxFit.scaleDown,
              margin: EdgeInsets.zero,
            ),
            Text(
              "Users ${controller.userModelList.length}",
              style: AppStyle.txtPoppinsMedium16.copyWith(
                letterSpacing: getHorizontalSize(0.30),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          title: const Text(
            "Home",
            //style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            height: size.height * 0.8,
            width: size.width * 0.8,
            child: SingleChildScrollView(
              child: DataTable(
                showBottomBorder: true,
                columns: [
                  DataColumn(
                      label: Text('Icon', style: AppStyle.txtPoppinsMedium16)),
                  DataColumn(
                      label: Text('Name', style: AppStyle.txtPoppinsMedium16)),
                  DataColumn(
                      label: Text('Email', style: AppStyle.txtPoppinsMedium16)),
                  DataColumn(
                      label: Text('More', style: AppStyle.txtPoppinsMedium16)),
                ],
                rows: List<DataRow>.generate(controller.userModelList.length,
                    (index) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 50,
                          child: CustomImageView(
                            imagePath: controller.userModelList[index].icon,
                            height: getVerticalSize(
                              50.00,
                            ),
                            width: getHorizontalSize(
                              50.00,
                            ),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      DataCell(SizedBox(
                        width: 150,
                        child: Text(
                            (controller.userModelList[index].name ?? "anon")
                                .toString(),
                            style: AppStyle.txtPoppinsMedium16),
                      )),
                      DataCell(SizedBox(
                        width: 150,
                        child: Text(
                            (controller.userModelList[index].email ??
                                    "anon@email.com")
                                .toString(),
                            style: AppStyle.txtPoppinsMedium16),
                      )),
                      DataCell(SizedBox(
                        width: 50,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.toNamed(
                                "${WebRouters.webHomePage}${WebRouters.webUserPage}/${controller.userModelList[index].userId}");
                          },
                        ),
                      )),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
