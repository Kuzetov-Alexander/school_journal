

import 'package:flutter/material.dart';

import 'package:school_journal/common/color.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/timer_picker_ios.dart';

class TeacherChangeDaySchedule extends StatefulWidget {
  const TeacherChangeDaySchedule({super.key});

  @override
  State<TeacherChangeDaySchedule> createState() =>
      _TeacherChangeDayScheduleState();
}

final TextEditingController _controllerClass = TextEditingController();

class _TeacherChangeDayScheduleState extends State<TeacherChangeDaySchedule> {
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTimeAndroid = TimeOfDay.now();
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
                            image: AssetImage('assets/images/arrow_left.png'))),
                    SizedBox(
                      width: widthScreen / 4,
                    ),
                    Text(
                      'Понедельник',
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
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  width: widthScreen * 0.9,
                  height: heightScreen * 0.6,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: heightScreen * 0.02,
                        );
                      },
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.greyLight,
                            ),
                            height: heightScreen * 0.28,
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
                                          'Урок 1',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: heightScreen * 0.016,
                                              // letterSpacing: 1,
                                              color: AppColors.gray5a5a5a),
                                        ),
                                        InkWell(
                                          onTap: () {},
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
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
                                        borderSide: BorderSide(
                                            color: Color(0xffFAFAFA)),
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
                                        image: AssetImage(
                                            'assets/images/pen_icon.png'),
                                        color: Colors.black,
                                      ),
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
                                              time: dateTimestart,
                                              textTime:
                                                  '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                              onTimeSelected:
                                                  (DateTime newTime) {
                                                setState(() {
                                                  dateTimefinish =
                                                      newTime; // делать через блок или провайдер лучше?
                                                });
                                              },
                                            )
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
                                              time: dateTimefinish,
                                              textTime:
                                                  '${dateTimefinish.hour.toString().padLeft(2, '0')}:${dateTimefinish.minute.toString().padLeft(2, '0')}',
                                              onTimeSelected:
                                                  (DateTime newTime) {
                                                setState(() {
                                                  dateTimefinish =
                                                      newTime; // делать через блок или провайдер лучше?
                                                });
                                              },
                                            )
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
                  height: heightScreen * 0.075,
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
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    alertDialogCreateLesson(
                                        widthScreen, heightScreen));
                          },
                          child: const Image(
                              image: AssetImage(
                                  'assets/images/blackplus_icon.png')),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: heightScreen * 0.05,
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

  AlertDialog alertDialogCreateLesson(double widthScreen, double heightScreen) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: widthScreen * 0.5,
        height: heightScreen * 0.25,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                  style: TextStyle(
                      fontSize: heightScreen * 0.025,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black212525),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Выбрать предмет'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Выгрузить в Excel'),
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.greybcc1cd)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ок"))
              ],
            );
          },
        ),
      ),
    );
  }
}
