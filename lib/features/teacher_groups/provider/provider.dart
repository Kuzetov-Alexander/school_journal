import 'package:flutter/material.dart';

class ProviderGroupBool extends ChangeNotifier {
  bool isSelected =false;
   void changeColor () {
    
      isSelected=!isSelected;
    notifyListeners();
  }
}