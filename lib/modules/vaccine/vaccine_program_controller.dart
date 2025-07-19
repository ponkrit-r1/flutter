import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_dose.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:get/get.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';

class VaccineProgramController extends GetxController {
  final PetRepository petRepository;
  PetModel? petModel;

  VaccineProgramController(this.petRepository);

  final RxList<VaccineType> vaccineTypes = <VaccineType>[].obs;
  final RxList<PetVaccineRecord> vaccineRecords = <PetVaccineRecord>[].obs;
  final RxBool isLoading = false.obs;
  final RxMap<int, VaccineType> vaccineTypeMap = <int, VaccineType>{}.obs;
  final RxBool _hasCompletedRabiesOrDHPPiOrFVRCP = true.obs;

  bool get hasCompletedRabiesOrDHPPiOrFVRCP =>
      _hasCompletedRabiesOrDHPPiOrFVRCP.value;

  void setPetModel(PetModel model) {
    petModel = model;
    fetchVaccineTypes();
    fetchVaccineRecords();
  }

  @override
  void onInit() {
    super.onInit();
    // fetchVaccineTypes();
    // fetchVaccineRecords(); // Fetch records when the controller is initialized
  }

  Future<void> fetchVaccineTypes() async {
    isLoading.value = true;
    final types = await petRepository.getVaccineType(petModel!.animalType);
    if (petModel!.animalType == 1) {
      // For dogs, only show core vaccines
      vaccineTypes.assignAll(
          types.where((t) => t.type.toLowerCase() == 'core').toList());
    } else {
      vaccineTypes.assignAll(types);
    }
    vaccineTypeMap.assignAll({for (var type in vaccineTypes) type.id: type});
    isLoading.value = false;
  }

  void updateHasCompletedRabiesOrDHPPiOrFVRCP() {
    _hasCompletedRabiesOrDHPPiOrFVRCP.value = vaccineRecords.any((record) =>
        record.status == 'Completed' &&
        ['Rabies', 'DHPPi', 'FVRCP']
            .contains(vaccineTypeMap[record.programId]?.name));
  }

  Future<void> fetchVaccineRecords() async {
    isLoading.value = true;
    try {
      final records = await petRepository.getPetVaccineRecords(petModel!.id!);
      vaccineRecords.assignAll(records);
      updateHasCompletedRabiesOrDHPPiOrFVRCP();
    } finally {
      isLoading.value = false;
    }
  }

  List<VaccineDose> getAnnualDoses(VaccineType type) {
    // Booster doses for annual vaccines
    return type.doses
        .where((d) => d.doseType.toLowerCase() == 'booster')
        .toList();
  }

  List<VaccineDose> getFirstYearDoses(VaccineType type) {
    // Primary doses for first year
    return type.doses
        .where((d) => d.doseType.toLowerCase() == 'primary')
        .toList();
  }

  String getDescription(String typeName) {
    switch (typeName.toLowerCase()) {
      case 'dhppi':
        return 'Distemper, Hepatitis (Adenovirus), Parvovirus, Parainfluenza, Leptospirosis';
      case 'rabies':
        return 'Pets are required to receive Rabies vaccine once a year';
      case 'lepto':
        return 'Leptospirosis';
      case 'fvrcp':
        return 'Feline Viral Rhinotracheitis, Calicivirus, Panleukopenia';
      case 'felv':
        return 'Feline Leukemia Virus';
      case 'fip':
        return 'Feline Viral Rhinotracheitis, Calicivirus, Panleukopenia';
      case 'fiv':
        return 'Feline Leukemia Virus';
      default:
        return '';
    }
  }

  List<PetVaccineRecord> getRecordsForDose(int programId, int doseId) {
    return vaccineRecords
        .where((r) => r.programId == programId && r.doseId == doseId)
        .toList();
  }

  DateTime getVaccindateionMaxDate(PetVaccineRecord record) {
    var maxDate = DateTime(2101);

    final filteredRecords = vaccineRecords.where((localRecord) =>
        localRecord.programId == record.programId &&
        localRecord.doseNumber > record.doseNumber &&
        localRecord.status == 'Completed');

    if (filteredRecords.isNotEmpty) {
      final sortedRecords = filteredRecords.toList();
      sortedRecords.sort((a, b) => a.doseNumber.compareTo(b.doseNumber));
      final closestRecord = sortedRecords.first;
      maxDate = closestRecord.vaccinationDate!;
    }

    return maxDate;
  }
}
