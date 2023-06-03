// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderCalendar extends ChangeNotifier {
  /// Переменная для текущей даты, все завязано на ней.
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());
// c присвоением косяки
  /// Перейти на следующий месяц в календаре.
  void getNextMonth() {
    final int currentMoths = currentDate.month + 1;
    currentDate = DateTime(currentDate.year, currentMoths, currentDate.day);
    // currentDate =
    //     DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
  }

  /// Перейти на предыдущий месяц в календаре.
  void getPreviousMonth() {
    final int currentMoths = currentDate.month - 1;
    currentDate = DateTime(currentDate.year, currentMoths, DateTime.now().day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
  }

  /// Вывод дней в текущем месяце, все что вне текущего месяца не учитывается.
  int setNumberDaysMonth() {
    final int result;
    final int currentMoths = currentDate.month;
    final int numberOfDays = DateTime(currentDate.year, currentMoths, 0).day;
    if (currentMoths % 2 == 0) {
      if (numberOfDays == 30) {
        // месяцы по 30 дней
        // print('-----------${currentMoths}--${numberOfDays}     30');
        return result = numberOfDays;
      } else {
        if (numberOfDays == 31) {
          // print('-----------$currentMoths--${numberOfDays}    31');
          return numberOfDays;
          // февраль
        } else if (numberOfDays == 29) {
          // print('-----------${currentMoths}--${numberOfDays}     28');
          return result = numberOfDays - 3;
        } else {
          // print('-----------${currentMoths}--${numberOfDays}     29');
          return result = numberOfDays - 2;
        }
      }
    }
    // месяцы по 31 дню
    if (numberOfDays == 30) {
      // месяцы по 30 дней
      // print('-----------${currentMoths}--${numberOfDays}    1 30');
      return result = numberOfDays + 1;
    } else if (numberOfDays == 31) {
      // print(
      //     '---------${currentDate.year}--$currentMoths--${numberOfDays}    1 31');
      return result = numberOfDays + 1;
    } else if (numberOfDays == 28) {
      // print('-----------${currentMoths}--${numberOfDays}    1 28');
      return result = numberOfDays;
    } else {
      // print('-----------${currentMoths}--${numberOfDays}    1 29');
      return result = numberOfDays;
    }
  }

  /// При нажатие на ленту дат, подсвечиваем выбранный(актуальный) день.
  void getSelectedDate(int index) {
    currentDate = currentDate.add(Duration(days: index - currentDate.day + 1));
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);

    notifyListeners();
  }

  /// Выводит день недели в ленте дат (пн, вт...).
  String getDayOfWeek(int index) {
    return DateFormat('E', 'ru').format(
      DateTime(currentDate.year, currentDate.month, 1).add(
        Duration(days: index),
      ),
    );
  }
}
