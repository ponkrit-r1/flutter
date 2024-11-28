import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/auth/animal_breed.dart';
import '../../domain/auth/animal_type.dart';
import '../../domain/pet/health/pet_health_info.dart';
import '../../domain/pet/health/vaccine/vaccine_brand.dart';
import '../../domain/pet/pet_clinic.dart';
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

  Future<List<VaccineType>> getVaccineType(int animalType) async {
    var response = await apiClient.getHTTP('/mypet/settings/vaccine-type/');
    return List<VaccineType>.from(
      response.data.map((e) => VaccineType.fromJson(e)),
    );
  }

  Future<List<VaccineBrand>> getVaccineBrand() async {
    var response = await apiClient.getHTTP('/mypet/settings/vaccine-brand/');
    return List<VaccineBrand>.from(
      response.data.map((e) => VaccineBrand.fromJson(e)),
    );
  }

  Future<List<Clinic>> getClinic() async {
    var response = await apiClient.getHTTP('/mypet/settings/clinic/');
    return List<Clinic>.from(
      response.data.map((e) => Clinic.fromJson(e)),
    );
  }

  Future<dynamic> createPetClinic(PetClinic petClinic) async {
    var response = await apiClient.postHTTP(
      '/mypet/clinic/',
      petClinic.toJson(),
    );
    return response.data;
  }

  Future<List<PetClinic>> getPetClinic(int petId) async {
    var response = await apiClient.getHTTP(
      '/mypet/clinic/?pet=$petId',
    );
    return List<PetClinic>.from(
      response.data.map((e) => PetClinic.fromJson(e)),
    );
  }

  Future<PetHealthInfo> getPetHealthInfo(PetModel petModel) async {
    var response = await apiClient.getHTTP('/mypet/${petModel.id}/health/');
    var vaccineType = await getVaccineType(petModel.animalType);
    var vaccineBrand = await getVaccineBrand();
    return PetHealthInfo.fromJson(response.data, vaccineBrand, vaccineType);
  }

  Future<dynamic> updatePetHealthInfo(
    int petId,
    PetHealthInfo healthInfo,
  ) async {
    var response = await apiClient.putHTTP(
      '/mypet/$petId/health/',
      healthInfo.toJson(),
    );
    return response?.data;
  }
}
