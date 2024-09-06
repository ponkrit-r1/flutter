import '../../domain/auth/animal_breed.dart';
import '../../domain/auth/animal_type.dart';
import '../../domain/pet/pet_model.dart';
import '../../network/api_client.dart';
import '../app_storage.dart';

class PetAPI {
  final ApiClient apiClient;
  final AppStorage appStorage;

  PetAPI(this.apiClient, this.appStorage);

  Future<PetModel> addPet(PetModel petModel) async {
    var response = await apiClient.postHTTP('/mypet', petModel.toJson());

    var petResponse = PetModel.fromJson(response.data);

    return petResponse;
  }

  Future<List<AnimalBreed>> getAnimalBreed(int animalType) async {
    var response = await apiClient
        .getHTTP('/mypet/settings/animal-type', queryParameters: {
      'animal_type': animalType,
    });
    return List<AnimalBreed>.from(
      response.data.map((e) => AnimalBreed.fromJson(e)),
    );
  }

  Future<List<AnimalType>> getAnimalType() async {
    var response = await apiClient.getHTTP('/mypet/settings/animal-type-breed');
    return List<AnimalType>.from(
      response.data.map((e) => AnimalType.fromJson(e)),
    );
  }

  Future<List<PetModel>> getMyPet() async {
    var response = await apiClient.getHTTP('/mypet');
    return List<PetModel>.from(
      response.data.map((e) => PetModel.fromJson(e)),
    );
  }
}
