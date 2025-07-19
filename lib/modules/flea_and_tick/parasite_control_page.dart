import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/modules/pet/list/pet_list_controller.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_controller.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/pet_protection.dart';
import 'package:intl/intl.dart';

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

class ParasiteControlPage extends StatefulWidget {
  const ParasiteControlPage({super.key});

  @override
  ParasiteControlPageState createState() => ParasiteControlPageState();
}

class ParasiteControlPageState extends State<ParasiteControlPage> {
  final controller = Get.find<PetProfileController>();
  final PetListController _petController = Get.find<PetListController>();

  final PetRepository petRepository = PetRepository(PetAPI(
    Get.find(),
    Get.find(),
  ));

  // Remove mock data, use dynamic data instead
  // final Map<int, List<Map<String, String>>> historyData = { ... };

  // เก็บสถานะ Expand/Collapse ของแต่ละปี
  final Map<int, bool> expandedYears = {};

  List<PetProtection> _activeProtections = [];
  List<PetProtection> _activeProtectionCategories = [];
  Map<int, List<PetProtection>> _historyProtectionsByYear = {};
  bool _loadingActiveProtections = true;

  List<ParasiteCategory> get categories {
    final petAnimalType = controller.petModel.animalType;

    // Build parasites list for Gastrointestinal
    final gastrointestinalParasites = [
      'Roundworm',
      'Hookworm',
      'Whipworm',
      'Tapeworm',
    ];

    // It is a cat
    if (petAnimalType == 2) {
      gastrointestinalParasites.remove('Whipworm');
    }

    return [
      ParasiteCategory(
        title: 'Tick, Flea',
        backgroundImage: 'assets/images/f1.png',
        parasites: ['Tick', 'Flea'],
      ),
      ParasiteCategory(
        title: 'Gastrointestinal',
        backgroundImage: 'assets/images/f3.png',
        parasites: gastrointestinalParasites,
      ),
      ParasiteCategory(
        title: 'Heartworm',
        backgroundImage: 'assets/images/f2.png',
        parasites: ['Heartworm'],
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    // No need to initialize expandedYears here, will do after fetching data
    _fetchActiveProtections();
  }

  Future<void> _fetchActiveProtections() async {
    setState(() {
      _loadingActiveProtections = true;
    });
    try {
      final petId = controller.petModel.id;
      if (petId != null) {
        final protections = await petRepository.getPetProtections(petId);
        // Split active and history
        final active = protections.where((p) => p.isActive).toList()
          ..sort((a, b) => a.product.name.compareTo(b.product.name));
        final history = protections.where((p) => !p.isActive).toList();
        // Group history by year
        final groupedByYear = <int, List<PetProtection>>{};
        for (final p in history) {
          final year = p.intakeDate.year;
          groupedByYear.putIfAbsent(year, () => []).add(p);
        }
        // Sort years descending
        final sortedGroupedByYear = Map.fromEntries(
          groupedByYear.entries.toList()
            ..sort((a, b) => b.key.compareTo(a.key)),
        );
        setState(() {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          _activeProtections = active;
          // Filter out expired protections
          _activeProtectionCategories = active
              .where((protection) =>
                  protection.expirationDate.isAfter(today) ||
                  protection.expirationDate.isAtSameMomentAs(today))
              .toList();
          _historyProtectionsByYear = sortedGroupedByYear;
          // Reset expandedYears for new years
          expandedYears.clear();
          for (var year in _historyProtectionsByYear.keys) {
            expandedYears[year] = false;
          }
        });
      }
    } catch (e) {
      print('Error fetching protections: $e');
      // handle error if needed
    } finally {
      setState(() {
        _loadingActiveProtections = false;
      });
    }
  }

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
      body: SingleChildScrollView(
        // ทำให้หน้าทั้งหน้า Scroll ได้
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
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
              const SizedBox(height: 16),
              _buildHistorySection(), // Always call, it will hide if empty
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    if (_historyProtectionsByYear.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: _historyProtectionsByYear.keys
              .map((year) => _buildYearHistory(year))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildYearHistory(int year) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedYears[year] = !(expandedYears[year] ?? false);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '$year',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 188, 185, 185),
                    thickness: 1,
                  ),
                ),
                Icon(
                  expandedYears[year] ?? false
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        if (expandedYears[year] ?? false)
          Column(
            children: _historyProtectionsByYear[year]!
                .map((item) => _buildHistoryCard(item))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildHistoryCard(PetProtection item) {
    final String title = item.product.name;
    final String image = 'assets/images/parasite_control/default.png';
    final String intakeDate = DateFormat('d MMM yyyy').format(item.intakeDate);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.contain),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Intake date: $intakeDate',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
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
                    child: Image.asset('assets/images/table_flea.png',
                        width: MediaQuery.of(Get.context!).size.width),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1, // ✅ กำหนดพื้นที่ด้านซ้าย
          child: Column(
            children: [
              _buildParasiteCategoryCard(categories[0],
                  height: 110), // Tick, Flea
              const SizedBox(height: 8),
              _buildParasiteCategoryCard(categories[2],
                  height: 100), // Heartworm
            ],
          ),
        ),
        const SizedBox(width: 8), // ✅ ระยะห่างระหว่าง Columns
        Expanded(
          flex: 1, // ✅ กำหนดพื้นที่ด้านขวา
          child: _buildParasiteCategoryCard(categories[1],
              height: 218), // Gastrointestinal
        ),
      ],
    );
  }

