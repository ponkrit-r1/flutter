import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:deemmi/core/domain/auth/animal_type.dart';
import 'package:deemmi/core/domain/pet/pet_model.dart';

class PetRepository {
  final PetAPI petAPI;

  PetRepository(this.petAPI);

  Future<PetModel> addPet(PetModel model) async {
    return await petAPI.addPet(model);
  }

  Future<List<AnimalType>> getAnimalType() async {
    return await petAPI.getAnimalType();
  }

  Future<List<AnimalBreed>> getAnimalBreed(int animalType) async {
    return await petAPI.getAnimalBreed(animalType);
  }
}
