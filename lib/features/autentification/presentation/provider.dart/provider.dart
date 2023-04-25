import 'package:flutter/material.dart';

class Providerbool extends ChangeNotifier {
  bool teacher =true;
   void changedTypePerson (bool answer) {
    
      if (teacher != answer) {
        teacher = answer;
      } 
    notifyListeners();
  }
}