import 'package:flutter/material.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class Dose {
  final String title;
  final String? suggestedDate;

  Dose({required this.title, this.suggestedDate});

  // ✅ ฟังก์ชันสำหรับแปลง JSON ที่มาจาก API เป็น `Dose`
  factory Dose.fromJson(Map<String, dynamic> json) {
    return Dose(
      title: json['title'],
      suggestedDate: json['suggestedDate'],
    );
  }
}

class VaccineProgramPage extends StatefulWidget {
  const VaccineProgramPage({super.key});

  @override
  _VaccineProgramPageState createState() => _VaccineProgramPageState();
}

class _VaccineProgramPageState extends State<VaccineProgramPage> {
  final Map<String, bool> _expandedState = {};

//   final List<String> annuallyVaccineList = [
//   '2 years old',
//   '3 years old',
//   '4 years old',
//   '5 years old',
// ];

  List<Dose> doseList1 = [
    Dose(title: '1st dose', suggestedDate: 'Jan, 2024'),
    Dose(title: '2nd dose'),
    Dose(title: '3rd dose'),
    Dose(title: '4th dose'),
  ];

  List<Dose> doseList2 = [
    Dose(title: '1st dose', suggestedDate: 'Oct, 2024'),
    Dose(title: '2nd dose'),
  ];

  List<Dose> annuallyVaccineList = [
    Dose(title: '2 years old'),
    Dose(title: '3 years old'),
    Dose(title: '4 years old'),
    Dose(title: '5 years old'),
  ];

