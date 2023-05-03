import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/change_day_schedule.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class TeacherChangeSchedule extends StatefulWidget {
  const TeacherChangeSchedule({super.key});

  @override
  State<TeacherChangeSchedule> createState() => _TeacherChangeScheduleState();
}

class _TeacherChangeScheduleState extends State<TeacherChangeSchedule> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
                          width: widthScreen / 6,
                        ),
                        Text(
                          'Изменить расписание',
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
                    padding: EdgeInsets.symmetric(
                        horizontal: widthScreen * 0.05,
                        vertical: heightScreen * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Дни недели',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.022),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: widthScreen * 0.9,
                    height: heightScreen * 0.68,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: heightScreen * 0.02,
                          );
                        },
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                               showModalBottomSheet(
               
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const TeacherChangeDaySchedule());


                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.greyLight,
                              ),
                              width: widthScreen * 0.8,
                              height: heightScreen * 0.075,
                              child: ListTile(
                                title: Text(
                                    DateFormat('EEEE', 'ru_RU')
                                        .format(DateTime.now()
                                            .add(Duration(days: index - 1)))
                                        .capitalize(),
                                    style: const TextStyle(
                                        color: AppColors.black212525,
                                        fontWeight: FontWeight.w600)),
                                subtitle: const Text(
                                  'Нет занятий',
                                  style: TextStyle(
                                      color: AppColors.grey9d9d9d,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: const Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/arrow.png')),
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.greyLightSecond,
                    ),
                    height: heightScreen * 0.08,
                    width: widthScreen * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: widthScreen*0.5,
                            child: Text(
                              'Сделать расписание еженедельным',
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: heightScreen * 0.018,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Platform.isIOS
                              ? CupertinoSwitch(
                                  activeColor: AppColors.purple,
                                  value: context
                                      .watch<ProviderGroupBool>()
                                      .saveSchedule,
                                  onChanged: (value) {
                                    context
                                        .read<ProviderGroupBool>()
                                        .saveScheduleFunc(value);
                                  },
                                )
                              : Switch(
                                  value: context
                                      .watch<ProviderGroupBool>()
                                      .saveSchedule,
                                  onChanged: (value) {
                                    context
                                        .read<ProviderGroupBool>()
                                        .saveScheduleFunc(value);
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
              height: heightScreen * 0.015,
            ),
                ],
              ),
            ),
      ],
    );
  }
}
