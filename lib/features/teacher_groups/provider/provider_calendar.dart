// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderCalendar extends ChangeNotifier {
  /// Переменная для текущей даты, все завязано на ней.
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());

  /// Перейти на следующий месяц в календаре.
  void getNextMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
  }

  /// Перейти на предыдущий месяц в календаре.
  void getPreviousMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month - 1, DateTime.now().day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
  }




  /// При нажатие на ленту дат, подсвечиваем выбранный(актуальный) день.
  void getSelectedDate(int index) {
    currentDate = DateTime(currentDate.year, currentDate.month, 1)
        .add(Duration(days: index));
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

  /// Выводит тукущий день, который можно выбрать в виджете календаря.
  String createNumberWidgetDays(int index) {
    return DateTime(currentDate.year, currentDate.month, 1)
        .add(Duration(days: index))
        .day
        .toString();
  }

  /// Считает дни в текущем месяце, все что вне текущего месяца не учитывается.
  /// Выводит количество виджетов, соответсвующее дням текущего месяца в календарь.
  /// itemCount = setNumberDaysMonth()
  int setNumberDaysMonth() {
    final numberOfDaysMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    return numberOfDaysMonth;
  }
}
