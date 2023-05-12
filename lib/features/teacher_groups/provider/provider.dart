import 'package:flutter/material.dart';

class ProviderGroup extends ChangeNotifier {
  bool isSelected = false;
  bool newLessonAdded = false;
  bool switcher = false;
  bool saveSchedule = false;
  bool switcherSchedule = false;
   TimeOfDay startlessonTime =TimeOfDay.now() ;
    TimeOfDay finishlessonTime  = TimeOfDay.now();

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
