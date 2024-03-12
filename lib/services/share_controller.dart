import 'dart:io';

import 'package:atomai/app_export.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class ShareController extends GetxController {
  shareFile(QuillController controllerQuill, String title,
      {bool isTextOnly = false, BuildContext? context}) async {
    final box = context!.findRenderObject() as RenderBox?;

    Get.defaultDialog(
      backgroundColor: ColorConstant.gray900,
      title: "Loading",
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
      titleStyle: AppStyle.txtMulishRegular14.copyWith(
          letterSpacing: getHorizontalSize(0.14),
          fontSize: 16,
          color: Colors.white),
    );
    if (isTextOnly) {
      final parsedString = controllerQuill.document.toPlainText();

      Share.share(
        parsedString,
        subject: title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      // Get.back();
    } else {
      final deltaOps = controllerQuill.document.toDelta().toJson();
      final converter = QuillDeltaToHtmlConverter(
        deltaOps as List<Map<String, dynamic>>,
        ConverterOptions.forEmail(),
      );
      final html = converter.convert();
      Directory tempDir = await getTemporaryDirectory();
      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
          html, tempDir.path, title);
      Share.shareXFiles(
        [XFile(generatedPdfFile.path)],
        subject: title,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      // Get.back();
    }
    Get.back();
    //await OpenFilex.open(generatedPdfFile.path);
  }
}
