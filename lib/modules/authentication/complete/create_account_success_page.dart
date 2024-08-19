import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/global_widgets/primary_style_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class CreateAccountSuccessPage extends StatelessWidget {
  const CreateAccountSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary500,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Yay! 🎉",
                style: textTheme(context).displayLarge?.copyWith(
                    color: AppColor.secondary500,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                "Your account was created.",
                style: textTheme(context).headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Image.asset(
                  height: 224,
                  'assets/images/onboarding_1.webp',
                ),
              ),
              const SizedBox(height: 48),
              Text(
                "Do you want to add your pets now?",
                style: textTheme(context).headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: PrimaryStyleButton(
                  color: Colors.white,
                  onPressed: () {
                    navigateToHome(addPet: true);
                  },
                  child: Text(
                    'Let\'s go',
                    style: textTheme(context).labelLarge!.copyWith(
                        color: AppColor.primary500,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      navigateToHome();
                    },
                    child: Text(
                      'Maybe later',
                      style: textTheme(context)
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    )),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  navigateToHome({bool addPet = false}) {
    Get.offAllNamed(Routes.root);
    if (addPet) {
      Get.toNamed(Routes.addPet);
    }
  }
}
