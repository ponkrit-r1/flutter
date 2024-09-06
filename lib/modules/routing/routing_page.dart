import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../routes/app_routes.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  @override
  void initState() {
    super.initState();
    navigateToInitialDestination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBgColor,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              height: 56,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LoadingAnimationWidget.waveDots(
                    color: AppColor.secondary500,
                    size: 24,
                  ),
                ),
              ),
            ),
          )),
    );
  }

  navigateToInitialDestination() {
    Future.delayed(const Duration(seconds: 2), () {
      //Get.toNamed(Routes.onboarding);
      Get.toNamed(Routes.root);
    });
  }
}
