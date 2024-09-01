import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool acceptPrivacyPolicyRequired;
  final bool acceptTermAndConditionRequired;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.acceptPrivacyPolicyRequired,
    required this.acceptTermAndConditionRequired,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'accept_privacy_policy_required': acceptPrivacyPolicyRequired,
      'accept_term_and_condition_required': acceptTermAndConditionRequired,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    /// NOTE: first name, last name, gender and birthDate can be null if the account is manual created from Spree
    /// The app handle it by showing empty text in account detail and edit account page
    return User(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      acceptPrivacyPolicyRequired:
          map['accept_privacy_policy_required'] ?? false,
      acceptTermAndConditionRequired:
          map['accept_term_and_condition_required'] ?? false,
      email: 'email',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) =>
      User.fromMap(source['data']);
}
