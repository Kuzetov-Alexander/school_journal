import 'package:flutter/material.dart';

class Validator {
  String? validateName(TextEditingController controller) {
    final nameExp = RegExp(r'[A-zА-Яa-zа-я]+$');
    if (controller.text.isEmpty) {
      return 'Заполните поле ФИО';
    } else if (!nameExp.hasMatch(controller.text)) {
      return 'Введите коррекное ФИО';
    } else {
      return null;
    }
  }

  String? validateEmail(TextEditingController controller) {
    final emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (controller.text.isEmpty) {
      return 'Заполните поле почта';
    } else if (!emailExp.hasMatch(controller.text)) {
      return 'Введите коррекную почту';
    } else {
      return null;
    }
  }

  String? validatePassword(
      {required TextEditingController password,
      TextEditingController? confirmPassword}) {
    final passwordExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$');
    if (password.text.isEmpty) {
      return 'Заполните поле пароль';
    } else if (!passwordExp.hasMatch(password.text)) {
      return 'Введите коррекный пароль';
    } else if (confirmPassword != null &&
        password.text != confirmPassword.text) {
      return 'Пароли не совпадают';
    }
    return null;
  }
}


  // String? validatePhone(TextEditingController controller) {
  //   final phoneExp = RegExp(r'^\(\d\d\d\)-\d\d\d\-\d\d\-\d\d$');
  //   if (controller.text.isEmpty) {
  //     return 'Заполните поле номер телефона';
  //   } else if (!phoneExp.hasMatch(controller.text)) {
  //     return 'Введите коррекный номер телефона';
  //   } else {
  //     return null;
  //   }
  // }