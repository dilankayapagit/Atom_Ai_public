// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../utils/size_utils.dart';
import 'app_bar/appbar_image.dart';
import 'app_bar/appbar_subtitle_2.dart';
import 'app_bar/custom_app_bar.dart';

class WebSitesPage extends StatefulWidget {
  const WebSitesPage({
    Key? key,
    required this.url,
    required this.name,
  }) : super(key: key);
  final String url;
  final String name;
  @override
  State<WebSitesPage> createState() => _WebSitesPageState();
}

class _WebSitesPageState extends State<WebSitesPage> {
  var controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorConstant.gray900)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorConstant.gray900)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(56.00),
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
        title:
            AppbarSubtitle2(text: widget.name.tr, margin: getMargin(left: 12)),
      ),
      backgroundColor: ColorConstant.gray900,
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
