import 'package:flutter/material.dart';

class ProviderCalendar extends ChangeNotifier {
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void getNextMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month + 1, DateTime.now().day);
  }

  void getPreviousMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month - 1, DateTime.now().day);
    // currentDate.month == DateTime.now().month ? DateTime.now().day : 1);
  }

  void getSelectedDate(int index) {
    currentDate =
        DateTime.now().add(Duration(days: index - DateTime.now().day + 1));
  }

  // void getCurrentDaySelectedIndex(int index) {
  //   currentDate.day - 1 = index;
  // }
}

// final items = List<DateTime>.generate(
//   60,
//   (i) => DateTime.utc(
//     DateTime.now().year,
//     DateTime.now().month,
//     DateTime.now().day,
//   ).add(
//     Duration(days: i),
//   ),
// );

  // List<String> listOfMonths = [
  //   "Январь",
  //   "Февраль",
  //   "Март",
  //   "Апрель",
  //   "Май",
  //   "Июнь",
  //   "Июль",
  //   "Август",
  //   "Сентябрь",
  //   "Октябрь",
  //   "Ноябрь",
  //   "Декабрь"
  // ];