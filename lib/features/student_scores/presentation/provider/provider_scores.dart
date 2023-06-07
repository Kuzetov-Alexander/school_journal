import 'package:flutter/material.dart';

class ProviderScores extends ChangeNotifier {
  String currentGroup = '';
  List<dynamic> allStudentDataList = [];

  /// Обновляем лист Студентов
  void updateFullNameList({required List<String> studentData}) {
    allStudentDataList.addAll(studentData);
    allStudentDataList.toSet().toList();
    notifyListeners();
  }
}
