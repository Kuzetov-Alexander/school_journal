import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:school_journal/common/color.dart';

class IosTimePicker extends StatefulWidget {
  DateTime time;
  String textTime;
  final Function(DateTime)? onTimeSelected;

  IosTimePicker(
      {super.key,
      required this.time,
      required this.textTime,
      this.onTimeSelected});

  @override
  State<IosTimePicker> createState() => _IosTimePickerState();
}

class _IosTimePickerState extends State<IosTimePicker> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return CupertinoButton(
        padding: const EdgeInsets.all(0),
        pressedOpacity: 0,
        child: Container(
            height: heightScreen * 0.035,
            width: widthScreen * 0.15,
            decoration: BoxDecoration(
                color: AppColors.greyforBoxTime,
                borderRadius: BorderRadius.circular(6)),
            child: Center(
                child: Text(
              widget.textTime,
              style: TextStyle(
                  color: AppColors.black212525,
                  fontSize: heightScreen * 0.025,
                  fontWeight: FontWeight.w400),
            ))),
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    initialDateTime: widget.time,
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        widget.onTimeSelected?.call(newTime);
                      });
                    },
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                  ),
                );
              });
        });
    ;
  }
}
