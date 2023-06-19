import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderGroup extends ChangeNotifier {
  String currentGroup = '';
  bool isSelected = false;
  bool newLessonAdded = false;
  bool newLessonSaved = true;
  bool switcher = false;
  bool saveSchedule = false;
  bool switcherSchedule = false;
  TimeOfDay startlessonTime = TimeOfDay.now();
  TimeOfDay finishlessonTime = TimeOfDay.now();
  String selectedGroup = 'Название группы';

  List<String> listGroup = [];
  List<dynamic> listSubjects = [];

  Map allCurrentLessons = {}; // Map для всех уроков определенной группы
  int lengthCurrentlistLesson = 0;

  Widget amountStudent(Map mapData) {
    final mapStudentName = mapData['allStudents'];
    if (mapStudentName is Map) {
      final nunberStudetns = mapStudentName.keys;
      return Text('${nunberStudetns.length} учеников');
    }
    return const Text('ошибка в подсчете студентов');
  }

  /// функция для сохранения уроков определенной группы
  void saveLessonForSelectedGroup(List lesson, String key, String date) {
    if (date != '') {
      allCurrentLessons[key] = lesson;

      if (allCurrentLessons.containsKey(date)) {
        lengthCurrentlistLesson = allCurrentLessons[date]!.length;
      } else {
        lengthCurrentlistLesson = 0;
      }
    }
  }

  Map<String, List> allLessons = {}; // Map для всех уроков
  int lengthlistLesson = 0;

  /// Функция для добавления всех уроков для Page Расписание
  void saveAllLessons(List lessons, String date, String currentDate) {
    if (date != '') {
      allLessons[date] = lessons;

      if (allLessons.containsKey(currentDate)) {
        lengthlistLesson = allLessons[currentDate]!.length;
      } else {
        lengthlistLesson = 0;
      }
    }
  }

  /// удаляем выбранный урок из расписания
  void deleteLessonfromSchedule(String currentDate, String lessonStartTime) {
    if (currentDate != '') {
      allLessons[currentDate]!.removeWhere((map) {
        if (map.containsKey('LessonTimeStart') &&
            map['LessonTimeStart'] == lessonStartTime) {
          lengthlistLesson--;
          return true; // Удаляем текущий Map из списка
        } else {
          return false; // Сохраняем текущий Map в списке
        }
      });
    }
  }

  /// Обновляем лист предметов
  void updateSubjectList(List<dynamic> newSubject) {
    List<dynamic> list = [];
    list.addAll(newSubject);
    listSubjects = list.toSet().toList();
    notifyListeners();
  }

  /// Обновляем лист названия групп
  void updateGroupNameList(Map snapshotData) {
    listGroup.clear();
    final groupsName = snapshotData.keys;
    final res = groupsName.cast<String>().toList();
    listGroup.addAll(res);
  }

  /// удаляем название удаленной группы из списка названий групп
  void deleteGroupName(String name) {
    listGroup.removeWhere((e) => e == name);
  }

  /// функция для свитчера на странице 'Изменить расписание'
  void saveScheduleFunc(switcherSchedule) {
    saveSchedule = switcherSchedule;
    notifyListeners();
  }

  /// функция для свитчера на странице 'Добавить урок'
  void addNewLesson(switcher) {
    newLessonAdded = switcher;
    notifyListeners();
  }

// Сохраненные переменные времени для экрана Изменить урок

  String lessonStart = '';
  String lessonFinish = '';

  DateTime dateTimefinish =
      DateTime(DateTime.now().hour, DateTime.now().minute);
  DateTime dateTimestart = DateTime(DateTime.now().hour, DateTime.now().minute);
  String finishTime = '';

  void setTime() {
    dateTimestart = DateTime(DateTime.now().hour, DateTime.now().minute).add(
        Duration(
            hours: DateFormat('HH:mm').parse(lessonStart).hour,
            minutes: DateFormat('HH:mm').parse(lessonStart).minute));

    dateTimefinish = DateTime(DateTime.now().hour, DateTime.now().minute).add(
        Duration(
            hours: DateFormat('HH:mm').parse(lessonFinish).hour,
            minutes: DateFormat('HH:mm').parse(lessonFinish).minute));

    notifyListeners();
  }

// weekly Schedule
  List<String> weekdays = [
    'Понедельник',
    'Вторник',
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье"
  ];
  int lengthWeeklyLessonsList = 0;
  Map weeklySchedule = {
    0: [0],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
  };

  void getCurrentlenght(int mapIndex) {
    lengthWeeklyLessonsList = weeklySchedule[mapIndex].length;
  }

  void increaseLength(int mapIndex) {
    weeklySchedule[mapIndex].add(0);
    lengthWeeklyLessonsList = weeklySchedule[mapIndex].length;
    notifyListeners();
  }

  void reduceLength(int mapIndex, int index) {
    weeklySchedule[mapIndex].removeAt(index);
    lengthWeeklyLessonsList = weeklySchedule[mapIndex].length;
    notifyListeners();
  }

  List<DateTime> timeListstart = List.generate(
      7,
      (index) => DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute));

  List<DateTime> timeListfinish = List.generate(
      7,
      (index) => DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour, DateTime.now().minute));

  // DateTime timestart = DateTime(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  // DateTime timefinish = DateTime(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
}