  @override
  Widget build(BuildContext context) {
    final PetModel petModel = Get.arguments[RouteParams.petModel];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/vaccine.webp', width: 32, height: 32),
            const SizedBox(width: 8),
            const Text(
              'Vaccine program',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true, // ✅ ทำให้ Scrollbar แสดงเสมอ
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWarningMessage(),
                const SizedBox(height: 16),
                _buildExpandableVaccineCard(
                  'Distemper + Parvo',
                  'Distemper, Hepatitis (Adenovirus), Parvovirus, Parainfluenza, Leptospirosis',
                  [
                    _buildDoseItem('1st dose', petModel, 'Sep, 2024'),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTabVaccineCard(
                  petModel,
                  'DHPPi',
                  'Distemper, Hepatitis (Adenovirus), Parvovirus, Parainfluenza, Leptospirosis',
                  doseList1,
                  annuallyVaccineList,
                  'assets/icons/vaccine.webp',
                ),
                const SizedBox(height: 16),
                _buildTabVaccineCard(
                  petModel,
                  'Rabies',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  doseList2,
                  annuallyVaccineList, // ✅ ใช้ annual vaccine list เหมือนกับ DHPPi
                  'assets/images/rabies.png', // ✅ ไอคอนใหม่
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'สัตว์เลี้ยงอายุต่ำกว่า 4 เดือน จำเป็นต้องได้รับวัคซีนรวมและพิษสุนัขบ้า อย่างละ 2 เข็ม',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableVaccineCard(
      String title, String description, List<Widget> doses) {
    final bool isExpanded = _expandedState[title] ?? false;

    return Card(
      color: const Color(0xFFF8FAFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading:
                Image.asset('assets/icons/vaccine.webp', width: 40, height: 40),
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              description,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            trailing: IconButton(
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _expandedState[title] = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: doses,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabVaccineCard(
      PetModel petModel,
      String title,
      String description,
      List<Dose> doseList,
      List<Dose> annualDoseList,
      String iconPath) {
    final bool isExpanded = _expandedState[title] ?? false;

    return Card(
      color: const Color(0xFFF8FAFC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(iconPath,
                width: 40, height: 40), // ✅ ไอคอนเปลี่ยนตาม param
            title: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Required',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              description,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            trailing: IconButton(
              icon: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _expandedState[title] = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: '1st year vaccine'),
                      Tab(text: 'Annually vaccine'),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 10,
                      maxHeight: _calculateHeight(doseList.length),
                    ),
                    child: TabBarView(
                      children: [
                        /// ✅ Tab 1: 1st year vaccine
                        _buildDoseListView(
                            doseList, "No vaccine program available", petModel),

                        /// ✅ Tab 2: Annually vaccine
                        _buildDoseListView(annualDoseList,
                            "No Annually program available", petModel),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoseListView(
      List<Dose> doses, String emptyMessage, PetModel petModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: doses.isEmpty
            ? Center(
                child: Text(
                  emptyMessage,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              )
            : Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  shrinkWrap: false,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: doses.length,
                  itemBuilder: (context, index) {
                    return _buildDoseItem(
                      doses[index].title,
                      petModel,
                      doses[index]
                          .suggestedDate, // ✅ ใช้ suggestedDate จาก Object
                    );
                  },
                ),
              ),
      ),
    );
  }

  double _calculateHeight(int itemCount) {
    if (itemCount == 1) {
      return MediaQuery.of(context).size.height * 0.12;
    } else if (itemCount == 2) {
      return MediaQuery.of(context).size.height * 0.25;
    } else if (itemCount == 3) {
      return MediaQuery.of(context).size.height * 0.35;
    } else {
      return MediaQuery.of(context).size.height * 0.45;
    }
  }

  Widget _buildDoseItem(String doseTitle, PetModel petModel,
      [String? suggestedDate, bool isAppointed = false]) {
    bool shouldShowSuggestedDate =
        doseTitle.toLowerCase().contains("1st dose") || isAppointed;

    return Container(
      padding: const EdgeInsets.all(7), // ✅ ป้องกัน Overflow
      margin: const EdgeInsets.symmetric(
          vertical: 1), // ✅ ให้มีช่องว่างเล็กน้อยระหว่าง Dose
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // ✅ จัดให้ทุกอย่างอยู่ชิดซ้าย
        children: [
          // ✅ Dose Title + Suggested Date (แสดงเฉพาะ item แรก หรือที่จอง)
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  shouldShowSuggestedDate && suggestedDate != null
                      ? "$doseTitle (Suggest date: $suggestedDate)"
                      : doseTitle,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 1), // ✅ ลดระยะห่างให้พอดี
          // ✅ Make Appointment + Vaccination Date
          Padding(
            padding:
                const EdgeInsets.only(left: 20), // ✅ จัดให้ชิดซ้ายเหมือน Dose
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    print(
                        "==========================Navigating to make appointment with petModel: ${petModel.toJson()}"); // ตรวจสอบค่า
                    Get.toNamed(Routes.make_appointment, arguments: {
                      RouteParams.petModel: petModel,
                    });
                  },
                  child: const Text(
                    "Make appointment",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                const Text("|", style: TextStyle(color: Colors.black38)),
                TextButton(
                  onPressed: () {
                    print(
                        "==========================Navigating to vaccinated_page with petModel: ${petModel.toJson()}"); // ตรวจสอบค่า
                    Get.toNamed(Routes.vaccinated_date, arguments: {
                      RouteParams.petModel: petModel,
                    });
                  },
                  child: const Text(
                    "Vaccination date",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:deemmi/core/domain/pet/pet_model.dart';
// import 'package:get/get.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../routes/app_routes.dart';

// class VaccineProgramPage extends StatefulWidget {
//   @override
//   _VaccineProgramPageState createState() => _VaccineProgramPageState();
// }

// class _VaccineProgramPageState extends State<VaccineProgramPage> {
//   final Map<String, bool> _expandedState = {}; // เก็บสถานะ Expand/Collapse

//   @override
//   Widget build(BuildContext context) {
//     final PetModel petModel = Get.arguments[RouteParams.petModel];

//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.white, // ✅ ทำให้ AppBar เป็นพื้นหลังสีขาว
//   centerTitle: true, // ✅ ทำให้ Title อยู่ตรงกลาง
//   elevation: 0, // ✅ เอาเงาออก
//     flexibleSpace: Container(
//     decoration: const BoxDecoration(
//       color: Colors.white, // ✅ กำหนดให้เป็นสีขาว 100%
//     ),
//   ),
//         title: Row(
//           children: [
//             Image.asset('assets/icons/vaccine.webp', width: 32, height: 32), // ✅ ขยายไอคอนวัคซีนให้ใหญ่ขึ้น
//             const SizedBox(width: 8),
//      const Text(
//       'Vaccine program',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black, // ✅ กำหนดให้ข้อความเป็นสีดำ
//       ),
//     ),
//           ],
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildWarningMessage(),
//               const SizedBox(height: 16),
//               _buildExpandableVaccineCard(
//                 'Distemper + Parvo',
//                 'Distemper, Hepatitis (Adenovirus), Parvovirus, Parainfluenza, Leptospirosis',
//                 [
//                   _buildDoseItem('1st dose', 'Sep, 2024'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWarningMessage() {
//     return Container(
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: Colors.red[100],
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.warning, color: Colors.red),
//           const SizedBox(width: 8),
//           Expanded(
//             child: const Text(
//               'สัตว์เลี้ยงอายุต่ำกว่า 4 เดือน จำเป็นต้องได้รับวัคซีนรวมและพิษสุนัขบ้า อย่างละ 2 เข็ม',
//               style: TextStyle(color: Colors.red, fontSize: 14),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildExpandableVaccineCard(
//       String title, String description, List<Widget> doses) {
//     final bool isExpanded = _expandedState[title] ?? false;

//     return Card(
//       color: Colors.grey[100],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 3,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         children: [
//           ListTile(
//             leading: Image.asset('assets/icons/vaccine.webp', width: 40, height: 40), // ✅ ขยายไอคอนวัคซีน
//             title: Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               description,
//               style: const TextStyle(color: Colors.black54, fontSize: 14),
//             ),
//             trailing: IconButton(
//               icon: Icon(
//                 isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                 color: Colors.grey,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _expandedState[title] = !isExpanded;
//                 });
//               },
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           ),
//           AnimatedSize(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             child: isExpanded
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(children: doses),
//                         const SizedBox(height: 10),
//                       ],
//                     ),
//                   )
//                 : Container(),
//           ),
//         ],
//       ),
//     );
//   }

// Widget _buildDoseItem(String doseTitle, [String? suggestedDate]) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5.0), // ✅ ลด padding vertical ให้ compact ขึ้น
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ✅ Dose Box ที่มีพื้นหลังสีขาว + มุมโค้งมน
//         Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: Colors.white, // ✅ พื้นหลังสีขาว
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ✅ Dose Title + Suggested Date
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.check_circle, color: Colors.grey),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: RichText(
//                       text: TextSpan(
//                         style: const TextStyle(fontSize: 16, color: Colors.black),
//                         children: [
//                           TextSpan(
//                             text: doseTitle,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           if (suggestedDate != null) ...[
//                             const TextSpan(
//                               text: '  (Suggest date: ',
//                               style: TextStyle(fontSize: 14, color: Colors.black54),
//                             ),
//                             TextSpan(
//                               text: suggestedDate,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const TextSpan(
//                               text: ')',
//                               style: TextStyle(fontSize: 14, color: Colors.black54),
//                             ),
//                           ]
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 2), // ✅ ลดระยะห่างระหว่าง 2 บรรทัดให้น้อยลง
//               // ✅ Make Appointment + Vaccination Date อยู่ในกล่องสีขาวและ align ซ้าย
//               Align(
//                 alignment: Alignment.centerLeft, // ✅ จัดให้ชิดซ้ายเหมือน doseTitle
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 26), // ✅ จัดระยะให้ตรงกับ doseTitle
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'Make appointment',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         '|',
//                         style: TextStyle(color: Colors.black38, fontSize: 14),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'Vaccination date',
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// }
