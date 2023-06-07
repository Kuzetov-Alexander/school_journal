import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerWidget extends StatelessWidget {
  final List<Widget> listWidget;
  final ValueChanged<int> onSelected;

  const CupertinoPickerWidget({
    super.key,
    required this.listWidget,
    required this.onSelected,
  });

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
