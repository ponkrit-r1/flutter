enum AppErrorCode {
  phoneNumberAlreadyUsed,
  userAlreadyExists,
  otpMaxAttemptReached,
  unknown,
  unauthorized,
  mustUpgradeApp,
  notFound,
}

AppErrorCode appErrorCodeFromString(String type) {
  switch (type) {
    case 'user_already_exists':
      return AppErrorCode.userAlreadyExists;
    case 'phone_number_already_used':
      return AppErrorCode.phoneNumberAlreadyUsed;
    case 'max_attempts_reached':
      return AppErrorCode.otpMaxAttemptReached;
    case 'unauthorized':
      return AppErrorCode.unauthorized;
    case 'not_found':
      return AppErrorCode.notFound;
    case 'must_upgrade_app':
      return AppErrorCode.mustUpgradeApp;
    default:
      return AppErrorCode.unknown;
  }
}

extension AppErrorCodeExtension on AppErrorCode {
  String? get localizedDescription {
    switch (this) {
      case AppErrorCode.phoneNumberAlreadyUsed:
        return 'หากหมายเลขโทรศัพท์นี้เป็นหมายเลขโทรศัพท์ของคุณกรุณาเปลี่ยนหมายเลขโทรศัพท์ที่บัญชีเดิมก่อน หรือหากมีข้อสงสัย โปรดติดต่อ support@talaadthai.com';
      default:
        return null;
    }
  }
}
