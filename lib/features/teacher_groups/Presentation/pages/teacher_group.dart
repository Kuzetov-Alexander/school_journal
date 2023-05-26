import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/bloc/bloc_teacher_groups_bloc.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/lessons_in_group_schedule_widget.dart';

import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class TeacherGroupPage extends StatefulWidget {
  const TeacherGroupPage({
    super.key,
  });

  @override
  State<TeacherGroupPage> createState() => _TeacherGroupPageState();
}

class _TeacherGroupPageState extends State<TeacherGroupPage> {
void _getCurrentLessons(context, String date, String group) {
    BlocProvider.of<BlocTeacherGroupsBloc>(context).add(
                GetCurrentLessonsEvent(selectedDate: date ,groupName: group
                    ));
  }

  @override
  Widget build(BuildContext context) {
    
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    ScrollController scrollController = ScrollController();

    final provider = Provider.of<ProviderGroup>(context);
    final providerCalendar = Provider.of<ProviderCalendar>(context);
    DateTime curentDateTime = context.watch<ProviderCalendar>().currentDate;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.go('/Groups'),
          child: const Image(
            image: AssetImage('assets/images/arrow_left.png'),
          ),
        ),
        title: Text(
          ' ${provider.currentGroup}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: heightScreen * 0.022,
              color: AppColors.black212525),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: heightScreen * 0.015),
                    Row(
                      children: [
                        Text(
                          'Ученики',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: heightScreen * 0.024,
                              color: AppColors.black212525),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightScreen * 0.01,
                    ),
                    Container(
                      height: heightScreen * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '27 учеников',
                              style: TextStyle(color: Colors.white),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  context.goNamed('StudentScores');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: Text(
                                  'Все',
                                  style: TextStyle(
                                      color: AppColors.black212525,
                                      fontSize: heightScreen * 0.019,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.015),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Расписание',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: heightScreen * 0.024,
                            color: AppColors.black212525),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.01),
                    Container(
                      height: heightScreen * 0.22,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(33)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthScreen * 0.04),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightScreen * 0.018),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    splashRadius: 1,
                                    onPressed: () {
                                      setState(() {
                                         context
                                          .read<ProviderCalendar>()
                                          .getPreviousMonth();
                                      });
                                     
                                    },
                                    icon: const Image(
                                      image: AssetImage(
                                          'assets/images/arrow_left_white.png'),
                                    ),
                                  ),
                             
                                  Text(
                                    '${DateFormat('MMMM', 'ru').format(curentDateTime)} ${DateFormat('yyyy', 'ru').format(curentDateTime)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: heightScreen * 0.024,
                                        fontWeight: FontWeight.w600),
                                  ),

                                  IconButton(
                                    splashRadius: 1,
                                    onPressed: () {
                                      setState(() {
                                          context
                                          .read<ProviderCalendar>()
                                          .getNextMonth();
                                      });
                                    
                                    },
                                    icon: const Image(
                                      image: AssetImage(
                                          'assets/images/arrow_right_white.png'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                // формула для вывода дней в текущем месяце,
                                // все что вне текущего месяца не учитывается
                                itemCount: curentDateTime.month % 2 == 0
                                    ? DateTime(curentDateTime.year,
                                                curentDateTime.month, 0)
                                            .day -
                                        1
                                    : 1 +
                                        DateTime(curentDateTime.year,
                                                curentDateTime.month, 0)
                                            .day,

                                itemBuilder: (BuildContext context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        curentDateTime.day - 1 == index;
                                   
                                      context
                                          .read<ProviderCalendar>()
                                          .getSelectedDate(index);
                                      });
                                      
                                      _getCurrentLessons(context,providerCalendar.day,provider.currentGroup);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: curentDateTime.day - 1 == index
                                            ? Colors.white
                                            : AppColors.purple,
                                        border: Border.all(
                                          width: 1,
                                          color: curentDateTime.day - 1 == index
                                              ? Colors.white
                                              : Colors.purple.withOpacity(0.4),
                                        ),
                                      ),
                                      height: heightScreen * 0.02,
                                      width: widthScreen * 0.13,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: widthScreen * 0.015),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // TODO(Sanya) Подумать как внедрить по другому?
                                          Text(
                                            context
                                                .read<ProviderCalendar>()
                                                .getDayOfWeek(index),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: curentDateTime.day - 1 ==
                                                        index
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),

                                          Text(
                                            DateTime(DateTime.now().year,
                                                    DateTime.now().month, 1)
                                                .add(Duration(days: index))
                                                .day
                                                .toString(),
                                            style: TextStyle(
                                                color: curentDateTime.day - 1 ==
                                                        index
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),

                                          Icon(
                                            Icons.circle_rounded,
                                            color:
                                                curentDateTime.day - 1 == index
                                                    ? AppColors.purple
                                                    : Colors.white,
                                            size: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.04,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${DateFormat('EEEE', 'ru').format(curentDateTime).capitalize()} , ${DateFormat('d MMM', 'ru').format(
                            curentDateTime,
                          )}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: heightScreen * 0.024,
                              // letterSpacing: 1,
                              color: AppColors.black212525),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightScreen * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'Время',
                          style: TextStyle(
                              color: AppColors.greybcc1cd,
                              fontSize: heightScreen * 0.02,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: widthScreen * 0.05,
                        ),
                        Text(
                          'Урок',
                          style: TextStyle(
                              color: AppColors.greybcc1cd,
                              fontSize: heightScreen * 0.02,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightScreen * 0.02,
                    ),
                    const LessonsInGroupSchedule(),
                  ],
                ),
              ))),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
