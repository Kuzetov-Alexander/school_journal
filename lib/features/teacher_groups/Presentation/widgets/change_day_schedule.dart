import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc_general_schedule_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/add_lesson_widget.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/cupertino_picker_widget.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class TeacherChangeDaySchedule extends StatefulWidget {
  const TeacherChangeDaySchedule({super.key, required this.index});
  final int index;
  @override
  State<TeacherChangeDaySchedule> createState() =>
      _TeacherChangeDayScheduleState();
}

void _downloadNameGroups(context) {
  BlocProvider.of<BlocGeneralScheduleBloc>(context)
      .add(DownloadGroupNameEvent());
}

// функция добавления нового экземпляра урока
void _handleTap(context, ProviderGroup provider, int index) {
  if (provider.lengthWeeklyLessonsList > 7) {
    return; // Ничего не делаем, если условие выполняется
  }

  provider.increaseLength(index);
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

class _TeacherChangeDayScheduleState extends State<TeacherChangeDaySchedule> {
  @override
  Widget build(BuildContext context) {
    int indexValueGroup = 0;
    // ProviderCalendar providerDate = Provider.of<ProviderCalendar>(context);
    ProviderGroup provider = Provider.of<ProviderGroup>(context);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.05, top: 4),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Image(
                          image: AssetImage('assets/images/arrow_left.png')),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          provider.weekdays[widget.index],
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.023,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
              Container(
                color: Colors.grey,
                height: heightScreen * 0.001,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: widthScreen * 0.9,
                  height: heightScreen * 0.7,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: heightScreen * 0.02,
                        );
                      },
                      itemCount: provider.lengthWeeklyLessonsList,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.greyLight,
                          ),
                          height: heightScreen * 0.40,
                          width: widthScreen * 0.88,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 19.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Урок ${index + 1}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: heightScreen * 0.016,
                                            // letterSpacing: 1,
                                            color: AppColors.gray5a5a5a),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          provider.reduceLength(
                                              widget.index, index);
                                        },
                                        child: const Image(
                                          height: 20,
                                          image: AssetImage(
                                              'assets/images/delete_icon.png'),
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffFAFAFA)),
                                  width: double.infinity,
                                  height: heightScreen * 0.06,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
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
                                            _downloadNameGroups(context);

                                            await Future.delayed(const Duration(
                                                    milliseconds: 50))
                                                .then((_) {
                                              if (provider
                                                  .listGroup.isNotEmpty) {
                                                showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            top: heightScreen *
                                                                0.7),
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
                                                                onSelected:
                                                                    (value) {
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
                                                              color:
                                                                  Colors.white,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  CupertinoButton(
                                                                      child: const Text(
                                                                          'Подтвердить'),
                                                                      onPressed:
                                                                          () {
                                                                        provider
                                                                            .selectedGroup = provider
                                                                                .listGroup[
                                                                            indexValueGroup];
                                                                        Navigator.of(context)
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
                                                showTip(
                                                    context,
                                                    heightScreen * 0.73,
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
                                SizedBox(
                                  height: heightScreen * 0.06,
                                  child: const TextformFieldWidget(
                                    hintTextx: 'Введите предмет',
                                    labelTextx: 'Предмет',
                                  ),
                                ),
                                SizedBox(
                                  height: heightScreen * 0.015,
                                ),
                                SizedBox(
                                  height: heightScreen * 0.06,
                                  child: const TextformFieldWidget(
                                    hintTextx: 'Введите кабинет',
                                    labelTextx: 'Кабинет (не обязательно)',
                                  ),
                                ),
                                SizedBox(
                                  height: heightScreen * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      time: provider.timeListstart[index],
                                      textTime:
                                          '${provider.timeListstart[widget.index].hour.toString().padLeft(2, '0')}:${provider.timeListstart[index].minute.toString().padLeft(2, '0')}',
                                      onTimeSelected: (DateTime newTime) {
                                        setState(
                                          () {
                                            provider.timeListstart[index] = newTime;
                                          },
                                        );
                                      },
                                    )
                                    // : const TimerPickerAndroidStart()
                                    //       :  TimerPickerAndroid(
                                    //   onTimeSelected: () async {
                                    //     final TimeOfDay? timeStartLesson =
                                    //         await showTimePicker(
                                    //             context: context,
                                    //             initialTime:
                                    //                 selectedTimeAndroid,
                                    //             initialEntryMode:
                                    //                 TimePickerEntryMode.dial);
                                    //     if (timeStartLesson != null) {
                                    //       setState(() {
                                    //         selectedTimeAndroid =
                                    //             timeStartLesson;
                                    //       });
                                    //     }
                                    //   },
                                    //   textTime:
                                    //       '${dateTimestart.hour.toString().padLeft(2, '0')}:${dateTimestart.minute.toString().padLeft(2, '0')}',
                                    //   time: dateTimestart,
                                    // )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      time: provider.timeListfinish[index],
                                      textTime:
                                          '${provider.timeListfinish[index].hour.toString().padLeft(2, '0')}:${provider.timeListfinish[widget.index].minute.toString().padLeft(2, '0')}',
                                      onTimeSelected: (DateTime newTimefinish) {
                                        setState(() {
                                          provider.timeListfinish[index] =
                                              newTimefinish; // делать через блок или провайдер лучше?
                                        });
                                      },
                                    )
                                    // : const TimerPickerAndroidFinish()
                                    //       : TimerPickerAndroid(
                                    //   onTimeSelected: () async {
                                    //     final TimeOfDay? timeFinishLesson =
                                    //         await showTimePicker(
                                    //             context: context,
                                    //             initialTime:
                                    //                 selectedTimeAndroid,
                                    //             initialEntryMode:
                                    //                 TimePickerEntryMode.dial);
                                    //     if (timeFinishLesson != null) {
                                    //       setState(() {
                                    //         selectedTimeAndroid =
                                    //             timeFinishLesson;
                                    //       });
                                    //     }
                                    //   },
                                    //   textTime:
                                    //       '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                    //   time: dateTimefinish,
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.greyLight,
                  ),
                  width: widthScreen * 0.88,
                  height: heightScreen * 0.055,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widthScreen * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Добавить урок',
                            style: TextStyle(
                                color: AppColors.black212525,
                                fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () =>
                              _handleTap(context, provider, widget.index),
                          child: const Image(
                              image: AssetImage(
                                  'assets/images/blackplus_icon.png')),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: heightScreen * 0.03,
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
                    'Сохранить',
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
