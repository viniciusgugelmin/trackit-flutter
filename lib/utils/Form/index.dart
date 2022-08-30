class FormUtils {
  String? validator(String field, String? value, [List<Function>? additionalValidators]) {
    if (value == null || value.isEmpty) {
      return '$field cannot be empty';
    }

    if (additionalValidators == null) {
      return null;
    }

    String? additionalError;

    for (var validator in additionalValidators) {
      final error = validator(value);

      if (error != null) {
        additionalError = error;
        break;
      }
    }

    if (additionalError != null) {
      return additionalError;
    }

    return null;
  }
}
