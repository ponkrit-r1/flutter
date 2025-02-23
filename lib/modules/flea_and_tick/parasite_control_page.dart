import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';

class ParasiteCategory {
  final String title;
  final String backgroundImage;
  final List<String> parasites;

  ParasiteCategory({
    required this.title,
    required this.backgroundImage,
    required this.parasites,
  });
}

class ParasiteControlPage extends StatelessWidget {
  final controller = Get.find<PetProfileController>();
  final PetListController _petController = Get.find<PetListController>();

  // Mock Data สำหรับ Active Protection
  final List<Map<String, String>> activeProtections = [
    {
      'title': 'Bravecto',
      'intakeDate': '10 Sep 2024',
      'nextIntakeSuggest': '10 Dec 2024',
      'image': 'assets/images/bravecto.png',
    },
    {
      'title': 'B-mectin',
      'intakeDate': '5 Aug 2024',
      'nextIntakeSuggest': '5 Sep 2024',
      'image': 'assets/images/b_mectin.png',
    },
    {
      'title': 'Drontal PLUS',
      'intakeDate': '15 Aug 2024',
      'nextIntakeSuggest': '15 Sep 2024',
      'image': 'assets/images/drontal.png',
    },
  ];

  final List<ParasiteCategory> categories = [
    ParasiteCategory(
      title: 'Tick, Flea',
      backgroundImage: 'assets/images/f1.png',
      parasites: ['Tick', 'Flea'],
    ),
    ParasiteCategory(
      title: 'Gastrointestinal',
      backgroundImage: 'assets/images/f3.png',
      parasites: ['Roundworm', 'Hookworm', 'Whipworm', 'Tapeworm'],
    ),
    ParasiteCategory(
      title: 'Heartworm',
      backgroundImage: 'assets/images/f2.png',
      parasites: ['Heartworm'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Parasite Control',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView( // ทำให้หน้าทั้งหน้า Scroll ได้
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(),
              const SizedBox(height: 8),
              _buildHeaderCard(),
              const SizedBox(height: 16),
              _buildParasiteCategoryList(), // เปลี่ยนให้แสดงทั้งหมด
              const SizedBox(height: 16),
              _buildAddProtectionButton(),
              const SizedBox(height: 16),
              _buildActiveProtectionList(), // แสดง Active Protection
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        'ปกป้องสัตว์เลี้ยงของคุณให้ปลอดภัย\nจากปรสิตกันเถอะ!',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return GestureDetector(
      onTap: () => _showPopup(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/flea_bg.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }


  void _showPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 600,
          ),
          child: Stack(
            children: [
              InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(1),
                minScale: 0.5,
                maxScale: 3.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                     child: Image.asset('assets/images/table_flea.png', width: MediaQuery.of(Get.context!).size.width),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildParasiteCategoryList() {
    return Column(
      children: categories.map((category) => _buildParasiteCategoryCard(category)).toList(),
    );
  }

Widget _buildParasiteCategoryCard(ParasiteCategory category) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0), // เพิ่ม padding ซ้าย-ขวา
    child: Container(
      width: double.infinity, // ทำให้ Card กว้างเต็มจอ
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          opacity: 1.0,
          image: AssetImage(category.backgroundImage),
          fit: BoxFit.cover, // ใช้ cover เพื่อให้เต็มพื้นที่
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: category.parasites.map((p) => Text('- $p', style: const TextStyle(color: Colors.black))).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
  Widget _buildAddProtectionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        Get.toNamed(Routes.add_pet_protection, arguments: {
          RouteParams.petModel: controller.petModel,
        });
      },
      child: const Center(
        child: Text(
          '+ Add pet protection',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildActiveProtectionList() {
    return activeProtections.isEmpty
        ? const Center(child: Text('No active protection found.'))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Active protection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: activeProtections.map((item) => _buildActiveProtectionCard(item)).toList(),
              ),
            ],
          );
  }

  Widget _buildActiveProtectionCard(Map<String, String> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        leading: Image.asset(item['image'] ?? '', width: 50, height: 50, fit: BoxFit.contain),
        title: Text(
          item['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Intake date: ${item['intakeDate']}\nNext intake suggest: ${item['nextIntakeSuggest']}',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      trailing: Builder(
  builder: (context) => IconButton(
    icon: const Icon(Icons.more_vert, color: Colors.black),
    onPressed: () => _showActionSheet(context, item), // ✅ ใช้ context ที่สร้างใหม่
  ),
),
      ),
    );
  }

void _showActionSheet(BuildContext context, Map<String, String> item) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: const Text('Options'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Get.toNamed(Routes.edit_pet_protection, arguments: item);
            },
            child: const Row(
              children: [
                Icon(CupertinoIcons.eye, color: Colors.blue),
                SizedBox(width: 8),
                Text('Edit protection', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true, // ทำให้เป็นปุ่มสีแดง
            onPressed: () {
              Navigator.pop(context);
              Get.snackbar('Deleted', '${item['title']} has been removed.');
            },
            child: const Row(
              children: [
                Icon(CupertinoIcons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      );
    },
  );
}

}


// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:deemmi/core/domain/pet/pet_model.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../routes/app_routes.dart';
// import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
// import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';

// class ParasiteCategory {
//   final String title;
//   final String backgroundImage;
//   final List<String> parasites;

//   ParasiteCategory({
//     required this.title,
//     required this.backgroundImage,
//     required this.parasites,
//   });
// }

// class ParasiteControlPage extends StatelessWidget {

// final controller = Get.find<PetProfileController>();

//   final PetListController _petController = Get.find<PetListController>();
//   // Mock data
//   final List<ParasiteCategory> categories = [
//     ParasiteCategory(
//       title: 'Tick, Flea',
//       backgroundImage: 'assets/images/f1.png' ?? '',
//       parasites: ['Tick', 'Flea'],
//     ),
//     ParasiteCategory(
//       title: 'Gastrointestinal',
//       backgroundImage: 'assets/images/f3.png' ?? '',
//       parasites: ['Roundworm', 'Hookworm', 'Whipworm', 'Tapeworm'],
//     ),
//     ParasiteCategory(
//       title: 'Heartworm',
//       backgroundImage: 'assets/images/f2.png' ?? '',
//       parasites: ['Heartworm'],
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//  final PetModel petModel = Get.arguments[RouteParams.petModel];
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0,
//         title: const Text(
//           'Parasite Control',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTitleSection(),
//             const SizedBox(height: 8),
//             _buildHeaderCard(),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   return _buildParasiteCategoryCard(categories[index]);
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildAddProtectionButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleSection() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.0),
//       child: Text(
//         'ปกป้องสัตว์เลี้ยงของคุณให้ปลอดภัย\nจากปรสิตกันเถอะ!',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildHeaderCard() {
//     return GestureDetector(
//       onTap: () => _showPopup(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12.0),
//             child: Image.asset(
//               'assets/images/flea_bg.png',
//               width: double.infinity,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }


//   void _showPopup() {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
//         child: Container(
//           constraints: const BoxConstraints(
//             maxWidth: 600,
//             maxHeight: 600,
//           ),
//           child: Stack(
//             children: [
//               InteractiveViewer(
//                 panEnabled: true,
//                 boundaryMargin: const EdgeInsets.all(1),
//                 minScale: 0.5,
//                 maxScale: 3.5,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                      child: Image.asset('assets/images/table_flea.png', width: MediaQuery.of(Get.context!).size.width),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.black),
//                   onPressed: () => Get.back(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//  Widget _buildParasiteCategoryCard(ParasiteCategory category) {
//     return Container(
//       height: 150,
//       margin: const EdgeInsets.symmetric(vertical: 3, horizontal:0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.0),
//         image: DecorationImage(
//           opacity: 1.0,
//           image: AssetImage(category.backgroundImage),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               category.title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: category.parasites.map((p) => Text('- $p', style: const TextStyle(color: Colors.black))).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddProtectionButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF2563EB),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//       ),
//       onPressed: () {
     
   
//       Get.toNamed(Routes.add_pet_protection, arguments: {
//          RouteParams.petModel: controller.petModel,
//       });
  
//       },
//       child: const Center(
//         child: Text(
//           '+ Add pet protection',
//           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
