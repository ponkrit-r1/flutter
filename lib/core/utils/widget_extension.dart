import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension WidgetExtension on Widget {
  TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  AppLocalizations? stringRes(BuildContext context) {
    return AppLocalizations.of(context);
  }
}

extension StateExtension on State {
  TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  AppLocalizations? stringRes(BuildContext context) {
    return AppLocalizations.of(context);
  }
}