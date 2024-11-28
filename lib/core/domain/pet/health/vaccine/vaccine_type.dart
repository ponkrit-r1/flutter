class VaccineType {
  int id;
  String name;
  int animalType;
  List<int> brands;

  VaccineType({
    required this.id,
    required this.name,
    required this.animalType,
    required this.brands,
  });

  factory VaccineType.fromJson(Map<String, dynamic> json) {
    return VaccineType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      animalType: json['animal_type'] ?? 0,
      brands: List<int>.from(json['brands'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'animal_type': animalType,
      'brands': brands,
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
