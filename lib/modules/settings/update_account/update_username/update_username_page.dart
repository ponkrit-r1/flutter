// update_username_page.dart
import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:deemmi/modules/settings/update_account/update_username/update_username_controller.dart';

class UpdateUsernamePage extends StatelessWidget {
  const UpdateUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateUsernameController>();
    final String initialUsername = Get.arguments['username'] ?? '';
    final TextEditingController usernameController =
        TextEditingController(text: initialUsername);

    // Add a listener to validate username on text change
    usernameController.addListener(() {
      controller.validateUsername(usernameController.text);
    });

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
          'Update username',
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
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
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
                      controller.updateUsername(usernameController.text);
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
