import 'package:atomai/admin/web_add_promts/web_add_prompt_controller.dart';
import 'package:atomai/admin/web_add_promts/web_add_prompts_dialogs.dart';

import '../../app_export.dart';

class WebAddPrompt extends StatefulWidget {
  const WebAddPrompt({super.key});

  @override
  State<WebAddPrompt> createState() => _WebAddPromptState();
}

class _WebAddPromptState extends State<WebAddPrompt> {
  var controller = Get.put(WebAddPromptController());
  var webAddPromptsDialogs = Get.put(WebAddPromptsDialogs());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Add Prompts"),
        actions: [
          TextButton(
            onPressed: () {
              webAddPromptsDialogs.categoryDialog();
            },
            child: Text(
              "Add Category",
              style: AppStyle.txtPoppinsMedium16.copyWith(
                letterSpacing: getHorizontalSize(0.30),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              webAddPromptsDialogs.addPromptDialog();
            },
            child: Text(
              "Add Prompts",
              style: AppStyle.txtPoppinsMedium16.copyWith(
                letterSpacing: getHorizontalSize(0.30),
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text("Prompts", style: AppStyle.txtPoppinsMedium16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      width: 700,
                      height: size.height * 0.8,
                      child: SingleChildScrollView(
                        child: DataTable(

                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                                label: SizedBox(
                              width: 50,
                              child: Text('Icon',
                                  style: AppStyle.txtPoppinsMedium16),
                            )),
                            DataColumn(
                                label: SizedBox(
                              width: 50,
                              child: Text('Category',
                                  style: AppStyle.txtPoppinsMedium16),
                            )),
                            DataColumn(
                                label: SizedBox(
                              width: 50,
                              child: Text('Title',
                                  style: AppStyle.txtPoppinsMedium16),
                            )),
                            DataColumn(
                                label: SizedBox(
                              width: 50,
                              child: Text('Prompt',
                                  style: AppStyle.txtPoppinsMedium16),
                            )),
                            DataColumn(
                                label: SizedBox(
                              width: 50,
                              child: Text('Delete',
                                  style: AppStyle.txtPoppinsMedium16),
                            )),
                          ],
                          rows: List<DataRow>.generate(
                              controller.promptsCustomModelList.length, (index) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 50,
                                    child: CustomImageView(
                                      url: controller
                                          .promptsCustomModelList[index].imgUrl,
                                      height: getVerticalSize(
                                        30.00,
                                      ),
                                      width: getHorizontalSize(
                                        30.00,
                                      ),
                                      fit: BoxFit.scaleDown,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                DataCell(GestureDetector(
                                  onTap: () {
                                    webAddPromptsDialogs.setCategoryDialog(
                                        controller.promptsCustomModelList[index]);
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    child: Text(
                                        (controller.promptsCustomModelList[index]
                                                    .categoryName ??
                                                "")
                                            .toString(),
                                        style: AppStyle.txtPoppinsMedium16
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant
                                                    .floatingActionBtnColor)),
                                  ),
                                )),
                                DataCell(GestureDetector(
                                  onTap: () {
                                    webAddPromptsDialogs.setCategoryDialog(controller
                                            .promptsCustomModelList[
                                        index]); // webAddPromptsDialogs.pomptDialog(
                                    //     controller.promptsCustomModelList[index]);
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    child: Text(
                                        (controller.promptsCustomModelList[index]
                                                    .title ??
                                                "")
                                            .toString(),
                                        style: AppStyle.txtPoppinsMedium16
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant
                                                    .floatingActionBtnColor)),
                                  ),
                                )),
                                DataCell(GestureDetector(
                                  onTap: () {
                                    // webAddPromptsDialogs.pomptDialog(
                                    //     controller.promptsCustomModelList[index]);
                                    webAddPromptsDialogs.setCategoryDialog(
                                        controller.promptsCustomModelList[index]);
                                  },
                                  child: SizedBox(
                                    width: 70,
                                    child: Text(
                                        (controller.promptsCustomModelList[index]
                                                    .prompt ??
                                                "")
                                            .toString(),
                                        style: AppStyle.txtPoppinsMedium16
                                            .copyWith(
                                                overflow: TextOverflow.ellipsis,
                                                color: ColorConstant
                                                    .floatingActionBtnColor)),
                                  ),
                                )),
                                DataCell(SizedBox(
                                  width: 20,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      controller.deletePrompts(controller
                                          .promptsCustomModelList[index]);
                                    },
                                  ),
                                )),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: size.width * 0.1,
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text("Category", style: AppStyle.txtPoppinsMedium16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      width: size.width * 0.2,
                      height: size.height * 0.8,
                      child: SingleChildScrollView(
                        child: DataTable(
                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                                label: Text('Category',
                                    style: AppStyle.txtPoppinsMedium16)),
                            DataColumn(
                                label: Text('Delete',
                                    style: AppStyle.txtPoppinsMedium16)),
                          ],
                          rows: List<DataRow>.generate(
                              controller.categoryCustomModelList.length, (index) {
                            return DataRow(
                              cells: [
                                DataCell(GestureDetector(
                                  onTap: () {
                                    webAddPromptsDialogs.categoryDialog(
                                        categoryCustomModelTemp: controller
                                            .categoryCustomModelList[index]);
                                  },
                                  child: Text(
                                      (controller.categoryCustomModelList[index]
                                                  .name ??
                                              "")
                                          .toString(),
                                      style: AppStyle.txtPoppinsMedium16.copyWith(
                                          color: ColorConstant
                                              .floatingActionBtnColor)),
                                )),
                                DataCell(IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    controller.deleteCategory(controller
                                        .categoryCustomModelList[index]);
                                  },
                                )),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
