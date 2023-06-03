import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:school_journal/common/color.dart';

import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc_general_schedule_bloc.dart';

import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/cupertino_picker_widget.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';

import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

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
  DateTime timeStartAndroid = DateTime.now();
  DateTime timeFinishAndroid = DateTime.now();

  late final TextEditingController _controllerSubject = TextEditingController();
  late final TextEditingController _controllerRoom = TextEditingController();

  void _downloadSubjects(context, String selectedGroup) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context)
        .add(DownloadSubjectNameEvent(selectedGroup: selectedGroup));
  }

  void _addLesson(context, String groupName, String currentDay) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context).add(AddLessonEvent(
        groupName: groupName,
        lessonRoom: _controllerRoom.text,
        lessonTimeStart: DateFormat.Hm().format(
            // Platform.isIOS
            //   ?
            dateTimestart
            // : timeStartAndroid
            ),
        lessonTimeFinish: DateFormat.Hm().format(
            // Platform.isIOS
            //   ?
            dateTimefinish
            // : timeFinishAndroid
            ),
        subject: _controllerSubject.text,
        selectedDate: currentDay));
  }
//
  void _getAllLessons(context, String date) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context)
        .add(GetAllLessonsEvent(selectedDate: date));
  }

  void _downloadNameGroups(context) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context)
        .add(DownloadGroupNameEvent());
  }

  showTip(BuildContext context, double height, String hint) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: height),
            child: Text(
              hint,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    int indexValueGroup = 0;
    int indexValueSubject = 0;
    // TimeOfDay timeStart = context.watch<ProviderGroup>().startlessonTime;
    //   DateTime  timeStartAndroid =  DateTime(year)  ;

    ProviderCalendar providerDate = Provider.of<ProviderCalendar>(context);
    ProviderGroup provider = Provider.of<ProviderGroup>(context);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocConsumer<BlocGeneralScheduleBloc, BlocGeneralScheduleState>(
      listener: (context, state) {
        if (state is DownloadGroupNameState) {
          
          provider.updateGroupNameList(state.allNamesGroup);
        }
        if (state is DownloadSubjectNameState) {
          provider.updateSubjectList(state.allSubjectGroup);
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
                                  '${DateFormat('EEEE', 'ru').format(providerDate.currentDate).capitalize()} , ${DateFormat('d MMM', 'ru').format(providerDate.currentDate)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: heightScreen * 0.016,
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.selectedGroup,
                                    style: TextStyle(
                                        fontSize: heightScreen * 0.019),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      _controllerSubject.text = '';
                                      _downloadNameGroups(context);

                                      await Future.delayed(
                                              const Duration(milliseconds: 50))
                                          .then((_) {
                                        if (provider.listGroup.isNotEmpty) {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      top: heightScreen * 0.7),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CupertinoPickerWidget(
                                                          listWidget: provider
                                                              .listGroup
                                                              .map((e) =>
                                                                  Text(e))
                                                              .toList(),
                                                          onSelected: (value) {
                                                            setState(() {
                                                              indexValueGroup =
                                                                  value;
                                                            });
                                                            provider.selectedGroup =
                                                                provider.listGroup[
                                                                    value];
                                                          },
                                                        ),
                                                      ),
                                                      ColoredBox(
                                                        color: Colors.white,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CupertinoButton(
                                                                child: const Text(
                                                                    'Подтвердить'),
                                                                onPressed: () {
                                                                  provider
                                                                      .selectedGroup = provider
                                                                          .listGroup[
                                                                      indexValueGroup];
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        } else {
                                          showTip(context, heightScreen * 0.73,
                                              'Необходимо сначала создать группу');
                                        }
                                      });
                                    },
                                    child: const Text('Выбрать группу'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen * 0.015,
                          ),
                          TextformFieldWidget(
                            controllerClass: _controllerSubject,
                            hintTextx: 'Введите предмет',
                            labelTextx: 'Предмет',
                            iconButton: InkWell(
                              onTap: () async {
                                _downloadSubjects(
                                    context, provider.selectedGroup);

                                await Future.delayed(
                                        const Duration(milliseconds: 50))
                                    .then((_) {
                                  if (provider.listSubjects.isNotEmpty) {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: heightScreen * 0.7),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CupertinoPickerWidget(
                                                    listWidget: provider
                                                        .listSubjects
                                                        .map((e) => Text(e))
                                                        .toList(),
                                                    onSelected: (value) {
                                                      setState(() {
                                                        indexValueSubject =
                                                            value;
                                                      });
                                                      _controllerSubject.text =
                                                          provider.listSubjects[
                                                              value];
                                                    },
                                                  ),
                                                ),
                                                ColoredBox(
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CupertinoButton(
                                                          child: const Text(
                                                              'Подтвердить'),
                                                          onPressed: () {
                                                            _controllerSubject
                                                                .text = provider
                                                                    .listSubjects[
                                                                indexValueSubject];
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    showTip(context, heightScreen * 0.73,
                                        'Для данной группы предметы не найдены');
                                  }
                                });
                              },
                              child: const Image(
                                height: 20,
                                image: AssetImage('assets/images/pen_icon.png'),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScreen * 0.015,
                          ),
                          TextformFieldWidget(
                            controllerClass: _controllerRoom,
                            hintTextx: 'Введите кабинет (не обязательно)',
                            labelTextx: 'Кабинет',
                            iconButton: null,
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
                              // Platform.isIOS
                              //     ?
                              IosTimePicker(
                                time: dateTimestart,
                                textTime:
                                    '${dateTimestart.hour.toString().padLeft(2, '0')}:${dateTimestart.minute.toString().padLeft(2, '0')}',
                                onTimeSelected: (DateTime newTime) {
                                  setState(
                                    () {
                                      dateTimestart = newTime;
                                    },
                                  );
                                },
                              )
                              // : const TimerPickerAndroidStart()
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
                              // Platform.isIOS
                              //     ?
                              IosTimePicker(
                                time: dateTimefinish,
                                textTime:
                                    '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                onTimeSelected: (DateTime newTimefinish) {
                                  setState(() {
                                    dateTimefinish =
                                        newTimefinish; // делать через блок или провайдер лучше?
                                  });
                                },
                              )
                              // : const TimerPickerAndroidFinish()
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
                        Expanded(
                          child: Text(
                            'Добавить в еженедельное расписание',
                            style: TextStyle(
                                fontSize: heightScreen * 0.018,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Platform.isIOS
                            ? CupertinoSwitch(
                                activeColor: AppColors.purple,
                                value: context
                                    .watch<ProviderGroup>()
                                    .newLessonAdded,
                                onChanged: (value) {
                                  context
                                      .read<ProviderGroup>()
                                      .addNewLesson(value);
                                  provider.newLessonSaved = value;
                                },
                              )
                            : Switch(
                                value: context
                                    .watch<ProviderGroup>()
                                    .newLessonAdded,
                                onChanged: (value) {
                                  context
                                      .read<ProviderGroup>()
                                      .addNewLesson(value);
                                  provider.newLessonSaved = value;
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
                    onPressed: () {
                      _addLesson(
                          context,
                          provider.selectedGroup,
                          DateFormat('dd-MM-yyyy', 'ru')
                              .format(providerDate.currentDate));
                      setState(() {
                        _controllerSubject.text = '';
                        _controllerRoom.text = '';
                      });
                      Navigator.of(context).pop();
                      _getAllLessons(context, providerDate.day);
                    },
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
    required this.iconButton,
  }) : _controllerClass = controllerClass;

  final InkWell? iconButton;

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
        suffixIcon: iconButton,
      ),
    );
  }
}
