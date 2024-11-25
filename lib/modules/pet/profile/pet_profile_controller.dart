import 'package:get/get.dart';

import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/pet_model.dart';

import '../../../core/domain/pet/clinic.dart';

class PetProfileController extends GetxController {
  final PetRepository petRepository;
  final PetModel petModel;
  var clinicDetails = <Clinic>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchClinicDetails(); // Fetch clinic details when the controller is initialized
  }

  PetProfileController({
    required this.petModel,
    required this.petRepository,
  });

  String get petName => petModel.name;

   // Method to fetch clinic details
  void fetchClinicDetails() async {
    try {
      final clinics = await petRepository.getClinic();
      clinicDetails.value = clinics; // Update the observable with fetched data
    } catch (e) {
      print('Error fetching clinic details: $e');
      clinicDetails.value = []; // Handle error by clearing the observable
    }
  }

}
