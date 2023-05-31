import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderCalendar extends ChangeNotifier {
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());

  void getNextMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month + 1, DateTime.now().day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
  }

  void getPreviousMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month - 1, DateTime.now().day);
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    notifyListeners();
    // currentDate.month == DateTime.now().month ? DateTime.now().day : 1);
  }

  void getSelectedDate(int index) {
    currentDate = currentDate.add(Duration(days: index - currentDate.day + 1));
    day = DateFormat('dd-MM-yyyy', 'ru').format(currentDate);
    // DateTime.now().add(Duration(days: index - DateTime.now().day + 1));
    notifyListeners();
  }

  String getDayOfWeek(int index) {
    return DateFormat('E', 'ru').format(
      DateTime(currentDate.year, currentDate.month, 1).add(
        Duration(days: index),
      ),
    );
  }
}
