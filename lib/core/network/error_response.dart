// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'app_error_code.dart';

class ErrorResponse {
  AppErrorCode error;
  String code;
  String? description;
  List<Field>? fields;

  String? getErrorFieldDescription(String field) {
    try {
      return fields
          ?.firstWhere((element) => element.field == field).description;
    } catch(error) {
      return null;
    }
  }

  String? descriptionForField(String field) {
    final errorFields = fields?.where((element) => element.field == field);

    if (errorFields != null) {
      return errorFields.map((e) => e.description).join(", ");
    }

    return null;
  }

  ErrorResponse({
    required this.error,
    required this.code,
    this.description,
    this.fields,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    error: appErrorCodeFromString(json['error']),
    code: json['code'] ?? '',
    description: json['error_description'],
    fields: json['fields'] != null
        ? List<Field>.from(json['fields']?.map((x) => Field.fromJson(x)))
        : null,
  );
}

class Field {
  String field;

  String description;
  Field({
    required this.field,
    required this.description,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    field: json["field"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "description": description,
  };
}