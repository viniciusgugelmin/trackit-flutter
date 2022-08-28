class FormUtils {
  String? validator(field, value, [additionalValidators]) {
    if (value == null || value.isEmpty) {
      return '$field cannot be empty';
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
