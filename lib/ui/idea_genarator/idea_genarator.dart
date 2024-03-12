import 'dart:developer';

import 'package:atomai/app_export.dart';
import 'package:atomai/ui/idea_genarator/page/idea_prompt_page_widget.dart';
import 'package:atomai/ui/idea_genarator/widget/idea_category_widget.dart';

import '../../services/vibtaion_service.dart';
import 'controller/idea_genarator_controller.dart';

class IdeaGenarator extends StatefulWidget {
  const IdeaGenarator({super.key});

  @override
  State<IdeaGenarator> createState() => _IdeaGenaratorState();
}

class _IdeaGenaratorState extends State<IdeaGenarator> {
  var ideaGenaratorController = Get.put(IdeaGenaratorController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    startUp();
  }

  startUp() async {
    try {
      await ideaGenaratorController.getCategory();
      await ideaGenaratorController.getPrompts();
      selectedId = ideaGenaratorController.categoryCustomModelList[0].id ?? "";
      ideaGenaratorController.searchList("all");
    } catch (e) {
      log(e.toString());
    }
  }

  String selectedId = "all";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstant.gray900,
        appBar: CustomAppBar(
          leadingWidth: 48,
          leading: AppbarImage(
            height: getSize(24.00),
            width: getSize(24.00),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 24, top: 16, bottom: 16),
            onTap: () {
              Get.back();
            },
          ),
          title: Text(
            "lbl_notes".tr,
            style: AppStyle.txtMontserratAlternatesSemiBold24,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:
                        ideaGenaratorController.categoryCustomModelList.length,
                    itemBuilder: (context, index) {
                      var model = ideaGenaratorController
                          .categoryCustomModelList[index];
                      return GestureDetector(
                        onTap: () {
                          VibrationService.vibrate();

                          selectedId = model.id ?? "";
                          ideaGenaratorController.searchList(model.id ?? "");
                          setState(() {});
                        },
                        child: IdeaCategoryWidget(
                          model: model,
                          isSelected: selectedId,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IdeaPromptPageWidget(
                  id: selectedId,
                  scrollController: scrollController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
