import 'package:deemmi/core/domain/pet/clinic.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/pet_vaccine_record.dart';
import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_type.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deemmi/core/domain/pet/pet_protection_product.dart';
import 'package:deemmi/core/domain/pet/pet_protection.dart';
import 'package:intl/intl.dart';

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

  Future<List<VaccineType>> getVaccineType(int? animalType) async {
    final query = animalType != null ? {'animal_type': animalType} : null;
    var response = await apiClient.getHTTP(
      '/mypet/settings/vaccine-type/',
      queryParameters: query,
    );
    return List<VaccineType>.from(
      response.data.map((e) => VaccineType.fromJson(e)),
    );
  }

  Future<List<VaccineBrand>> getVaccineBrand({int? vaccineTypeId}) async {
    final query =
        vaccineTypeId != null ? {'vaccine_type': vaccineTypeId} : null;
    var response = await apiClient.getHTTP(
      '/mypet/settings/vaccine-brand/',
      queryParameters: query,
    );
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

  Future<List<PetProtectionProduct>> getPetProtectionProducts(
      [String? petType]) async {
    final response = await apiClient.getHTTP(
      '/mypet/pet-protection-products/',
      queryParameters: petType != null ? {'pet_type': petType} : null,
    );
    return List<PetProtectionProduct>.from(
      response.data.map((e) => PetProtectionProduct.fromJson(e)),
    );
  }

  Future<void> addPetProtection(
      int petId, int productId, DateTime intakeDate) async {
    await apiClient.postHTTP(
      '/mypet/flea-tick-control/',
      {
        'pet': petId,
        'product_id': productId,
        'intake_date': DateFormat('yyyy-MM-dd').format(intakeDate),
      },
    );
  }

  Future<void> updatePetProtection(
      int protectionId, int productId, DateTime intakeDate) async {
    await apiClient.patchHTTP(
      '/mypet/flea-tick-control/$protectionId/',
      {
        'product_id': productId,
        'intake_date': DateFormat('yyyy-MM-dd').format(intakeDate),
      },
    );
  }

  Future<List<PetProtection>> getPetProtections(int petId,
      {bool? isActive}) async {
    final queryParameters = <String, dynamic>{};
    if (isActive != null) {
      queryParameters['is_active'] = isActive.toString();
    }
    queryParameters['pet'] = petId.toString();
    final response = await apiClient.getHTTP(
      '/mypet/flea-tick-control/',
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
    if (response.data is List) {
      return List<PetProtection>.from(
        response.data.map((e) => PetProtection.fromJson(e)),
      );
    } else if (response.data is Map) {
      // In case API returns a single object
      return [PetProtection.fromJson(response.data)];
    }
    return [];
  }

  Future<void> deletePetProtection(int protectionId) async {
    await apiClient.deleteHTTP('/mypet/flea-tick-control/$protectionId/');
  }

  Future<List<PetVaccineRecord>> getPetVaccineRecords(int petId) async {
    final response = await apiClient.getHTTP(
      '/program/pet-vaccine-records/',
      queryParameters: {'pet': petId},
    );
    return List<PetVaccineRecord>.from(
      response.data.map((e) => PetVaccineRecord.fromJson(e)),
    );
  }

  Future<PetVaccineRecord> updatePetVaccineRecord(
      int recordId, Map<String, dynamic> data) async {
    final response = await apiClient.patchHTTP(
      '/program/pet-vaccine-records/$recordId/',
      data,
    );
    return PetVaccineRecord.fromJson(response.data);
  }

  Future<PetVaccineRecord> getPetVaccineRecord(int recordId) async {
    final response = await apiClient.getHTTP(
      '/program/pet-vaccine-records/$recordId/',
    );
    return PetVaccineRecord.fromJson(response.data);
  }

  Future<List<VaccineBrand>> getVaccineBrands(
      {required int vaccineTypeId}) async {
    try {
      final response = await apiClient.getHTTP(
        '/mypet/settings/vaccine-brand/',
        queryParameters: {'vaccine_type': vaccineTypeId},
      );

      return List<VaccineBrand>.from(
        response.data.map((json) => VaccineBrand.fromJson(json)),
      );
    } catch (e) {
      throw Exception('Error fetching vaccine brands: $e');
    }
  }
}
