import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/auth/animal_type.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/pet_health_info.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:deemmi/core/domain/pet/pet_clinic.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
import 'package:deemmi/core/domain/pet/pet_protection_product.dart';
import 'package:deemmi/core/domain/pet/pet_protection.dart';
import 'package:image_picker/image_picker.dart';

class PetRepository {
  final PetAPI petAPI;

  PetRepository(this.petAPI);

  Future<PetModel> addPet(PetModel model, XFile? file) async {
    return await petAPI.addPet(model, file);
  }

  Future<PetModel> updatePet(int petId, PetModel model, XFile? file) async {
    return await petAPI.updatePet(petId, model, file: file);
  }

  Future<List<AnimalType>> getAnimalType() async {
    return petAPI.getAnimalType();
  }

  Future<List<AnimalBreed>> getAnimalBreed(int animalType) async {
    return await petAPI.getAnimalBreed(animalType);
  }

  Future<List<PetModel>> getMyPet() async {
    return await petAPI.getMyPet();
  }

  Future<PetModel> uploadPetImage(int petId, XFile xFile) async {
    return await petAPI.uploadPetImage(petId, xFile);
  }

  Future<void> deletePet(int petId) async {
    await petAPI.deletePet(petId);
  }

  Future<dynamic> createPetClinic(PetClinic petClinic) async {
    return await petAPI.createPetClinic(petClinic);
  }

  Future<List<VaccineType>> getVaccineType(int animalType) async {
    return await petAPI.getVaccineType(animalType);
  }

  Future<List<VaccineBrand>> getVaccineBrand({int? vaccineTypeId}) async {
    return await petAPI.getVaccineBrand(vaccineTypeId: vaccineTypeId);
  }

  Future<List<VaccineBrand>> getVaccineBrands(int vaccineTypeId) async {
    try {
      return await petAPI.getVaccineBrands(vaccineTypeId: vaccineTypeId);
    } catch (e) {
      throw Exception('Error fetching vaccine brands: $e');
    }
  }

  Future<PetHealthInfo> getPetHealthInfo(PetModel petModel) async {
    return await petAPI.getPetHealthInfo(petModel);
  }

  Future<List<PetClinic>> getPetClinicById(int petId) async {
    return await petAPI.getPetClinic(petId);
  }

  Future<dynamic> updatePetHealthInfo(
    int petId,
    PetHealthInfo healthInfo,
  ) async {
    return await petAPI.updatePetHealthInfo(petId, healthInfo);
  }

  Future<List<Clinic>> getClinic() async {
    return await petAPI.getClinic();
  }

  Future<List<PetProtectionProduct>> getPetProtectionProducts(
      [String? petType]) async {
    return await petAPI.getPetProtectionProducts(petType);
  }

  Future<void> addPetProtection(
      int petId, int productId, DateTime intakeDate) async {
    await petAPI.addPetProtection(petId, productId, intakeDate);
  }

  Future<void> updatePetProtection(
      int protectionId, int productId, DateTime intakeDate) async {
    await petAPI.updatePetProtection(protectionId, productId, intakeDate);
  }

  Future<List<PetProtection>> getPetProtections(int petId,
      {bool? isActive}) async {
    return await petAPI.getPetProtections(petId, isActive: isActive);
  }

  Future<void> deletePetProtection(int protectionId) async {
    await petAPI.deletePetProtection(protectionId);
  }

  Future<List<PetVaccineRecord>> getPetVaccineRecords(int petId) async {
    return await petAPI.getPetVaccineRecords(petId);
  }

  Future<PetVaccineRecord> updatePetVaccineRecord(
      int recordId, Map<String, dynamic> data) async {
    return await petAPI.updatePetVaccineRecord(recordId, data);
  }

  Future<PetVaccineRecord> getPetVaccineRecord(int recordId) async {
    return await petAPI.getPetVaccineRecord(recordId);
  }
}
