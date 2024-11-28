class VaccineBrand {
  int id;
  String name;

  VaccineBrand({
    required this.id,
    required this.name,
  });

  factory VaccineBrand.fromJson(Map<String, dynamic> json) {
    return VaccineBrand(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      other is VaccineBrand && id == other.id && name == other.name;

  @override
  int get hashCode => Object.hash(name, id);
}
