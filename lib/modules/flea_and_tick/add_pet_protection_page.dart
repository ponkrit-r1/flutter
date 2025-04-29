import 'package:flutter/material.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_routes.dart';

class AddPetProtectionPage extends StatefulWidget {
  const AddPetProtectionPage({super.key});

  @override
  _AddPetProtectionPageState createState() => _AddPetProtectionPageState();
}

class _AddPetProtectionPageState extends State<AddPetProtectionPage> {
  final List<Map<String, String>> petProtectionItems = [
    {'name': 'B-mectin', 'image': 'assets/images/b_mectin.png'},
    {'name': 'Bravecto', 'image': 'assets/images/bravecto.png'},
    {'name': 'Canimax', 'image': 'assets/images/canimax.png'},
    {'name': 'Drontal PLUS', 'image': 'assets/images/drontal.png'},
    {'name': 'NexGard Spectra', 'image': 'assets/images/nextgard.png'},
  ];

  String? selectedProtection;
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     final PetModel petModel = Get.arguments[RouteParams.petModel];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Add pet protection',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 16),
            _buildDropdownSearch(),
            const SizedBox(height: 16),
            _buildDatePicker(),
            const SizedBox(height: 24),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeaderCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     child: Image.asset(
  //       'assets/images/flea_bg.png',
  //       width: double.infinity,
  //       fit: BoxFit.cover,
  //     ),
  //   );
  // }
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



  Widget _buildDropdownSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Select pet protection'),
          value: selectedProtection,
          onChanged: (newValue) {
            setState(() {
              selectedProtection = newValue;
            });
          },
          items: petProtectionItems.map((item) {
            return DropdownMenuItem<String>(
              value: item['name'],
              child: Row(
                children: [
                  Image.asset(item['image']!, width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(item['name']!),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('d MMM yyyy').format(selectedDate)),
            const Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () {
        // TODO: Implement add functionality
      },
      child: const Center(
        child: Text(
          'Add',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
