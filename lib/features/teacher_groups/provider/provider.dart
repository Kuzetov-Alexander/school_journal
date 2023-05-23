import 'package:flutter/material.dart';

class ProviderGroup extends ChangeNotifier {
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
  List<String> listRooms = [];

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
