import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerWidget extends StatelessWidget {
  List<Widget> listWidget;
  void Function(int)? onSelected;

  CupertinoPickerWidget(
      {super.key, required this.listWidget, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: 1),
        squeeze: 1,
        backgroundColor: Colors.white,
        itemExtent: 30,
        onSelectedItemChanged: onSelected,
        children: listWidget);
  }
}
