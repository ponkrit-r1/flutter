import 'package:deemmi/core/domain/auth/animal_breed.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PetModel {
  final int? id;
  final String? owner;
  final String name;
  final String? image;
  final int animalType;
  final String? microchipNumber;
  final int? breed;
  final String? gender;
  final DateTime dob;
  final num? weight;
  final String? careSystem;
  final String? characteristics;
  Uint8List? imageData;

  String? displayBreed;

  PetModel({
    this.id,
    this.owner,
    required this.name,
    this.image,
    required this.animalType,
    required this.microchipNumber,
    this.breed,
    this.gender,
    required this.dob,
    required this.weight,
    required this.careSystem,
    required this.characteristics,
  });

  getAgeInMonth() {
    var now = DateTime.now();
    return (now.difference(dob).inDays ~/ 30);
  }

  // Factory method to create an instance of PetModel from a JSON object
  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      owner: json['owner'],
      name: json['name'],
      image: json['image'],
      animalType: json['animal_type'],
      microchipNumber: json['microchip_number'],
      breed: json['breed'],
      gender: json['gender'],
      dob: DateTime.parse(json['dob']),
      weight: num.tryParse(json['weight'] ?? ''),
      careSystem: json['care_system'],
      characteristics: json['characteristics'],
    );
  }

  // Method to convert a PetModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner,
      'name': name,
      'image': image,
      'animal_type': animalType,
      'microchip_number': microchipNumber,
      'breed': breed,
      'gender': gender,
      'dob': DateFormat('yyyy-MM-dd').format(dob),
      'weight': weight,
      'care_system': careSystem,
      'characteristics': characteristics,
    };
  }

  Map<String, dynamic> toRequestJson() {
    return {
      'name': name,
      'animal_type': animalType,
      'microchip_number': microchipNumber,
      'breed': breed,
      'gender': gender,
      'dob': DateFormat('yyyy-MM-dd').format(dob),
      'weight': weight,
      'care_system': careSystem,
      'characteristics': characteristics,
    };
  }

  assignBreedInfo(List<AnimalBreed> breedList) {
    displayBreed =
        breedList.firstWhereOrNull((element) => element.id == breed)?.name ?? '';
  }
}
