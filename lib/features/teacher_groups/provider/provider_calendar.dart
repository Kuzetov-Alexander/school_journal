import 'package:flutter/material.dart';

class ProviderCalendar extends ChangeNotifier {
  bool isSelected = false;
  bool newLessonAdded = false;
  bool switcher = false;
  bool saveSchedule = false;
  bool switcherSchedule = false;

  List<String> listOfMonths = [
    "Январь",
    "Февраль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
  ];

  List<String> listOfDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  /// Отслеживать дату
  DateTime selectedDate = DateTime.now();

  /// Для прокрутки даты
  int currentDaySelectedIndex = 0;

  Color mapperColorButtom(Color activeColor, Color passiveColor) {
    return currentDaySelectedIndex == 0 ? activeColor : passiveColor;
  }

  void getSelectedDate(int index) {
    selectedDate = DateTime.now().add(Duration(days: index));
  }

  // void getChangeMonths(int index) {
  //   DateTime.now().
  //   // selectedDate = DateTime.now().add(const Duration(days: 30));
  // }

  void getCurrentDaySelectedIndex(int index) {
    currentDaySelectedIndex = index;
  }
}
