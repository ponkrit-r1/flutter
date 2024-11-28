class DrugAllergy {
  int? id;
  int? pet;
  String name;

  DrugAllergy({
    this.id,
    this.pet,
    required this.name,
  });

  factory DrugAllergy.fromJson(Map<String, dynamic> json) {
    return DrugAllergy(
      id: json['id'],
      pet: json['pet'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
