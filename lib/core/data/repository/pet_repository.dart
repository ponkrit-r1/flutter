import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/auth/animal_type.dart';
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
    return  petAPI.getAnimalType();
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
}
