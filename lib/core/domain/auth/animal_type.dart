class AnimalType {
  final int id;
  final String name;

  AnimalType({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance of AnimalType from a JSON object
  factory AnimalType.fromJson(Map<String, dynamic> json) {
    return AnimalType(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert an AnimalType instance to a JSON object
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
}
