import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_android.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';

class TeacherEditClass extends StatefulWidget {
  const TeacherEditClass({super.key});

  @override
  State<TeacherEditClass> createState() => _TeacherEditClassState();
}

class _TeacherEditClassState extends State<TeacherEditClass> {
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Image(
                                image: AssetImage(
                                    'assets/images/cross_icon.png'))),
                        SizedBox(
                          width: widthScreen / 4,
                        ),
                        Text(
                          'Изменить урок',
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.023,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: heightScreen * 0.001,
                  ),
                  Padding(
                    padding: EdgeInsets.all(heightScreen * 0.03),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.greyLight,
                      ),
                      height: heightScreen * 0.28,
                      width: widthScreen * 0.88,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 19.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${DateFormat('EEEE', 'ru').format(DateTime.now()).capitalize()} , ${DateFormat('d MMM', 'ru').format(DateTime.now())}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: heightScreen * 0.016,
                                        // letterSpacing: 1,
                                        color: AppColors.gray5a5a5a),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: heightScreen * 0.08,
                              width: widthScreen,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.greyLightSecond,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      'Кабинет (опционально)',
                                      style: TextStyle(
                                          color: AppColors.grey9d9d9d,
                                          fontSize: heightScreen * 0.02),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        // надо сделать так чтобы по клику слева появлялся TextField
                                      },
                                      icon: const Image(
                                        height: 20,
                                        image: AssetImage(
                                            'assets/images/pen_icon.png'),
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Начало',
                                  style: TextStyle(
                                      fontSize: heightScreen * 0.02,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black212525),
                                ),
                                Platform.isIOS
                                    ? IosTimePicker(
                                        time: dateTimestart,
                                        textTime:
                                            '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                        onTimeSelected: (DateTime newTime) {
                                          setState(() {
                                            dateTimefinish =
                                                newTime; // делать через блок или провайдер лучше?
                                          });
                                        },
                                      )
                                    : const TimerPickerAndroid()
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Конец',
                                  style: TextStyle(
                                      fontSize: heightScreen * 0.02,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black212525),
                                ),
                                Platform.isIOS
                                    ? IosTimePicker(
                                        time: dateTimestart,
                                        textTime:
                                            '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                        onTimeSelected: (DateTime newTime) {
                                          setState(() {
                                            dateTimefinish =
                                                newTime; // делать через блок или провайдер лучше?
                                          });
                                        },
                                      )
                                    : const TimerPickerAndroid()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.35,
                  ),
                  SizedBox(
                    height: 56,
                    width: widthScreen * 0.88,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            AppColors.purple),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Изменить',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: heightScreen * 0.022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}