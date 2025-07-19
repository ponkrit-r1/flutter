import 'package:deemmi/core/domain/pet/health/vaccine/vaccine_dose.dart';

class VaccineType {
  int id;
  String name;
  int animalType;
  List<int> brands;
  List<VaccineDose> doses;
  String type;

  VaccineType({
    required this.id,
    required this.name,
    required this.animalType,
    required this.brands,
    required this.doses,
    required this.type,
  });

  factory VaccineType.fromJson(Map<String, dynamic> json) {
    return VaccineType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      animalType: json['animal_type'] ?? 0,
      brands: List<int>.from(json['brands'] ?? []),
      doses: (json['doses'] as List<dynamic>? ?? [])
          .map((e) => VaccineDose.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'animal_type': animalType,
      'brands': brands,
      'doses': doses.map((e) => e.toJson()).toList(),
      'type': type,
    };
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      other is VaccineType && id == other.id && name == other.name;

  @override
  int get hashCode => Object.hash(name, id);
}
