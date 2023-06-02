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

// удаляем выбранный урок из расписания
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

// Обновляем лист предметов
  void updateSubjectList(List<dynamic> newSubject) {
    List<dynamic> list = [];
    list.addAll(newSubject);
    listSubjects = list.toSet().toList();

    notifyListeners();
  }

// Обновляем лист названия групп
  void updateGroupNameList(List<String> newGroup) {
    List<String> listGroups = [];
    listGroups.addAll(newGroup);
    listGroup = listGroups.toSet().toList();
    notifyListeners();
  }

// удаляем название удаленной группы из списка названий групп
  void deleteGroupName(String name) {
    listGroup.removeWhere((e) => e == name);
  }

// функция для свитчера на странице 'Изменить расписание'
  void saveScheduleFunc(switcherSchedule) {
    saveSchedule = switcherSchedule;
    notifyListeners();
  }

// функция для свитчера на странице 'Добавить урок'
  void addNewLesson(switcher) {
    newLessonAdded = switcher;
    notifyListeners();
  }

  // void changeColor() {
  //   isSelected = !isSelected;
  //   notifyListeners();
  // }
}
