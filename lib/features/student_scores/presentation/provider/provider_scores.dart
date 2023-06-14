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
  List updateLessonsMap(
      {required Map<Object?, Object?> lessonData, required String? subject}) {
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
    return listLessons;
  }

  List<DateTime> dataForDateWidget() {
    List<DateTime> dateTimes = [];
    listLessons.forEach((dayLesson) {
      DateTime dateTime = DateFormat('dd-MM-yyyy').parse(dayLesson);
      dateTimes.add(dateTime);
    });
    dateTimes.sort((a, b) =>
        DateTime.parse(a.toString()).compareTo(DateTime.parse(b.toString())));
    return dateTimes;
  }

  Widget getWidgetScore({required String currentStudent}) {
    final dataScore = mapData[currentStudent];
    // print(dataScore);
    //проверяет оценку только сегодняшнего дня!!!! косяк
    if (dataScore is Map && dataScore.containsKey(day)) {
      final mapScore = dataScore[day];
      final score = mapScore['score'];

      return Text('$score');
    }
    return const Text('null');
  }
}
