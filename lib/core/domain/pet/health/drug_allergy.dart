class DrugAllergy {
  int id;
  int pet;
  String name;

  DrugAllergy({
    required this.id,
    required this.pet,
    required this.name,
  });

  factory DrugAllergy.fromJson(Map<String, dynamic> json) {
    return DrugAllergy(
      id: json['id'] ?? 0,
      pet: json['pet'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet': pet,
      'name': name,
    };
  }
}