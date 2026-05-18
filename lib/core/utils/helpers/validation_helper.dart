class ValidationHelper {
  static bool hasMinLength(String value) => value.length >= 8;
  static bool hasMaxLength(String value) => value.length <= 20;
  static bool hasUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);
  static bool hasLowercase(String value) => RegExp(r'[a-z]').hasMatch(value);
  static bool hasNumber(String value) => RegExp(r'[0-9]').hasMatch(value);
  static bool hasSpecialChar(String value) => RegExp(r'[!$@%]').hasMatch(value);

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can not be empty';
    }
    if (value.length < 8 || value.length > 20) {
      return 'Password must be between 8 and 20 characters long';
    }
    if (!hasUppercase(value)) {
      return 'Include at least one uppercase letter';
    }
    if (!hasLowercase(value)) {
      return 'Include at least one lowercase letter';
    }
    if (!hasNumber(value)) {
      return 'Include at least one number';
    }
    if (!hasSpecialChar(value)) {
      return 'Include at least one special character (!\$@%)';
    }
    return null;
  }
}
