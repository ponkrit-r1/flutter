import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';
import 'package:deemmi/modules/settings/account_setting/account_setting_controller.dart';
import 'package:deemmi/core/theme/app_colors.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  String _selectedLanguage = 'Thai';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'Thai';
    });
  }

  Future<void> _saveLanguagePreference(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountSettingController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAllNamed(Routes.root);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: AppColor.homeBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildLanguageSelection(),
            const SizedBox(height: 20),
            _buildAccountSection(controller),
            const SizedBox(height: 40),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Language',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildLanguageButton('Thai'),
              const SizedBox(width: 10),
              _buildLanguageButton('English'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    final isActive = _selectedLanguage == language;
    return Expanded(
      child: GestureDetector(
        onTap: () => _saveLanguagePreference(language),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? Colors.blue : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              language,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.blue : Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(AccountSettingController controller) {
    return Container(
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
      child: Obx(() {
        final profile = controller.profile;
        return Column(
          children: [
            _buildAccountSettingItem(
              'E-mail',
              profile?.email ?? '',
              onTap: () => _navigateToUpdate(Routes.update_email, {
                'email': profile?.email ?? '',
              }, controller),
            ),
            const SizedBox(height: 20),
            _buildAccountSettingItem(
              'Username',
              profile?.username ?? '',
              onTap: () => _navigateToUpdate(Routes.update_username, {
                'username': profile?.username ?? '',
              }, controller),
            ),
            const SizedBox(height: 20),
            _buildAccountSettingItem(
              'Password',
              'Change password',
              onTap: () => Get.toNamed(Routes.update_password),
            ),
            const SizedBox(height: 20),
            _buildAccountSettingItem(
              'Name',
              profile != null
                  ? '${profile.firstName} ${profile.lastName}'.trim()
                  : '',
              onTap: () => _navigateToUpdate(Routes.update_name, {
                'first_name': profile?.firstName ?? '',
                'last_name': profile?.lastName ?? '',
              }, controller),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _navigateToUpdate(String route, Map<String, String> arguments,
      AccountSettingController controller) async {
    try {
      final result = await Get.toNamed(route, arguments: arguments);
      if (result == true) {
        controller.getMyProfile();
      }
    } catch (e) {
      print("Navigation error: $e");
    }
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

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          try {
            Get.find<SignInController>().signOut();
          } catch (e) {
            print(e);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        child: const Text('Log out', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}

// import 'package:deemmi/modules/settings/account_setting/account_setting_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:deemmi/core/theme/app_colors.dart';
// import 'package:get/get.dart';
// import '../../../routes/app_routes.dart';
// import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';

// class AccountSettingPage extends StatelessWidget {
//   const AccountSettingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AccountSettingController>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Get.offAllNamed(Routes.root);
//           },
//         ),
//         title: const Text(
//           'Account settings',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         color: AppColor.homeBackground,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Obx(() {
//                 final profile = controller.profile;
//                 return Column(
//                   children: [
//                     _buildAccountSettingItem(
//                       'E-mail',
//                       profile?.email ?? '',
//                       onTap: () async {
//                         try {
//                              final result = await Get.toNamed(
//                               Routes.update_email,
//                               arguments: {
//                                 'email': profile?.email ?? '',
//                               });
//                           // If the result is true, refresh the profile
//                           if (result == true) {
//                             controller.getMyProfile();
//                           }
//                          // Get.toNamed(Routes.update_email);
//                         } catch (e) {
//                           print("Navigation error: $e");
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                  _buildAccountSettingItem(
//                       'Username',
//                       profile?.username ?? '',
//                       onTap: () async {
//                         try {
//                           // Wait for the result from UpdateUsernamePage
//                           final result = await Get.toNamed(
//                               Routes.update_username,
//                               arguments: {
//                                 'username': profile?.username ?? '',
//                               });

//                           // If the result is true, refresh the profile
//                           if (result == true) {
//                             controller.getMyProfile();
//                           }
//                         } catch (e) {
//                           print("Navigation error: $e");
//                         }
//                       },
//                     ),

//                     const SizedBox(height: 20),
//                     _buildAccountSettingItem(
//                       'Password',
//                       'Change password',
//                       onTap: () {
//                         try {
//                           Get.toNamed(Routes.update_password);
//                         } catch (e) {
//                           print("Navigation error: $e");
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     _buildAccountSettingItem(
//                       'Name',
//                       profile != null
//                           ? '${profile.firstName} ${profile.lastName}'.trim()
//                           : '',
//                       onTap: () async {
//                         try {

//                              final result = await Get.toNamed(
//                               Routes.update_name,
//                               arguments: {
//                                 'first_name': profile?.firstName ?? '',
//                                 'last_name': profile?.lastName ?? '',
//                               });

//                           // If the result is true, refresh the profile
//                           if (result == true) {
//                             controller.getMyProfile();
//                           }

//                          // Get.toNamed(Routes.update_name);
//                         } catch (e) {
//                           print("Navigation error: $e");
//                         }
//                       },
//                     ),
//                   ],
//                 );
//               }),
//             ),
//             const SizedBox(height: 40),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: ElevatedButton(
//                 onPressed: signOut,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.red,
//                   side: const BorderSide(color: Colors.red),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 12,
//                   ),
//                 ),
//                 child: const Text(
//                   'Log out',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAccountSettingItem(String title, String value,
//       {VoidCallback? onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[700],
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 value,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           const Icon(Icons.chevron_right,
//               color: Color.fromARGB(255, 142, 144, 142)),
//         ],
//       ),
//     );
//   }

//   void signOut() {
//     try {
//       Get.find<SignInController>().signOut();
//     } catch (e) {
//       print(e);
//     }
//     //Get.offAllNamed(Routes.signIn);
//   }
// }
