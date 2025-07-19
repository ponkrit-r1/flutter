import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:get/get.dart';
import 'vaccinated_date_controller.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/services/clinic_service.dart';

class VaccinatedDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaccinatedDateController>(
      () => VaccinatedDateController(
        PetRepository(
          PetAPI(
            Get.find(),
            Get.find(),
          ),
        ),
        Get.find<ClinicService>(),
      ),
    );
  }
}
