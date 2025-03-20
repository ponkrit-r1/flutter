import 'package:get/get.dart';

import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/clinic.dart';
import '../../../core/domain/pet/health/pet_health_info.dart';
import '../../../core/domain/pet/pet_clinic.dart';
import '../../../core/domain/pet/pet_model.dart';

class PetProfileController extends GetxController {
  final PetRepository petRepository;
  final PetModel petModel;

  late Rx<PetModel> _displayPetModel;

  PetModel get displayPetModel => _displayPetModel.value;

  final Rxn<PetHealthInfo> _healthInfo = Rxn();

  PetHealthInfo? get healthInfo => _healthInfo.value;

  final RxList<PetClinic> _petClinics = RxList.empty();

  List<PetClinic> get petClinics => _petClinics;

  final RxBool _expandHealthInfoSection = false.obs;

  bool get expandHealthInfoSection => _expandHealthInfoSection.value;

  final RxBool _expandClinicSection = false.obs;

  bool get expandClinicSection => _expandClinicSection.value;

@override
void onInit() { //add 19 mar
  super.onInit();

  // ✅ ดึงข้อมูลสัตว์เลี้ยงล่าสุด
  getHealthInfoData();
  getClinicInformation();
}


  @override
  onReady() {
    super.onReady();
    getBreedInfo();
    getHealthInfoData();
    getClinicInformation();
  }

  PetProfileController({
    required this.petModel,
    required this.petRepository,
  }) {
    _displayPetModel = petModel.obs;
  }

  String get petName => petModel.name;

  getBreedInfo() async {
    var breeds = await petRepository.getAnimalBreed(petModel.animalType);
    petModel.assignBreedInfo(breeds);
    _displayPetModel.value = petModel;
  }

  getHealthInfoData() async {
    _healthInfo.value = await petRepository.getPetHealthInfo(petModel);
  }

  getClinicInformation() async {
    var availableClinic = await petRepository.getClinic();
    getPetClinic(availableClinic);
  }

  getPetClinic(List<Clinic> clinics) async {
    var response = await petRepository.getPetClinicById(petModel.id!);
    for (var element in response) {
      element.assignPetClinic(clinics);
    }
    _petClinics.value = response;
  }

  onToggleHealthInfoSection() {
    _expandHealthInfoSection.value = !expandHealthInfoSection;
  }

  onToggleClinicSection() {
    _expandClinicSection.value = !expandClinicSection;
  }



  setDisplaySetModel(PetModel petModel) { //ใช้ได้ ปกติ mar
    _displayPetModel.value = petModel;


//====new for selected pet mar ====//
    petModel = petModel;
  getHealthInfoData();
  getClinicInformation();
  // ✅ Refresh เฉพาะ Clinic Section
  _petClinics.refresh();
  //end new 
  }
}