//   Widget _buildParasiteCategoryList() {
//     return Column(
//       children: categories.map((category) => _buildParasiteCategoryCard(category)).toList(),
//     );
//   }
  Widget _buildParasiteCategoryCard(ParasiteCategory category,
      {double height = 150}) {
    return Container(
      width: double.infinity,
      height: height, // ✅ ปรับความสูงตามที่กำหนด
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          opacity: 1.0,
          image: AssetImage(category.backgroundImage),
          fit: BoxFit.cover,
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
              children: category.parasites
                  .map((p) => Row(
                        children: [
                          (_activeProtectionCategories.any((item) =>
                                  (item.product.toJson()[p.toLowerCase()] ==
                                      true)))
                              ? const Icon(Icons.check,
                                  color: Colors.green, size: 16)
                              : const Icon(Icons.remove,
                                  color: Colors.grey, size: 16),
                          const SizedBox(width: 4),
                          Text(p, style: const TextStyle(color: Colors.black)),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildParasiteCategoryCard(ParasiteCategory category) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0), // เพิ่ม padding ซ้าย-ขวา
//     child: Container(
//       width: double.infinity, // ทำให้ Card กว้างเต็มจอ
//       height: 150,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.0),
//         image: DecorationImage(
//           opacity: 1.0,
//           image: AssetImage(category.backgroundImage),
//           fit: BoxFit.cover, // ใช้ cover เพื่อให้เต็มพื้นที่
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
//   };
  Widget _buildAddProtectionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () async {
        await Get.toNamed(Routes.add_pet_protection, arguments: {
          RouteParams.petModel: controller.petModel,
        });
        await Future.delayed(const Duration(milliseconds: 500));
        await _fetchActiveProtections(); // Refresh list after returning
      },
      child: const Center(
        child: Text(
          '+ Add pet protection',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildActiveProtectionList() {
    if (_loadingActiveProtections) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_activeProtections.isEmpty) {
      return const Center(child: Text('No active protection found.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Active protection',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: _activeProtections
              .map((item) => _buildActiveProtectionCard(item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildActiveProtectionCard(PetProtection item) {
    // You may want to map product id to image/title, here is a placeholder
    final String title = item.product.name;
    final String image = 'assets/images/parasite_control/default.png';
    final String intakeDate = DateFormat('d MMM yyyy').format(item.intakeDate);
    final String nextIntakeSuggest =
        DateFormat('d MMM yyyy').format(item.expirationDate);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.contain),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Intake date: $intakeDate\nNext intake suggest: $nextIntakeSuggest',
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () =>
                _showActionSheet(context, item), // ✅ ใช้ context ที่สร้างใหม่
          ),
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, PetProtection item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.eye, color: Colors.blue),
              title: const Text('Edit protection',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500)),
              trailing: const Icon(CupertinoIcons.chevron_forward,
                  color: Colors.blue),
              onTap: () async {
                Navigator.pop(context);
                await Get.toNamed(Routes.edit_pet_protection, arguments: {
                  RouteParams.petModel: controller.petModel,
                  RouteParams.petProtection: item,
                });
                await _fetchActiveProtections(); // Refresh after returning
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.delete, color: Colors.red),
              title: const Text('Delete',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500)),
              trailing:
                  const Icon(CupertinoIcons.chevron_forward, color: Colors.red),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmationDialog(context, item);
              },
            ),
            const Divider(),
            ListTile(
              title: const Center(
                  child: Text('Cancel',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500))),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, PetProtection item) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.delete_solid,
                    color: Colors.red, size: 50),
                const SizedBox(height: 12),
                Text(
                  'Delete protection?',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "This action can't be undone.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          try {
                            await petRepository.deletePetProtection(item.id);
                            await _fetchActiveProtections(); // Refresh list after deletion
                            Get.snackbar(
                                'Deleted', 'Protection has been removed.');
                          } catch (e) {
                            Get.snackbar(
                                'Error', 'Failed to delete protection.');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
