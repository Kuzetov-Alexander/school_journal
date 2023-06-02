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
        DateTime(currentDate.year, currentDate.month + 1, DateTime.now().day);
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

  /// Вывод дней в текущем месяце, все что вне текущего месяца не учитывается.
  int setNumberDaysMonth() {
    final int numberDays;
    if (currentDate.month % 2 == 0) {
      if (DateTime(currentDate.year, currentDate.month, 0).day == 30) {
        // месяцы по 30 дней
        print(
            '-----------${DateTime(currentDate.year, currentDate.month, 0).day}     30');
        return numberDays =
            DateTime(currentDate.year, currentDate.month, 0).day;
      } else {
        // февраль

        if (DateTime(currentDate.year, currentDate.month, 0).day < 29) {
          print(
              '-----------${DateTime(currentDate.year, currentDate.month, 0).day}     28');
          return numberDays =
              DateTime(currentDate.year, currentDate.month, 0).day - 3;
        } else {
          print(
              '-----------${DateTime(currentDate.year, currentDate.month, 0).day}     29');
          return numberDays =
              DateTime(currentDate.year, currentDate.month, 0).day - 2;
        }
      }
    } else {
      // месяцы по 31 дню
      print(
          '-----------${DateTime(currentDate.year, currentDate.month, 0).day}     31');
      return DateTime(currentDate.year, currentDate.month, 0).day;
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
