import 'dart:io';

import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBgColor,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: Get.width / 3,
                  child: Image.asset('assets/icons/noInternet.webp')),
              const SizedBox(height: 16),
              Text(
                'No internet connection',
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(color: AppColor.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Please connect to the internet and try to connect again.',
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(color: AppColor.secondaryContentGray),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  checkAndRetry();
                },
                child: Text(
                  'Try again',
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: AppColor.primary500),
                ),
              )
            ],
          )),
    );
  }

  checkAndRetry() async {
    if (await hasNetwork()) {
      Get.offAllNamed(Routes.routing);
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
