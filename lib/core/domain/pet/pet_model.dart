import 'package:flutter/foundation.dart';

class PetModel {
  final int? id;
  final String owner;
  final String name;
  final String? image;
  final int animalType;
  final String microchipNumber;
  final String? breed;
  final String? gender;
  final DateTime? dob;
  final num weight;
  final String careSystem;
  final String characteristics;
  final int birthMonth;
  final int birthYear;
  Uint8List? imageData;

  PetModel({
    this.id,
    required this.owner,
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
    required this.birthMonth,
    required this.birthYear,
  });

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
      weight: json['weight'],
      careSystem: json['care_system'],
      characteristics: json['characteristics'],
      birthMonth: json['birth_month'],
      birthYear: json['birth_year'],
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
      'dob': dob?.toIso8601String(),
      'weight': weight,
      'care_system': careSystem,
      'characteristics': characteristics,
      'birth_month': birthMonth,
      'birth_year': birthYear,
    };
  }
}
