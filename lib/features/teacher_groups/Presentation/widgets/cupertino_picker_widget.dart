import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerWidget extends StatelessWidget {
  List<Widget> listWidget ;
  void Function(int)? onSelected;

  CupertinoPickerWidget({super.key,required this.listWidget,required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      
     
        squeeze: 1,
        backgroundColor: Colors.white,
        scrollController: FixedExtentScrollController(initialItem: 1),
        itemExtent: 30,
        onSelectedItemChanged: onSelected,
        children: listWidget);
  }
}
