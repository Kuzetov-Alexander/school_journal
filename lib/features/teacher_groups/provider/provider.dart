import 'package:flutter/material.dart';

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
  String selectedGroup = 'Выберите группу';

  List<String> listGroup = [];
  List<dynamic> listSubjects = [];

  Map allCurrentLessons = {}; // Map для всех уроков определенной группы
  int lengthCurrentlistLesson = 0;

// функция для сохранения уроков определенной группы
  void saveCurrentLessons(List lesson, String key, String date) {
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

  void deleteLessonfromSchedule(String currentDate, String lessonStartTime) {
    
      if (allLessons[currentDate] is List<Map<String, dynamic>>) {
        List<Map<String, dynamic>> newList =
            allLessons[currentDate] as List<Map<String, dynamic>>;
        newList.removeWhere((map) {
          if (map.containsKey('LessonTimeStart') &&
              map['LessonTimeStart'] == lessonStartTime) {
            return true; // Удаляем текущий Map из списка
          } else {
            return false; // Сохраняем текущий Map в списке
          }
        });
      } else {
        // List<dynamic>? lesson = allLessons[currentDate];
        //   lesson!.contains(lessonStartTime);
        // print();
      
    }
  }

  void addSubjectName(List<dynamic> newSubject) {
    List<dynamic> list = [];
    list.addAll(newSubject);
    listSubjects = list.toSet().toList();

    notifyListeners();
  }

  void addGroupName(List<String> newGroup) {
    List<String> listGroups = [];
    listGroups.addAll(newGroup);
    listGroup = listGroups.toSet().toList();
    notifyListeners();
  }

  void deleteGroupName(String name) {
    listGroup.removeWhere((e) => e == name);
  }

  void saveScheduleFunc(switcherSchedule) {
    saveSchedule = switcherSchedule;
    notifyListeners();
  }

  void addNewLesson(switcher) {
    newLessonAdded = switcher;
    notifyListeners();
  }

  void changeColor() {
    isSelected = !isSelected;
    notifyListeners();
  }
}
