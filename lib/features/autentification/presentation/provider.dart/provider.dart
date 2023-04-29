import 'package:flutter/material.dart';

class Provider_Login_bool extends ChangeNotifier {
  bool teacher =true;
   void changedTypePerson (bool answer) {
    
      if (teacher != answer) {
        teacher = answer;
      } 
    notifyListeners();
  }
}