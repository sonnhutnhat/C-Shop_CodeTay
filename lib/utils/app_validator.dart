abstract final class AppValidator {
  static String? required(String? value, {String message = 'Bắt buộc'}) {
    return value == null || value.trim().isEmpty ? message : null;
  }
}
