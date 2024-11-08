import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/home/home_page.dart';
import 'package:deemmi/modules/pet/list/pet_list_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopToastConfirmExit,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: _onItemSelected,
        confineInSafeArea: true,
        backgroundColor: AppColor.primary500,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: AppColor.primary500,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        padding: const NavBarPadding.all(8),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }

  _buildScreens() {
    return [
      const HomePage(),
      const PetListPage(),
      SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_pet_info.webp'),
              const SizedBox(height: 16),
              Text(
                stringRes(context)!.comingSoonLabel,
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(color: AppColor.secondaryContentGray),
              ),
            ],
          ),
        ),
      ),
      SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_pet_info.webp'),
              const SizedBox(height: 16),
              Text(
                stringRes(context)!.comingSoonLabel,
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(color: AppColor.secondaryContentGray),
              ),
            ],
          ),
        ),
      ),
    ];
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

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: stringRes(context)!.homeLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.pets_rounded),
        title: stringRes(context)!.myPetLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.map_rounded),
        title: stringRes(context)!.exploreLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group),
        title: stringRes(context)!.communityLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
    ];
  }

  //TODO move logic to controller
  _onItemSelected(int index) async {}
}
