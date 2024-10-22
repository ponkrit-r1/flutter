import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../routes/app_routes.dart';
import 'on_boarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  final _controller = Get.find<OnBoardingController>();
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBgColor,
      body: WillPopScope(
        onWillPop: onWillPopToastConfirmExit,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: Get.height * 0.61,
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (page) {
                        _controller.setCurrentPage(page);
                      },
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return getOnBoardingWidget(index);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      color: Colors.white,
                    ),
                    child: SmoothPageIndicator(
                      controller: pageController, // PageController
                      count: 3,
                      effect: WormEffect(
                        activeDotColor: AppColor.primary500,
                        dotColor: AppColor.primary500.withOpacity(0.3),
                        dotHeight: 8,
                        dotWidth: 8,
                      ), // your preferred effect
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: _primaryButton(_controller.currentPage)),
                  ),
                  SizedBox(
                    height: 40,
                    child: _skipButton(_controller.currentPage),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _primaryButton(int index) {
    String buttonLabel = "";
    VoidCallback? action;
    switch (index) {
      case 0:
      case 1:
        buttonLabel = stringRes(context)!.nextLabel;
        action = _nextPage;
      case 2:
        buttonLabel = stringRes(context)!.getStartLabel;
        action = _navigateToSignIn;
    }
    return PrimaryButton(
      title: buttonLabel,
      color: AppColor.primary500,
      onPressed: () {
        action?.call();
      },
    );
  }

  _skipButton(int index) {
    return Visibility(
      visible: index <= 1,
      maintainAnimation: true,
      maintainState: true,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInBack,
        opacity: index <= 1 ? 1 : 0,
        child: TextButton(
          onPressed: () {
            _navigateToSignIn();
          },
          child: Text(
            stringRes(context)!.skipLabel,
            style: textTheme(context)
                .bodyLarge
                ?.copyWith(color: AppColor.primary500),
          ),
        ),
      ),
    );
  }

  Widget getOnBoardingWidget(int index) {
    String title = "";
    String imagePath = "";
    String subTitle = "";
    switch (index) {
      case 0:
        title = stringRes(context)!.onboarding1Title;
        subTitle = stringRes(context)!.onboarding1Subtitle;
        imagePath = 'assets/images/onboarding_1.webp';
        break;
      case 1:
        title = stringRes(context)!.onboarding2Title;
        subTitle = stringRes(context)!.onboarding2Subtitle;
        imagePath = 'assets/images/onboarding_2.webp';
        break;
      case 2:
        title = stringRes(context)!.onboarding3Title;
        subTitle = stringRes(context)!.onboarding3Subtitle;
        imagePath = 'assets/images/onboarding_3.webp';
        break;
      default:
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme(context).displayLarge!.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 48.0,
              vertical: 24,
            ),
            child: Image.asset(
              imagePath,
            ),
          ),
          Text(
            subTitle,
            style: textTheme(context)
                .bodyLarge
                ?.copyWith(color: AppColor.secondaryContentGray),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPopToastConfirmExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: stringRes(context)!.pressAgainToExitTheApp,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  _nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  _navigateToSignIn() async {
    await _controller.setOnBoardingFinish();
    Get.toNamed(Routes.signIn);
  }
}
