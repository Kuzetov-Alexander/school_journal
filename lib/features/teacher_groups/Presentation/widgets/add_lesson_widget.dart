import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';

import 'package:school_journal/features/teacher_groups/provider/provider.dart';

import 'timer_picker_android.dart';

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({super.key});

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  late final TextEditingController _controllerClass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(children: [
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
                          image: AssetImage('assets/images/cross_icon.png'))),
                  SizedBox(
                    width: widthScreen / 4,
                  ),
                  Text(
                    'Добавить урок',
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
                        padding: const EdgeInsets.symmetric(vertical: 19.0),
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        buildCounter: (BuildContext context,
                                {int? currentLength,
                                required bool isFocused,
                                int? maxLength}) =>
                            null,
                        maxLength: 20,
                        controller: _controllerClass,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffFAFAFA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xffFAFAFA),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Color(0xffFAFAFA)),
                          ),
                          hintText: 'Введите кабинет',
                          hintStyle: TextStyle(
                              color: Color(0xff9D9D9D),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          labelText: 'Кабинет (не обязательно)',
                          labelStyle: TextStyle(
                              color: Color(0xff9D9D9D),
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          suffixIcon: Image(
                            height: 20,
                            image: AssetImage('assets/images/pen_icon.png'),
                            color: Colors.black,
                          ),
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
                                    setState(
                                      () {
                                        dateTimefinish = newTime;
                                        // TODO(Sanya) Делать через блок или провайдер лучше?
                                      },
                                    );
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.greyLight,
              ),
              height: heightScreen * 0.08,
              width: widthScreen * 0.88,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Добавить в расписание',
                      style: TextStyle(
                          fontSize: heightScreen * 0.018,
                          fontWeight: FontWeight.w600),
                    ),
                    Platform.isIOS
                        ? CupertinoSwitch(
                            activeColor: AppColors.purple,
                            value:
                                context.watch<ProviderGroupBool>().newLessonAdded,
                            onChanged: (value) {
                              context
                                  .read<ProviderGroupBool>()
                                  .addNewLesson(value);
                            },
                          )
                        : Switch(
                            value:
                                context.watch<ProviderGroupBool>().newLessonAdded,
                            onChanged: (value) {
                              context
                                  .read<ProviderGroupBool>()
                                  .addNewLesson(value);
                            },
                          ),
                  ],
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
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(AppColors.purple),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Добавить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
             SizedBox(
              height: heightScreen * 0.015,
            ),
          ]),
        ),
      ],
    );
  }
}
