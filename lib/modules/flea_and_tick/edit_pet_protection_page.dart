import 'package:deemmi/core/network/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:deemmi/core/domain/pet/pet_protection_product.dart';
import 'package:deemmi/core/domain/pet/pet_protection.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../routes/app_routes.dart';
import 'pet_protection_controller.dart';

class EditPetProtectionPage extends StatefulWidget {
  const EditPetProtectionPage({super.key});

  @override
  EditPetProtectionPageState createState() => EditPetProtectionPageState();
}

class EditPetProtectionPageState extends State<EditPetProtectionPage> {
  final PetProtectionController controller = Get.put(PetProtectionController());

  late PetProtection item;
  late PetModel petModel;

  @override
  void initState() {
    super.initState();

    item = Get.arguments[RouteParams.petProtection];
    petModel = Get.arguments[RouteParams.petModel];

    controller.fetchPetProtectionItems(
      petModel.animalType == 1 ? 'dog' : 'cat',
      item: item,
    );
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit protection',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: Container(), // Hide back button
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Get.back(),
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
            _buildSaveButton(),
            // const SizedBox(height: 16),
            // _buildDeleteButton(),
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
      padding: const EdgeInsets.only(left: 12, right: 0, top: 4, bottom: 4),
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
                ),
              ),
            ],
          );
        },
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Select pet protection",
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
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

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2563EB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () async {
        await _updateProtection();
      },
      child: const Center(
        child: Text(
          'Save change',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ...now you can use 'item' anywhere in this class, including _updateProtection()
  Future<void> _updateProtection() async {
    if (controller.selectedProtection.value == null) {
      Get.snackbar('Error', 'Please select a protection product.');
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
      await controller.petRepository.updatePetProtection(
        item.id,
        controller.selectedProtection.value!.id,
        controller.selectedDate.value,
      );
      Navigator.of(context).pop(); // Remove loading
      Get.back(); // Close page after save
      Get.snackbar('Success', 'Protection updated successfully.');
    } catch (e) {
      Navigator.of(context).pop(); // Remove loading
      String errorMessage = 'Failed to add pet protection.';
      if (e is AppError &&
          e.type == AppErrorType.errorResponse &&
          e.response?['intake_date'] != null) {
        errorMessage = "Intake date cannot be in the future.";
      }

      Get.snackbar('Error', errorMessage);
    }
  }

  Widget _buildDeleteButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          _showDeleteConfirmationDialog(context);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: const Text(
          'Delete',
          style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
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
                  'Delete ${controller.selectedProtection.value?.name ?? ''} protection?',
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
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Get.snackbar('Deleted',
                              '${controller.selectedProtection.value?.name ?? ''} has been removed.');
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
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
