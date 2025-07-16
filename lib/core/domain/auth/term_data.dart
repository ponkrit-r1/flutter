class TermData {
  final int id;
  final String fileLocation;
  final bool isActive;

  TermData({
    required this.id,
    required this.fileLocation,
    required this.isActive,
  });

  // Factory method to create an instance of FileModel from a JSON object
  factory TermData.fromJson(Map<String, dynamic> json) {
    return TermData(
      id: json['id'],
      fileLocation: json['file_location'],
      isActive: json['is_active'],
    );
  }

  // Method to convert a FileModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_location': fileLocation,
      'is_active': isActive,
    };
  }
}
