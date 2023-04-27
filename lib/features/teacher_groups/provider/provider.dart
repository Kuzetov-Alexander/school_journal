import 'package:flutter/material.dart';

class Provider_group_bool extends ChangeNotifier {
  bool isSelected =false;
   void changeColor () {
    
      isSelected=!isSelected;
    notifyListeners();
  }
}