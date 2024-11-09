class AnimalBreed {
  final int id;
  final String name;

  AnimalBreed({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance of AnimalType from a JSON object
  factory AnimalBreed.fromJson(Map<String, dynamic> json) {
    return AnimalBreed(
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
      other is AnimalBreed && id == other.id && name == other.name;

  @override
  int get hashCode => Object.hash(name, id);
}
