import 'package:get/get.dart';
import 'package:deemmi/core/domain/pet/pet_protection_product.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:deemmi/core/domain/pet/pet_protection.dart';

class PetProtectionController extends GetxController {
  final PetRepository petRepository = PetRepository(PetAPI(
    Get.find(),
    Get.find(),
  ));

  var petProtectionItems = <PetProtectionProduct>[].obs;
  var selectedProtection = Rxn<PetProtectionProduct>();
  var selectedDate = DateTime.now().obs;

  Future<void> fetchPetProtectionItems(String petType,
      {PetProtection? item}) async {
    try {
      final items = await petRepository.getPetProtectionProducts(petType);
      petProtectionItems.value = items;
      if (item != null) {
        selectedDate.value = item.intakeDate;
        selectedProtection.value = items.firstWhereOrNull(
          (p) => p.id == item.product.id,
        );
      }
    } catch (e) {
      print('Failed to fetch pet protection items: $e');
    }
  }

  void setSelectedProtection(PetProtectionProduct? product) {
    selectedProtection.value = product;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
