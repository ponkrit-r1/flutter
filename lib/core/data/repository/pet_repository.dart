import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/auth/animal_type.dart';
import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/pet_health_info.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_brand.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:deemmi/core/domain/pet/pet_clinic.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';
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

  Future<List<VaccineBrand>> getVaccineBrand() async {
    return await petAPI.getVaccineBrand();
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
}
