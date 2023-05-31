import 'package:flutter/material.dart';

class ProviderLoginBool extends ChangeNotifier {
  int? indexDoubleButton =0;
  bool teacher =true;
   void changedTypePerson (bool answer) {
    
      if (teacher != answer) {
        teacher = answer;
      } 
    notifyListeners();
  }
}