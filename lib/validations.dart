bool isImeiValid(String imei) {
  return RegExp(r'^[0-9]+$').hasMatch(imei);
}

bool isNameValid(String name) {
  return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
}

bool isPassportValid(String passport) {
  return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(passport);
}

bool isEmailValid(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}
