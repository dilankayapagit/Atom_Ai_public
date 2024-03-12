import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../theme/app_style.dart';

class TextEditorCustom extends StatefulWidget {
  const TextEditorCustom(
      {super.key,
      required this.controllerQuill,
      required this.scrollController,
      required this.focusNode,
      this.isReadOnly = false,
      this.showCursor = true});

  final QuillController controllerQuill;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final bool isReadOnly;
  final bool showCursor;

  @override
  State<TextEditorCustom> createState() => _TextEditorCustomState();
}


class _TextEditorCustomState extends State<TextEditorCustom> {
  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations:
          QuillConfigurations(controller: widget.controllerQuill),
      child: QuillEditor(
        focusNode: widget.focusNode,
        scrollController: widget.scrollController,
        configurations: QuillEditorConfigurations(
          enableInteractiveSelection: true,
          textSelectionControls: MaterialTextSelectionControls(),
          showCursor: widget.showCursor,
          floatingCursorDisabled: true,
          keyboardAppearance: Brightness.dark,
          readOnly: widget.isReadOnly,
          // scrollController: widget.scrollController,
          scrollable: true,
          autoFocus: true,
          // placeholder: 'Add content',
          enableSelectionToolbar: isMobile(supportWeb: false),
          expands: false,
          padding: EdgeInsets.zero,
          customStyles: DefaultStyles(
            lists: DefaultListBlockStyle(
                AppStyle.description,
                const VerticalSpacing(16, 0),
                const VerticalSpacing(0, 0),
                null,
                null),
            h1: DefaultTextBlockStyle(
                AppStyle.heading1Txt,
                const VerticalSpacing(16, 0),
                const VerticalSpacing(0, 0),
                null),
            h2: DefaultTextBlockStyle(
                AppStyle.heading2Txt,
                const VerticalSpacing(16, 0),
                const VerticalSpacing(0, 0),
                null),
            h3: DefaultTextBlockStyle(
                AppStyle.heading3Txt,
                const VerticalSpacing(16, 0),
                const VerticalSpacing(0, 0),
                null),
            paragraph: DefaultTextBlockStyle(
                AppStyle.description,
                const VerticalSpacing(16, 0),
                const VerticalSpacing(0, 0),
                null),
            sizeSmall: const TextStyle(fontSize: 9),
          ),
          embedBuilders: [
            ...FlutterQuillEmbeds.editorBuilders()
            // .builders(),
          ],
        ),
        key: UniqueKey(),
        // enableInteractiveSelection: true,
        // textSelectionControls: MaterialTextSelectionControls(),
        // showCursor: widget.showCursor,
        // floatingCursorDisabled: true,
        // keyboardAppearance: Brightness.dark,
        // controller: widget.controllerQuill,
        // readOnly: widget.isReadOnly,
        // // scrollController: widget.scrollController,
        // scrollable: true,

        // autoFocus: true,
        // placeholder: 'Add content',
        // enableSelectionToolbar: isMobile(),
        // expands: false,
        // padding: EdgeInsets.zero,
        // customStyles: DefaultStyles(
        //   lists: DefaultListBlockStyle(
        //       AppStyle.description,
        //       const VerticalSpacing(16, 0),
        //       const VerticalSpacing(0, 0),
        //       null,
        //       null),
        //   h1: DefaultTextBlockStyle(AppStyle.heading1Txt,
        //       const VerticalSpacing(16, 0), const VerticalSpacing(0, 0), null),
        //   h2: DefaultTextBlockStyle(AppStyle.heading2Txt,
        //       const VerticalSpacing(16, 0), const VerticalSpacing(0, 0), null),
        //   h3: DefaultTextBlockStyle(AppStyle.heading3Txt,
        //       const VerticalSpacing(16, 0), const VerticalSpacing(0, 0), null),
        //   paragraph: DefaultTextBlockStyle(AppStyle.description,
        //       const VerticalSpacing(16, 0), const VerticalSpacing(0, 0), null),
        //   sizeSmall: const TextStyle(fontSize: 9),
        // ),
        // embedBuilders: [
        //   ...FlutterQuillEmbeds.builders(),
        // ],
      ),
    );
  }
}
