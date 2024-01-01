import 'dart:developer';

import 'package:flutter/material.dart';

class Helper {
  static setHeight(BuildContext context, {height = 1}) {
    return MediaQuery.of(context).size.height * height;
  }

  static setWidth(BuildContext context, {width = 1}) {
    return MediaQuery.of(context).size.width * width;
  }

  static toReplacementScreen(context, screen) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  static bool validatePassword(String password) {
    // Regular expression to check if password contains at least one uppercase letter
    final uppercaseRegExp = RegExp(r'[A-Z]');
    // Regular expression to check if password contains at least one lowercase letter
    final lowercaseRegExp = RegExp(r'[a-z]');
    // Regular expression to check if password contains at least one digit
    final digitRegExp = RegExp(r'\d');
    // // Regular expression to check if password contains at least one special character
    // final specialCharRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    // specialCharRegExp.hasMatch(password)
    // Check all the conditions for the password
    if (password.isNotEmpty &&
        password.length >= 8 &&
        uppercaseRegExp.hasMatch(password) &&
        lowercaseRegExp.hasMatch(password) &&
        digitRegExp.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  void main() {
    // Test the validator
    String password = "Password123!";
    bool isValid = validatePassword(password);
    print('Password is valid: $isValid');
  }

  static showLog(message) {
    log("APP SAYS: $message");
  }

  static boxDecoration(Color color, double radius) {
    BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  static void changeLanguage(locale) {
    Locale locale0 = const Locale('en', '');
    if (locale0.languageCode == 'en') {
      locale0 = const Locale('de', '');
    } else {
      locale0 = const Locale('en', '');
    }
  }
}
