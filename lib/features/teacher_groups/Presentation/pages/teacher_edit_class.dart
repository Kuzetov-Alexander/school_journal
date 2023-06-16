import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc_general_schedule_bloc.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class TeacherEditClass extends StatefulWidget {
  final String lessonStartTime;
  final String lessonFinishTime;
  final String date;
  final String group;
  final String subject;

  const TeacherEditClass(
      {super.key,
      required this.date,
      required this.group,
      required this.subject,
      required this.lessonStartTime,
      required this.lessonFinishTime});

  @override
  State<TeacherEditClass> createState() => _TeacherEditClassState();
}

class _TeacherEditClassState extends State<TeacherEditClass> {
  final TextEditingController _controllerRoom = TextEditingController();
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish =
      DateTime(DateTime.now().hour, DateTime.now().minute);
  DateTime parsedDateTime = DateFormat('HH:mm').parse('14:02');

  void _changeLesson(
      context,
      String date,
      String startTime,
      String finishTime,
      String room,
      String changedFinishTime,
      String changedStartTime,
      String group,
      String subject) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context).add(ChangeLessonEvent(
      selectedDate: date,
      lessonTimeStart: startTime,
      lessonTimeFinish: finishTime,
      room: room,
      changedlessonTimeStart: changedStartTime,
      changedlessonTimeFinish: changedFinishTime,
      groupName: group,
      subject: subject,
    ));
  }

  void _getAllLessons(context, String date) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context)
        .add(GetAllLessonsEvent(selectedDate: date));
  }

  @override
  Widget build(BuildContext context) {
    ProviderGroup provider = Provider.of<ProviderGroup>(context);
    ProviderCalendar providerCalendar = Provider.of<ProviderCalendar>(context);
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
                          padding: const EdgeInsets.symmetric(vertical: 19.0),
                          child: Row(
                            children: [
                              Text(
                                widget.date,
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
                          controller: _controllerRoom,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffFAFAFA),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
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
                                fontSize: 12),
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
                            // Platform.isIOS
                            //     ?
                            IosTimePicker(
                              time: provider.dateTimestart,
                              textTime:
                                  '${provider.dateTimestart.hour.toString().padLeft(2, '0')}:${provider.dateTimestart.minute.toString().padLeft(2, '0')}',
                              onTimeSelected: (DateTime newTime) {
                                setState(() {
                                  provider.dateTimestart = newTime;
                                });
                              },
                            )
                            // : TimerPickerAndroid(
                            //     onTimeSelected: () {},
                            //     textTime: '${dateTimestart.hour.toString().padLeft(2, '0')}:${dateTimestart.minute.toString().padLeft(2, '0')}',
                            //     time: dateTimestart,
                            //   )
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
                              time: provider.dateTimefinish,
                              textTime:
                                  '${provider.dateTimefinish.hour.toString().padLeft(2, '0')}:${provider.dateTimefinish.minute.toString().padLeft(2, '0')}',
                              onTimeSelected: (DateTime newTime) {
                                setState(() {
                                  provider.dateTimefinish = newTime;
                                });
                              },
                            )
                            // :  TimerPickerAndroid(
                            //     onTimeSelected: () {},
                            //     textTime: '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                            //     time: dateTimefinish,
                            //   )
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
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(AppColors.purple),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _changeLesson(
                        context,
                        providerCalendar.day,
                        widget.lessonStartTime,
                        widget.lessonFinishTime,
                        _controllerRoom.text,
                        '${provider.dateTimefinish.hour.toString().padLeft(2, '0')}:${provider.dateTimefinish.minute.toString().padLeft(2, '0')}',
                        '${provider.dateTimestart.hour.toString().padLeft(2, '0')}:${provider.dateTimestart.minute.toString().padLeft(2, '0')}',
                        widget.group,
                        widget.subject);
                    await Future.delayed(const Duration(milliseconds: 100))
                        .then(
                      (_) {
                        _getAllLessons(context, providerCalendar.day);
                        Navigator.of(context).pop();
                      },
                    );
                  },
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
