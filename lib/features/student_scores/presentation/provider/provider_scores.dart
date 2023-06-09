import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderScores extends ChangeNotifier {
  Map snapshotData = {};
  Map<Object?, Object?> snapshotSchedule = {};
  String currentGroup = '';
  List<dynamic> studentsNameList = [];
  String? currentSubject = '';
  String currentStudent = '';
  Map<Object, Object?> mapData = {};
  String day = DateFormat('dd-MM-yyyy', 'ru').format(DateTime.now());
  List listLessons = [];

  Map<String, dynamic> extendedMapData = {};

  /// Получаем мапу данных по Groups
  Map getSnapshotData({required Map<dynamic, dynamic> query}) {
    snapshotData.clear();
    query.forEach((key, value) {
      if (key != null && value != null) {
        snapshotData[key] = value;
      }
    });
    return snapshotData;
  }

  /// Обновляем лист Студентов
  void updateStudentsNameList() {
    studentsNameList.clear();
    if (snapshotData.containsKey(currentGroup)) {
      final groupdata = snapshotData[currentGroup] as Map;
      if (groupdata['allStudents'] is Map) {
        final studentsdata = groupdata['allStudents'] as Map;
        final result = studentsdata.keys.toSet().toList();
        studentsNameList.addAll(result);
      }
    } else {
      print('Ошибка обновления списка List студентов');
    }
  }

  /// Обновляем мапу данных по предмету
  void updateMapData() {
    mapData.clear();
    if (snapshotData[currentGroup]['allSubject'][currentSubject] is Map) {
      final way = snapshotData[currentGroup]['allSubject'][currentSubject]
          ['Students'] as Map;
      way.forEach((key, value) {
        if (key != null && value != null) {
          mapData[key] = value;
        }
      });
      for (String name in studentsNameList) {
        if (!mapData.containsKey(name)) {
          mapData[name] = null;
        }
      }
    }
  }

  /// обновляем snapshotShedule мапу с расписанием всех групп
  Map updateSnapshotShedule({required Map<Object?, Object?> snapshotData}) {
    snapshotSchedule.clear();
    snapshotSchedule.addAll(snapshotData);
    return snapshotSchedule;
  }

  /// Обновляем мапу данных по урокам, формируем мапу дней со значениями группы и предмета.
  void updateLessonsMap() {
    updateMapData();
    listLessons.clear();
    final listDate = snapshotSchedule.keys.toList();
    for (var data in listDate) {
      final m1 = snapshotSchedule[data];
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
