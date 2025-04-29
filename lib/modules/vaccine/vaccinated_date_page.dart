import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class VaccinatedDatePage extends StatefulWidget {
  const VaccinatedDatePage({super.key});

  @override
  _VaccinatedDatePageState createState() => _VaccinatedDatePageState();
}

class _VaccinatedDatePageState extends State<VaccinatedDatePage> {
  DateTime? selectedDate;
  String selectedLocation = "MJ animal health center";
  String selectedVaccineBrand = "Select vaccine brand";
  String selectedSymptom = "Normal";

  @override
  Widget build(BuildContext context) {
    print("================= Received arguments: \${Get.arguments}");

    final petModel = Get.arguments?[RouteParams.petModel];

    if (petModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Pet data is missing!")),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Vaccinated date",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "DHPPi (1st dose)",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              "Distemper, Hepatitis (Adenovirus), Parvovirus, Parainfluenza, Leptospirosis",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text("Vaccinated date", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildRoundedContainer(
              icon: Icons.calendar_today,
              hintText: selectedDate == null
                  ? "Select date"
                  : "\${selectedDate!.day} \${_monthName(selectedDate!.month)} \${selectedDate!.year}",
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 8),
            _buildRoundedContainer(icon: Icons.location_on, hintText: selectedLocation),
            const SizedBox(height: 8),
_buildRoundedDropdown(
  "Select vaccine brand", 
  ["Brand A", "Brand B", "Brand C"], 
  selectedVaccineBrand, // ✅ ใช้ตัวแปร selectedVaccineBrand แทน
  (newValue) => selectedVaccineBrand = newValue,
),
            const SizedBox(height: 16),
            const Text("Symptom after vaccine", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildRoundedDropdown(
  "Normal", 
  ["Normal", "Fever", "Cough","Other"], 
  selectedSymptom, // ✅ ใช้ตัวแปร selectedVaccineBrand แทน
  (newValue) => selectedSymptom = newValue,
),
          
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 33, 212),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Handle Save logic here
                },
                child: const Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedContainer({required IconData icon, required String hintText, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hintText,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildRoundedDropdown(String defaultValue, List<String> items, String selectedValue, Function(String) onChanged) {
  // ✅ เพิ่ม "Select vaccine brand" เข้าไปใน items หากไม่มี
  if (!items.contains(defaultValue)) {
    items.insert(0, defaultValue);
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.grey.shade300),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: DropdownButtonFormField<String>(
      value: selectedValue, // ✅ ใช้ selectedValue ที่เปลี่ยนแปลงได้
      decoration: const InputDecoration(border: InputBorder.none),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            onChanged(newValue);
          });
        }
      },
    ),
  );
}


  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}
