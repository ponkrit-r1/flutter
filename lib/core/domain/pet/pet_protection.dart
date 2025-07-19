import 'package:deemmi/core/domain/pet/pet_protection_product.dart';

class PetProtection {
  final int id;
  final int pet;
  final PetProtectionProduct product;
  final DateTime intakeDate;
  final bool isActive;
  final DateTime expirationDate;

  PetProtection({
    required this.id,
    required this.pet,
    required this.product,
    required this.intakeDate,
    required this.isActive,
    required this.expirationDate,
  });

  factory PetProtection.fromJson(Map<String, dynamic> json) {
    return PetProtection(
      id: json['id'],
      pet: json['pet'],
      product: PetProtectionProduct.fromJson(json['product']),
      intakeDate: DateTime.parse(json['intake_date']),
      isActive: json['is_active'],
      expirationDate: DateTime.parse(json['expiration_date']),
    );
  }
}
