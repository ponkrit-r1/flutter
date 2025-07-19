class VaccineDose {
  int id;
  int doseNumber;
  String doseType;
  int minAgeWeeks;
  int? suggestedInterval;
  String remark;
  int program;

  VaccineDose({
    required this.id,
    required this.doseNumber,
    required this.doseType,
    required this.minAgeWeeks,
    this.suggestedInterval,
    required this.remark,
    required this.program,
  });

  factory VaccineDose.fromJson(Map<String, dynamic> json) {
    return VaccineDose(
      id: json['id'] ?? 0,
      doseNumber: json['dose_number'] ?? 0,
      doseType: json['dose_type'] ?? '',
      minAgeWeeks: json['min_age_weeks'] ?? 0,
      suggestedInterval: json['suggested_interval'],
      remark: json['remark'] ?? '',
      program: json['program'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dose_number': doseNumber,
      'dose_type': doseType,
      'min_age_weeks': minAgeWeeks,
      'suggested_interval': suggestedInterval,
      'remark': remark,
      'program': program,
    };
  }
}
