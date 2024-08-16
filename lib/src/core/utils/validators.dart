class Validators {
  static bool validatePhoneNumber(String phoneNumber) {
    RegExp phoneExp = RegExp(r'^\+91\d{10}$');
    return phoneExp.hasMatch(phoneNumber);
  }
}
