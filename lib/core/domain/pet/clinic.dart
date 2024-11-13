class Clinic {
  final int id;
  final String name;
  final String telephone;
  final bool isActive;

  Clinic({
    required this.id,
    required this.name,
    required this.telephone,
    required this.isActive,
  });

  // Factory method to create an instance from JSON
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      name: json['name'],
      telephone: json['telephone'],
      isActive: json['is_active'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'telephone': telephone,
      'is_active': isActive,
    };
  }

  @override
  String toString() {
    return name;
  }
}