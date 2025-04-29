import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/global_widgets/secondary_button.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String description;
  final String confirmText;
  final Widget? topWidget;
  final bool hideCancel;
  final Color confirmColor;

  const ConfirmDialog(
      {Key? key,
      required this.onConfirm,
      required this.title,
      required this.description,
      required this.confirmText,
      this.topWidget,
      this.hideCancel = false,
      this.confirmColor = AppColor.redError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            if (topWidget != null) ...[topWidget!, const SizedBox(height: 24)],
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.textColor, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColor.secondaryContentGray),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!hideCancel)
                    Expanded(
                      child: SecondaryButton(
                        child: Text(AppLocalizations.of(context)!.cancelLabel),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      title: confirmText,
                      onPressed: () {
                        onConfirm();
                        Get.back();
                      },
                      color: confirmColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
