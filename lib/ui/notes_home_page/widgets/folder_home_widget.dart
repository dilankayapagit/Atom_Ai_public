import 'package:atomai/app_export.dart';

import '../../../models/folder_custom_model.dart';

class FolderHomeWidget extends StatelessWidget {
  const FolderHomeWidget(this.folderCustomModel, {super.key});

  final FolderCustomModel folderCustomModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(
        left: 32,
        top: 17,
        right: 32,
        bottom: 14,
      ),
      decoration: AppDecoration.fillBluegray8004c01.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup36,
              height: getVerticalSize(
                75.00,
              ),
              width: getHorizontalSize(
                89.00,
              ),
              margin: getMargin(
                top: 30,
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              top: 24,
            ),
            child: Text(
              folderCustomModel.folderName ?? "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMulishRegular16Indigo50.copyWith(
                letterSpacing: getHorizontalSize(
                  0.16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
