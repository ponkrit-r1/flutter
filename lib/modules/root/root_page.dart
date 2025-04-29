import 'package:deemmi/core/theme/app_colors.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/home/home_page.dart';
import 'package:deemmi/modules/pet/list/pet_list_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:io';

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
      onWillPop: () async => false,
      child: Stack(
        children:[
     
          PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        navBarHeight: 100, //100
        items: _navBarsItems(),
        onItemSelected: _onItemSelected,
        confineInSafeArea: true,
        backgroundColor: AppColor.primary500, // เปลี่ยนพื้นหลังเป็นสีน้ำเงิน
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.zero,
          colorBehindNavBar: Colors.transparent,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        // padding: const NavBarPadding.only(top: 30 , bottom: 20), // เพิ่มระยะด้านบน button icon menu 30,20
       // padding: const NavBarPadding.symmetric(horizontal: 8, vertical:27),
         padding: Platform.isIOS 
      ? const NavBarPadding.only(top: 40, bottom: 10) // สำหรับ iOS
      : const NavBarPadding.only(top: 30, bottom: 20), // สำหรับ Android
        navBarStyle: NavBarStyle.style6,
      ),
           Positioned(
            bottom: Platform.isIOS ? 90: 60, //60// ✅ แยกค่า bottom ระหว่าง iOS และ Android เพราะสอง platform แสดงไม่เท่ากัน
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: CustomNavBarClipper(), // Color.fromARGB(255, 253, 253, 253)
              child: Container(
                height: 50, // ความสูงของพื้นหลังโค้ง 70
                color:  const Color.fromARGB(255, 253, 253, 253), // สีของ Navigation Bar
              ),
            ),
          ),
        ]
      )
      
      
    );
  }

  List<Widget> _buildScreens() {
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
      Fluttertoast.showToast(msg: "Press again to exit the app.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded, size: 30),
        title: stringRes(context)!.homeLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(150),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500), // ขนาดและสไตล์ข้อความ
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.pets_rounded, size: 30),
        title: stringRes(context)!.myPetLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(150),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.map_rounded, size: 30),
        title: stringRes(context)!.exploreLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(150),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group_rounded, size: 30),
        title: stringRes(context)!.communityLabel,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white.withAlpha(150),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ];
  }

  void _onItemSelected(int index) {
    // Logic when tab is selected
  }

  
}





class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20); // เริ่มต้นจากด้านซ้าย
    path.quadraticBezierTo(
      size.width / 2, // จุดกลางของโค้ง
      size.height - 60, // ระดับความลึกของโค้ง
      size.width, // จุดสิ้นสุดด้านขวา
      size.height - 20,
    );
    path.lineTo(size.width, 0); // ปิดกรอบด้านบนขวา
    path.lineTo(0, 0); // ปิดกรอบด้านบนซ้าย
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// import 'package:deemmi/core/theme/app_colors.dart';
// import 'package:deemmi/core/utils/widget_extension.dart';
// import 'package:deemmi/modules/home/home_page.dart';
// import 'package:deemmi/modules/pet/list/pet_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import '../../../core/domain/pet/pet_model.dart';
// import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
// import 'package:get/get.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   final PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//  final PetListController _petController = Get.find<PetListController>();
//   DateTime? currentBackPressTime;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onWillPopToastConfirmExit,
//       child: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         onItemSelected: _onItemSelected,
//         confineInSafeArea: true,
//         backgroundColor: AppColor.primary500,
//         // Default is Colors.white.
//         handleAndroidBackButtonPress: true,
//         // Default is true.
//         resizeToAvoidBottomInset: true,
//         // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//         stateManagement: true,
//         // Default is true.
//         hideNavigationBarWhenKeyboardShows: true,
//         // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//         decoration: NavBarDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           colorBehindNavBar: AppColor.primary500,
//         ),
//         popAllScreensOnTapOfSelectedTab: true,
//         popActionScreens: PopActionScreensType.all,
//         itemAnimationProperties: const ItemAnimationProperties(
//           // Navigation Bar's items animation properties.
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: const ScreenTransitionAnimation(
//           // Screen transition animation on change of selected tab.
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         padding: const NavBarPadding.all(8),
//         navBarStyle:
//             NavBarStyle.style6, // or style6
//       ),
//     );
//   }

//   _buildScreens() {
//     return [
//       const HomePage(),
//       const PetListPage(),
//       SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/empty_pet_info.webp'),
//               const SizedBox(height: 16),
//               Text(
//                 stringRes(context)!.comingSoonLabel,
//                 style: textTheme(context)
//                     .bodyLarge
//                     ?.copyWith(color: AppColor.secondaryContentGray),
//               ),
//             ],
//           ),
//         ),
//       ),
//       SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/empty_pet_info.webp'),
//               const SizedBox(height: 16),
//               Text(
//                 stringRes(context)!.comingSoonLabel,
//                 style: textTheme(context)
//                     .bodyLarge
//                     ?.copyWith(color: AppColor.secondaryContentGray),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ];
//   }

//   Future<bool> onWillPopToastConfirmExit() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       Fluttertoast.showToast(
//         msg: stringRes(context)!.pressAgainToExitTheApp,
//       );
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.home_rounded),
//         title: stringRes(context)!.homeLabel,
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Colors.white.withAlpha(155),
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.pets_rounded),
//         title: stringRes(context)!.myPetLabel,
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Colors.white.withAlpha(155),
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.map_rounded),
//         title: stringRes(context)!.exploreLabel,
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Colors.white.withAlpha(155),
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.group),
//         title: stringRes(context)!.communityLabel,
//         activeColorPrimary: Colors.white,
//         inactiveColorPrimary: Colors.white.withAlpha(155),
//       ),
//     ];
//   }

//   //TODO move logic to controller
//   // _onItemSelected(int index) async {}
//   _onItemSelected(int index) async {
//     //if (index == 1) {
//       _petController.getMyPet(); // เรียกอัปเดตข้อมูลสัตว์เลี้ยงใหม่
//     //}
//   }
// }
