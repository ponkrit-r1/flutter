import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:deemmi/modules/settings/update_account/update_name/update_name_controller.dart';

class UpdateNamePage extends StatelessWidget {
  const UpdateNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateNameController>();

    final String initialFirstName = Get.arguments['first_name'] ?? '';
    final String initialLastName = Get.arguments['last_name'] ?? '';

    final TextEditingController firstNameController =
        TextEditingController(text: initialFirstName);
    final TextEditingController lastNameController =
        TextEditingController(text: initialLastName);

    return Scaffold(
      backgroundColor: AppColor.homeBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Update Name',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'First Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: firstNameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[ก-ฮa-zA-Z]*$')),
              ],
              decoration: InputDecoration(
                hintText: 'Enter first name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Last Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: lastNameController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[ก-ฮa-zA-Z]*$')),
              ],
              decoration: InputDecoration(
                hintText: 'Enter last name',
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(179, 221, 219, 219)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.error.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    controller.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Obx(() {
                  if (controller.isUpdating) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      controller.updateName(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
