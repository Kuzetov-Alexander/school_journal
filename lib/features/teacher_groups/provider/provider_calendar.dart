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
  }

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

  // ${DateFormat('EEEE', 'ru').format(curentDateTime).capitalize()}

  // String

  List<String> listOfDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

  /// Для прокрутки даты
  int indexDay = 0;

  Color mapperColorButtom(Color activeColor, Color passiveColor) {
    return indexDay == 0 ? activeColor : passiveColor;
  }


  void getSelectedDate(int index) {
    // DateTime selectedDate = DateTime.now();
    currentDate = DateTime.now().add(Duration(days: index));
  }

  void getCurrentDaySelectedIndex(int index) {
    indexDay = index;
  }
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
