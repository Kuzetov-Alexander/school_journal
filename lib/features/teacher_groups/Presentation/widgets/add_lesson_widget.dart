import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/bloc/bloc_teacher_groups_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';

import 'package:school_journal/features/teacher_groups/provider/provider.dart';

import 'timer_picker_android.dart';

class BottomSheetModal extends StatefulWidget {
  

  BottomSheetModal({super.key, });

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
  
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  List<String> listGroupNames = [];
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  late final TextEditingController _controllerClass = TextEditingController();
  late final TextEditingController _controllerClassSecond =
      TextEditingController();
  late final TextEditingController _controllerClassThird =
      TextEditingController();

  void _downloadNameGroups(context) {
    BlocProvider.of<BlocTeacherGroupsBloc>(context)
        .add(DownloadNameGroupsEvent());
  }


  @override
  Widget build(BuildContext context) {
     String selectedGroup ='';
    final db = FirebaseDatabase.instance.ref().child('Groups');
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocConsumer<BlocTeacherGroupsBloc, BlocTeacherGroupsState>(
      listener: (context, state) {
       if (state is DownloadNameGroupsState) {
         
            // print(state.allNamesGroup);
          final List<String> listNames =[];
          listGroupNames = listNames + state.allNamesGroup;
        
          //  print(widget.listGroupNames);
          }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
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
                              image:
                                  AssetImage('assets/images/cross_icon.png'))),
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
                    height: heightScreen * 0.5,
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xffFAFAFA)),
                            width: double.infinity,
                            height: heightScreen * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(listGroupNames.isEmpty
                                    ? ''
                                    : "$selectedGroup"),
                                TextButton(
                                  onPressed: () {
                                    _downloadNameGroups(context);
                                   
                                    setState(() {});

                                  
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: heightScreen * 0.7),
                                            child: CupertinoPicker(
                                              backgroundColor: Colors.white,
                                              scrollController:
                                                  FixedExtentScrollController(
                                                      initialItem: 0),
                                              itemExtent: 30,
                                              onSelectedItemChanged: (value) {
                                                setState(
                                                  () {
                                                    selectedGroup =
                                                        listGroupNames[value];
                                                  },
                                                );
                                              },
                                              children: listGroupNames
                                                  .map((e) => Text(e))
                                                  .toList(),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text('Выбрать группу'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: heightScreen * 0.015,
                          ),
                          TextformFieldWidget(
                            controllerClass: _controllerClassSecond,
                            hintTextx: 'Введите предмет',
                            labelTextx: 'Предмет',
                          ),
                          SizedBox(
                            height: heightScreen * 0.015,
                          ),
                          TextformFieldWidget(
                            controllerClass: _controllerClassThird,
                            hintTextx: 'Введите кабинет (не обязательно)',
                            labelTextx: 'Кабинет',
                          ),
                          SizedBox(
                            height: heightScreen * 0.015,
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
                                value: context
                                    .watch<ProviderGroupBool>()
                                    .newLessonAdded,
                                onChanged: (value) {
                                  context
                                      .read<ProviderGroupBool>()
                                      .addNewLesson(value);
                                },
                              )
                            : Switch(
                                value: context
                                    .watch<ProviderGroupBool>()
                                    .newLessonAdded,
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
                  height: heightScreen * 0.1,
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
      },
    );
  }
}

class TextformFieldWidget extends StatelessWidget {
  const TextformFieldWidget({
    super.key,
    required TextEditingController controllerClass,
    required this.hintTextx,
    required this.labelTextx,
  }) : _controllerClass = controllerClass;

  final TextEditingController _controllerClass;
  final String hintTextx;
  final String labelTextx;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      autocorrect: false,
      buildCounter: (BuildContext context,
              {int? currentLength, required bool isFocused, int? maxLength}) =>
          null,
      maxLength: 20,
      controller: _controllerClass,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffFAFAFA),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: Color(0xffFAFAFA),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(color: Color(0xffFAFAFA)),
        ),
        hintText: hintTextx,
        hintStyle: const TextStyle(
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w600,
            fontSize: 14),
        labelText: labelTextx,
        labelStyle: const TextStyle(
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w600,
            fontSize: 10),
        suffixIcon: const Image(
          height: 20,
          image: AssetImage('assets/images/pen_icon.png'),
          color: Colors.black,
        ),
      ),
    );
  }
}
