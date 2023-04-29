import 'package:flutter/material.dart';

class ProviderLoginBool extends ChangeNotifier {
  bool teacher =true;
   void changedTypePerson (bool answer) {
    
      if (teacher != answer) {
        teacher = answer;
      } 
    notifyListeners();
  }
}