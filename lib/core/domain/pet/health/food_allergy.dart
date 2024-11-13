class FoodAllergy {
  int id;
  int pet;
  String name;

  FoodAllergy({
    required this.id,
    required this.pet,
    required this.name,
  });

  factory FoodAllergy.fromJson(Map<String, dynamic> json) {
    return FoodAllergy(
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