import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScores extends ChangeNotifier {
  String currentGroup = '';
  List<dynamic> allStudentDataList = [];
  String? currentSubject = '';
  String currentStudent = '';
  Map<Object, Object?> mapData = {};
  String day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());
  List listLessons = [];

  Map<String, dynamic> extendedMapData = {};

  /// Обновляем лист Студентов
  void updateFullNameList({required List<String> studentData}) {
    allStudentDataList.clear();
    List<String> listStudent = [];
    listStudent.addAll(studentData);
    allStudentDataList = listStudent.toSet().toList();
  }

  /// Обновляем мапу данных по предмету
  void updateDataMap({required Map<Object?, Object?> studentData}) {
    mapData.clear();
    studentData.forEach((key, value) {
      if (key != null && value != null) {
        mapData[key] = value;
      }
    });
    for (String name in allStudentDataList) {
      if (!mapData.containsKey(name)) {
        mapData[name] = null;
      }
    }
  }

  /// Обновляем мапу данных по урокам, формируем мапу дней со значениями группы и предмета.
  void updateLessonsMap({
    required Map<Object?, Object?> lessonData,
    required String? subject,
  }) {
    listLessons.clear();
    final listDate = lessonData.keys.toList();
    for (var data in listDate) {
      final m1 = lessonData[data];
      final Map map = m1 as Map;
      for (final value in map.values) {
        if (value is Map) {
          final group = value['Group'];
          final subject = value['Subject'];
          if (group == currentGroup && subject == currentSubject) {
            listLessons.add(data);
          }
        }
      }
    }

    extendedMapData = jsonDecode(jsonEncode(mapData));
    final setDateLessons = listLessons.toSet().cast<String>();

    for (final entry in extendedMapData.entries) {
      var dateMap = entry.value as Map<dynamic, dynamic>;
      final newObjects = setDateLessons.difference(dateMap.keys.toSet()).map(
            (e) => MapEntry(e, null),
          );
      dateMap.addEntries(newObjects);
      dateMap = Map.fromEntries(
          dateMap.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
      extendedMapData[entry.key] = dateMap;
    }
  }

  List<DateTime> dataForDateWidget() {
    List<DateTime> dateTimes = [];
    for (var dayLesson in listLessons) {
      DateTime dateTime = DateFormat('dd-MM-yyyy').parse(dayLesson);
      dateTimes.add(dateTime);
    }
    dateTimes.sort((a, b) =>
        DateTime.parse(a.toString()).compareTo(DateTime.parse(b.toString())));
    return dateTimes;
  }
}
