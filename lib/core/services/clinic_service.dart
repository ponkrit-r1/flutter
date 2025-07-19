import 'package:get/get.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';

class ClinicService extends GetxService {
  final PetRepository petRepository;
  ClinicService(this.petRepository);

  final RxList<Clinic> clinics = RxList.empty();
  final RxBool isInitialized = false.obs;

  static final Clinic othersClinic = Clinic(
    id: -1,
    name: "Others",
    telephone: "",
    isActive: true,
  );

  Future<void> initializeClinics() async {
    if (isInitialized.value) return;

    try {
      clinics.value = await petRepository.getClinic();

      // Ensure no duplicates
      if (!clinics.any((clinic) => clinic.id == othersClinic.id)) {
        clinics.add(othersClinic);
      }

      isInitialized.value = true;
    } catch (e) {
      // Handle error if needed
    }
  }
}
