import 'package:deemmi/core/data/api/pet_api.dart';
import 'package:get/get.dart';
import 'make_appointment_controller.dart';
import 'package:deemmi/core/data/repository/pet_repository.dart';
import 'package:deemmi/core/services/clinic_service.dart';

class MakeAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeAppointmentController>(() => MakeAppointmentController(
          PetRepository(
            PetAPI(
              Get.find(),
              Get.find(),
            ),
          ),
          Get.find<ClinicService>(),
        ));
  }
}
