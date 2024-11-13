class ChronicDisease {
  int id;
  int pet;
  String name;

  ChronicDisease({
    required this.id,
    required this.pet,
    required this.name,
  });

  factory ChronicDisease.fromJson(Map<String, dynamic> json) {
    return ChronicDisease(
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