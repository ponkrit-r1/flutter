import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/auth/animal_breed.dart';
import '../../domain/auth/animal_type.dart';
import '../../domain/pet/pet_model.dart';
import '../../network/api_client.dart';
import '../app_storage.dart';

class PetAPI {
  final ApiClient apiClient;
  final AppStorage appStorage;

  PetAPI(this.apiClient, this.appStorage);

  Future<PetModel> addPet(
    PetModel petModel,
    XFile? file,
  ) async {
    var requestModel = petModel.toRequestJson();
    if (file != null) {
      var imageData = await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      );
      requestModel['image'] = imageData;
    }
    final body = FormData.fromMap(requestModel);

    var response = await apiClient.postHTTP(
      '/mypet/',
      body,
    );
    var petResponse = PetModel.fromJson(response.data);

    return petResponse;
  }

  Future<List<AnimalBreed>> getAnimalBreed(int animalType) async {
    var response = await apiClient
        .getHTTP('/mypet/settings/animal-type-breed/', queryParameters: {
      'animal_type': animalType,
    });
    return List<AnimalBreed>.from(
      response.data.map((e) => AnimalBreed.fromJson(e)),
    );
  }

  Future<List<AnimalType>> getAnimalType() async {
    var response = await apiClient.getHTTP('/mypet/settings/animal-type/');
    return List<AnimalType>.from(
      response.data.map((e) => AnimalType.fromJson(e)),
    );
  }

  Future<List<PetModel>> getMyPet() async {
    var response = await apiClient.getHTTP('/mypet/');
    return List<PetModel>.from(
      response.data.map((e) => PetModel.fromJson(e)),
    );
  }

  Future<PetModel> uploadPetImage(int petId, XFile file) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: file.name),
    });
    var response = await apiClient.patchHTTP(
      '/mypet/upload_image/$petId/',
      formData,
    );
    return PetModel.fromJson(response.data);
  }

  Future<void> deletePet(int petId) async {
    await apiClient.deleteHTTP('/mypet/$petId/');
  }

  Future<PetModel> updatePet(
    int petId,
    PetModel petModel, {
    XFile? file,
  }) async {
    var requestModel = petModel.toRequestJson();
    if (file != null) {
      var imageData = await MultipartFile.fromFile(
        file.path,
        filename: file.name,
      );
      requestModel['image'] = imageData;
    }
    final body = FormData.fromMap(requestModel);

    var response = await apiClient.putHTTP(
      '/mypet/$petId/',
      body,
    );
    var petResponse = PetModel.fromJson(response!.data);

    return petResponse;
  }
}
