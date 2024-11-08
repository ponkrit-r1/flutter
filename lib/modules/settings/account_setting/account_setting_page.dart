import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          //onPressed: () => Navigator.pop(context),
           onPressed: () {
            Get.offAllNamed(Routes
                .root); 
          },
        ),
        title: const Text(
          'Account settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: AppColor.homeBackground,// Set your desired background color here
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildAccountSettingItem(
                    'E-mail',
                    'info@pettagu.com',
                    onTap: () {
                      try {
                        Get.toNamed(Routes.update_email);
                      } catch (e) {
                        print("Navigation error: $e");
                      }
                    },
                  ),
                 // const Divider(),
                 const SizedBox(height: 20),
                  _buildAccountSettingItem(
                    'Username',
                    'Admin',
                    onTap: () {
                      try {
                        Get.toNamed(Routes.update_username);
                      } catch (e) {
                        print("Navigation error: $e");
                      }
                    },
                  ),
                 // const Divider(),
                 const SizedBox(height: 20),
                  _buildAccountSettingItem(
                    'Password',
                    'Change password',
                    onTap: () {
                      try {
                        Get.toNamed(Routes.update_password);
                      } catch (e) {
                        print("Navigation error: $e");
                      }
                    },
                  ),
                 // const Divider(),
                  const SizedBox(height: 20),
                  _buildAccountSettingItem(
                    'Name',
                    'Pet Tagu',
                    onTap: () {
                      try {
                        Get.toNamed(Routes.update_name);
                      } catch (e) {
                        print("Navigation error: $e");
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: signOut,
                // onPressed: () {
                //     // signOut();
                //     //Get.offAllNamed(Routes.signIn);
                // },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Log out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettingItem(String title, String value,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right,
              color: Color.fromARGB(255, 142, 144, 142)),
        ],
      ),
    );
  }

 void signOut() {
   try {
       Get.find<SignInController>().signOut();
    } catch (e) {
      print(e);
    }
    //Get.offAllNamed(Routes.signIn);
  }


}
