import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/modules/pet/list/pet_list_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
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
    );
  }

  _buildScreens() {
    return [
      const SafeArea(child: Center(child: Text('Home'))),
      const PetListPage(),
      const SafeArea(child: Center(child: Text('Explore'))),
      const SafeArea(
        child: Center(child: Text('Community')),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: 'Home',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.pets_rounded),
        title: 'My pet',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.map_rounded),
        title: 'Explore',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group),
        title: 'Community',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(155),
      ),
    ];
  }

  //TODO move logic to controller
  _onItemSelected(int index) async {}
}
