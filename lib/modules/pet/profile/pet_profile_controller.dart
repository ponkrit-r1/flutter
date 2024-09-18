import 'package:get/get.dart';

import '../../../core/data/repository/pet_repository.dart';
import '../../../core/domain/pet/pet_model.dart';

class PetProfileController extends GetxController {
  final PetRepository petRepository;
  final PetModel petModel;

  PetProfileController({
    required this.petModel,
    required this.petRepository,
  });

  String get petName => petModel.name;
}
