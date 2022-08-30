class EmailUtils {
  String? isEmail(value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

    if (emailRegex.hasMatch(value.trim())) {
      return null;
    }

    return 'Please enter a valid email';
  }
}