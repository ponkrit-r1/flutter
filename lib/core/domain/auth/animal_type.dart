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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalType &&
          runtimeType == other.runtimeType &&
          id == other.id);

  @override
  int get hashCode => id;
}
