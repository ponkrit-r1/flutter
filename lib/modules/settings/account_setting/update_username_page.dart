import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart'; // Update with the correct path to AppColor

class UpdateUsernamePage extends StatelessWidget {
  const UpdateUsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColor.homeBackground, // Use the custom background color
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
  decoration: InputDecoration(
    hintText: 'Admin',
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Color.fromARGB(179, 221, 219, 219)), 
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color:  Color.fromARGB(179, 221, 219, 219)), 
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Color.fromARGB(179, 221, 219, 219)), 
    ),
    filled: true,
    fillColor: Colors.white, 
  ),
),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add save functionality here
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
