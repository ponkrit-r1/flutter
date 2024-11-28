class ChronicDisease {
  int? id;
  int? pet;
  String name;

  ChronicDisease({
    this.id,
    this.pet,
    required this.name,
  });

  factory ChronicDisease.fromJson(Map<String, dynamic> json) {
    return ChronicDisease(
      id: json['id'] ,
      pet: json['pet'] ,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
