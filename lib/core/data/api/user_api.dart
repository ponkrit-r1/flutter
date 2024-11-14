import 'package:deemmi/core/domain/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/pet/pet_model.dart';
import '../../network/api_client.dart';
import '../app_storage.dart';

class UserAPI {
  final ApiClient apiClient;
  final AppStorage appStorage;

  UserAPI(this.apiClient, this.appStorage);

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

  Future<User> getMyProfile() async {
    var response = await apiClient.getHTTP('/user-detail/');
    return User.fromJson(response.data);
  }
}
