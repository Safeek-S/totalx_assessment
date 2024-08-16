extension MaskedPhoneNumber on String {
  String mask() {
    if (length >= 5) {
      return '${substring(0, 3)}${'*' * (length - 5)}${substring(length - 2)}';
    } else {
      return this; // Return the original string if it's too short
    }
  }
}