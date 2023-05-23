import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderCalendar extends ChangeNotifier {
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void getNextMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month + 1, DateTime.now().day);
    notifyListeners();
  }

  void getPreviousMonth() {
    currentDate =
        DateTime(currentDate.year, currentDate.month - 1, DateTime.now().day);
    notifyListeners();
    // currentDate.month == DateTime.now().month ? DateTime.now().day : 1);
  }

  void getSelectedDate(int index) {
    currentDate = currentDate.add(Duration(days: index - currentDate.day + 1));
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
