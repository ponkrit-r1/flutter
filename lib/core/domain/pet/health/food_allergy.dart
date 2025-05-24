class FoodAllergy {
  int? id;
  int? pet;
  String name;

  FoodAllergy({
    this.id,
    this.pet,
    required this.name,
  });

  factory FoodAllergy.fromJson(Map<String, dynamic> json) {
    return FoodAllergy(
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
