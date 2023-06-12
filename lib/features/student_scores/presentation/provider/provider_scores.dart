import 'package:flutter/material.dart';

class ProviderScores extends ChangeNotifier {
  String currentGroup = '';
  List<dynamic> allStudentDataList = [];
  String? currentsubject = '';
  String currentStudent = '';
  Map<Object, Object?> mapData = {};

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
    // Map<Object, Object> mapStudent = {};
    studentData.forEach((key, value) {
      if (key != null && value != null) {
        mapData[key] = value;
      }
    });
    sortDataByName();
  }

  void sortDataByName() {
    for (String name in allStudentDataList) {
      if (!mapData.containsKey(name)) {
        mapData[name] = null;
      }
    }
  }

  Widget getWidgetScore({required String currentStudent}) {
    final dataScore = mapData[currentStudent];
    if (dataScore is Map) {
      final mapScore = dataScore['12-06-2023'];
      final score = mapScore['score'];
      return Text('$score');
    }
    return const Text('null');
  }
}
