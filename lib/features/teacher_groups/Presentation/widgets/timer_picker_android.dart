import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class TimerPickerAndroidStart extends StatefulWidget {
  const TimerPickerAndroidStart({super.key});

  @override
  State<TimerPickerAndroidStart> createState() => _TimerPickerAndroidStart();
}

class _TimerPickerAndroidStart extends State<TimerPickerAndroidStart> {
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
                child: Text(
              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: AppColors.black212525,
                  fontSize: heightScreen * 0.025,
                  fontWeight: FontWeight.w400),
            ))),
        onPressed: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              initialEntryMode: TimePickerEntryMode.dial);
          if (timeOfDay != null) {
            setState(() {
              selectedTime = timeOfDay;
            });
            context.watch<ProviderGroup>().startlessonTime = timeOfDay;
          }
        });
  }
}




class TimerPickerAndroidFinish extends StatefulWidget {
  const TimerPickerAndroidFinish({super.key});

  @override
  State<TimerPickerAndroidFinish> createState() => _TimerPickerAndroidFinish();
}

class _TimerPickerAndroidFinish extends State<TimerPickerAndroidFinish> {
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
                child: Text(
              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: AppColors.black212525,
                  fontSize: heightScreen * 0.025,
                  fontWeight: FontWeight.w400),
            ))),
        onPressed: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              initialEntryMode: TimePickerEntryMode.dial);
          if (timeOfDay != null) {
            setState(() {
              selectedTime = timeOfDay;
              
            });
            context.watch<ProviderGroup>().finishlessonTime = timeOfDay;
          }
        });
  }
}
