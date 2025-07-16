import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:deemmi/modules/settings/update_account/update_password/update_password_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final controller = Get.find<UpdatePasswordController>();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'Change your password',
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
            _buildPasswordField('Current password', _isCurrentPasswordVisible,
                currentPasswordController, () {
              setState(() {
                _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
              });
            }),
            const SizedBox(height: 20),
            _buildPasswordField(
                'New password', _isNewPasswordVisible, newPasswordController,
                () {
              setState(() {
                _isNewPasswordVisible = !_isNewPasswordVisible;
              });
            }),
            const SizedBox(height: 20),
            _buildPasswordField('Confirm password', _isConfirmPasswordVisible,
                confirmPasswordController, () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            }),
            const SizedBox(height: 30),
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
                      controller.changePassword(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text,
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

  Widget _buildPasswordField(String hintText, bool isPasswordVisible,
      TextEditingController controller, VoidCallback toggleVisibility) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              onPressed: toggleVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Color.fromARGB(179, 221, 219, 219)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Color.fromARGB(179, 221, 219, 219)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Color.fromARGB(179, 221, 219, 219)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
