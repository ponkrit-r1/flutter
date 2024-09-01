class CreateAccountModel {
  final String username;
  final String password;
  final String password2;
  final String email;
  final String firstName;
  final String lastName;
  final int confirmedConditionId;

  CreateAccountModel({
    required this.username,
    required this.password,
    required this.password2,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.confirmedConditionId,
  });

  // Factory method to create an instance of UserModel from a JSON object
  factory CreateAccountModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountModel(
      username: json['username'],
      password: json['password'],
      password2: json['password2'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      confirmedConditionId: json['confirmed_condition_id'],
    );
  }

  // Method to convert a UserModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'password2': password2,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'confirmed_condition_id': confirmedConditionId,
    };
  }
}
