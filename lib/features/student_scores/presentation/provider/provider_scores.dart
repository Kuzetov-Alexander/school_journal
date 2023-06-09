import 'package:flutter/material.dart';

class ProviderScores extends ChangeNotifier {
  String currentGroup = '';
  List<dynamic> allStudentDataList = [];
  String? currentsubject = '';
  String currentStudent = '';

  /// Обновляем лист Студентов
  void updateFullNameList({required List<String> studentData}) {
    allStudentDataList.clear();
    List<String> listStudent = [];
    listStudent.addAll(studentData);
    allStudentDataList = listStudent.toSet().toList();
  }
}
