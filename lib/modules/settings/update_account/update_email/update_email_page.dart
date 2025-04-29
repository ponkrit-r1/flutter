import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({super.key}); 

  // Controller to capture email input
  //final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final String initialEmail = Get.arguments['email'] ?? '';
    final TextEditingController emailController =
        TextEditingController(text: initialEmail);

    //      usernameController.addListener(() {
    //   controller.validateUsername(usernameController.text);
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: const Text(
          'Update your e-mail',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: AppColor.homeBackground, // Set the background color here
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'E-mail',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController, // Assign controller here
              decoration: InputDecoration(
                hintText: 'info@pettagu.com',
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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Pass the email to the next page
                  final email = emailController.text;
                  try {
                    Get.toNamed(
                      Routes.update_user_otp,
                      arguments: {'email': email}, // Pass email as argument
                    );
                  } catch (e) {
                    print("Navigation error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF2563EB), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue OTP verification',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
