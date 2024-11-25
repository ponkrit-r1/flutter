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

//update username account setting  field
Future<bool> updateUsername(String username) async {
    try {
      var response = await apiClient.patchHTTP(
        '/user-detail/',
        {'username': username}, 
      );

      // If the request is successful, return true
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update username');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error updating username: $e');
      return false;
    }
  }

  // user_api.dart
  Future<bool> updateName({String? firstName, String? lastName}) async {
    try {
      var requestData = <String, dynamic>{};
      if (firstName != null) requestData['first_name'] = firstName;
      if (lastName != null) requestData['last_name'] = lastName;

      var response = await apiClient.patchHTTP(
        '/user-detail/',
        requestData,
      );

      // If the request is successful, return true
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update name');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error updating name: $e');
      return false;
    }
  }
  

  // user_api.dart
// user_api.dart
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      var requestData = {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password2': newPassword2,
      };

      var response = await apiClient.postHTTP(
        '/change-password/',
        requestData,
      );

      // If the request is successful, return success status
      if (response.statusCode == 200) {
        return {
          'success': true,
        };
      } else {
        // If request failed, return the response data and success status as false
        return {
          'success': false,
          'data': response.data,
        };
      }
    } catch (e) {
      // Handle exceptions here
      print('Error changing password: $e');
      return {
        'success': false,
        'data': e.toString(),
      };
    }
  }


}
