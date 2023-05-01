

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_journal/common/color.dart';

class TimerPickerAndroid
 extends StatefulWidget {
  const TimerPickerAndroid({super.key});

  @override
  State<TimerPickerAndroid> createState() => _TimerPickerAndroid();
}

class _TimerPickerAndroid extends State<TimerPickerAndroid> {
  TimeOfDay selectedTime = TimeOfDay.now();
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
                child: Text('${selectedTime.hour.toString().padLeft(2,'0')}:${selectedTime.minute.toString().padLeft(2,'0')}',style: TextStyle(
                  color: AppColors.black212525,
                  fontSize: heightScreen * 0.025,
                  fontWeight: FontWeight.w400),)
                
                )),
        onPressed: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: selectedTime
          ,
          initialEntryMode: TimePickerEntryMode.dial
          );
          if (timeOfDay != null) {
            setState(() {
              selectedTime =timeOfDay;
            });
          }
        });
  }
}