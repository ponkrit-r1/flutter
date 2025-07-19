import 'package:deemmi/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/core/domain/pet/pet_protection_product.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_routes.dart';
import 'pet_protection_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddPetProtectionPage extends StatefulWidget {
  const AddPetProtectionPage({super.key});

  @override
  AddPetProtectionPageState createState() => AddPetProtectionPageState();
}

class AddPetProtectionPageState extends State<AddPetProtectionPage> {
  final PetProtectionController controller = Get.put(PetProtectionController());

  @override
  void initState() {
    super.initState();
    final PetModel petModel = Get.arguments[RouteParams.petModel];
    controller
        .fetchPetProtectionItems(petModel.animalType == 1 ? 'dog' : 'cat');
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Disable future dates
    );
    if (picked != null && picked != controller.selectedDate.value) {
      controller.setSelectedDate(picked);
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
            const Text(
              "Product",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => _buildDropdownSearch()),
            const SizedBox(height: 8),
            const Text(
              "Intake date",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => _buildDatePicker()),
            const SizedBox(height: 24),
            _buildAddButton(),
          ],
        ),
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

  Widget _buildDropdownSearch() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 0, top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownSearch<PetProtectionProduct>(
        items: controller.petProtectionItems,
        itemAsString: (item) => item.name,
        onChanged: (value) {
          controller.setSelectedProtection(value);
        },
        selectedItem: controller.selectedProtection.value,
        dropdownBuilder: (context, item) {
          if (item == null) {
            return const Text("Select pet protection");
          }
          return Row(
            children: [
              item.image.startsWith('http')
                  ? Image.network(item.image, width: 24, height: 24)
                  : Image.asset(item.image, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // color: Colors.blue, // Change as needed
                ),
              ),
            ],
          );
        },
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none, // <-- remove underline
            hintText: "Select pet protection",
            hintStyle: TextStyle(
              fontSize: 14, // Set your desired font size
              fontWeight: FontWeight.bold,
            ),
            // contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                item.image.startsWith('http')
                    ? Image.network(item.image, width: 24, height: 24)
                    : Image.asset(item.image, width: 24, height: 24),
                const SizedBox(width: 8),
                Text(item.name),
              ],
            ),
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search...",
            ),
          ),
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
            Text(
                DateFormat('d MMM yyyy').format(controller.selectedDate.value)),
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
      onPressed: () async {
        if (controller.selectedProtection.value == null) {
          Get.snackbar('Error', 'Please select a pet protection product.');
          return;
        }
        final PetModel petModel = Get.arguments[RouteParams.petModel];
        try {
          await controller.petRepository.addPetProtection(
            petModel.id!,
            controller.selectedProtection.value!.id,
            controller.selectedDate.value,
          );
          Get.back(); // Go back after adding
          Get.snackbar('Success', 'Pet protection added!');
        } catch (e) {
          String errorMessage = 'Failed to add pet protection.';
          if (e is AppError &&
              e.type == AppErrorType.errorResponse &&
              e.response?['intake_date'] != null) {
            errorMessage = "Intake date cannot be in the future.";
          }

          Get.snackbar('Error', errorMessage);
        }
      },
      child: const Center(
        child: Text(
          'Add',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
