import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc_general_schedule_bloc.dart';

import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class MyGroupInfoWidget extends StatelessWidget {
  final Map mapGroups;
  final int index;

  const MyGroupInfoWidget(
      {super.key, required this.mapGroups, required this.index});

  void _getCurrentLessons(context, String date, String group) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context)
        .add(GetCurrentLessonsEvent(selectedDate: date, groupName: group));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderGroup>(context);
    final providerScores = Provider.of<ProviderScores>(context);
    final providerCalendar = Provider.of<ProviderCalendar>(context);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            provider.currentGroup = mapGroups['GroupName'].toString();
            providerScores.currentGroup = mapGroups['GroupName'].toString();
            // print('${mapGroups['allStudents']}');
            _getCurrentLessons(
                context, providerCalendar.day, provider.currentGroup);
            await Future.delayed(const Duration(milliseconds: 30))
                .then((_) => context.goNamed('TeacherGroup'));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.greyLight,
            ),
            height: heightScreen * 0.15,
            width: widthScreen * 0.9,
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                    child: Text(
                      mapGroups['GroupName'].toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: heightScreen * 0.02),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child:
                        Text('Ближайшее занятие: ${mapGroups['nextLesson']}'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: 8,
                        image: AssetImage('assets/images/arrow.png'),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const Image(
                        image: AssetImage('assets/images/mini_person.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    provider.amountStudent(mapGroups),
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
