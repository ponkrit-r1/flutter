import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
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
  var isScrollToBottom = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          isScrollToBottom = true;
          setState(() {});
        }
      }
    });
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
              Expanded(
                child: const PDF()
                    .cachedFromUrl(
                      widget.termPdfUrl,
                      placeholder: (progress) =>
                          Center(child: Text('$progress %')),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),

                    )
                    .marginAll(0)
                    .paddingAll(0),
              ),
              const SizedBox(height: 16),
              // TextButton(
              //     onPressed: () {
              //       scrollController
              //           .jumpTo(scrollController.position.maxScrollExtent);
              //     },
              //     child: Text(
              //       stringRes(context)!.scrollToBottomLabel,
              //       style: textTheme(context)
              //           .bodyLarge
              //           ?.copyWith(color: AppColor.brandYellow),
              //     )),
              PrimaryButton(
                title: stringRes(context)!.iAgreeLabel,
                onPressed: isScrollToBottom
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
}
