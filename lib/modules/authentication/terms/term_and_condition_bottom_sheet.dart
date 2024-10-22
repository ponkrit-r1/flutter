import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

class TermAndConditionBottomSheet extends StatefulWidget {
  final Function(bool) onTermAccepted;
  final String termPdfUrl;

  const TermAndConditionBottomSheet({
    super.key,
    required this.onTermAccepted,
    required this.termPdfUrl,
  });

  @override
  State<TermAndConditionBottomSheet> createState() =>
      _TermAndConditionBottomSheetState();
}

class _TermAndConditionBottomSheetState
    extends State<TermAndConditionBottomSheet> {
  PDFDocument? termDocument;
  PageController pageController = PageController();
  bool hasScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    getPdfDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close_rounded)),
              ),
              Text(
                stringRes(context)!.termAndCondition,
                style: textTheme(context).headlineLarge,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              if (termDocument != null)
                Expanded(
                  child: PDFViewer(
                    controller: pageController,
                    document: termDocument!,
                    scrollDirection: Axis.vertical,
                    showPicker: false,
                    showNavigation: false,
                    onPageChanged: (page) {
                      if (termDocument != null) {
                        hasScrollToBottom = page == (termDocument!.count - 1);
                        setState(() {});
                      }
                    },
                  ),
                ),
              const SizedBox(height: 16),
              if (termDocument != null)
                TextButton(
                    onPressed: () {
                      pageController.jumpToPage(termDocument!.count - 1);
                    },
                    child: Text(
                      stringRes(context)!.scrollToBottomLabel,
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(color: AppColor.brandYellow),
                    )),
              PrimaryButton(
                title: stringRes(context)!.iAgreeLabel,
                onPressed: hasScrollToBottom
                    ? () {
                        widget.onTermAccepted(true);
                        Get.back();
                      }
                    : null,
                color: AppColor.primary500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPdfDocument() async {
    termDocument = await PDFDocument.fromURL(widget.termPdfUrl);
    setState(() {});
  }
}
