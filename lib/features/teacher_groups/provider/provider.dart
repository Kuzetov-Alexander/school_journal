import 'package:flutter/material.dart';

class ProviderGroupBool extends ChangeNotifier {
  
  bool isSelected = false;
  bool newLessonAdded = false;
  bool switcher = false;
  bool saveSchedule = false;
  bool switcherSchedule = false;



  void saveScheduleFunc (switcherSchedule) {
    saveSchedule=switcherSchedule;
     notifyListeners();
  }

  void addNewLesson (switcher) {
    newLessonAdded=switcher;
     notifyListeners();
  }
   void changeColor () {
    
      isSelected=!isSelected;
    notifyListeners();
  }

}