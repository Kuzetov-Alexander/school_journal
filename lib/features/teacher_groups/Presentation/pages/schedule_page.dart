import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc/bloc_general_schedule_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/teacher_group/bloc_teacher_groups_bloc.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/add_lesson_widget.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/change_schedule_widget.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/lessons_in_general_schedule_widget.dart';

import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

/// Чтобы отслеживать прокрутку ListView
ScrollController scrollController = ScrollController();

void _getAllLessons(context, String date) {
  BlocProvider.of<BlocGeneralScheduleBloc>(context)
      .add(GetAllLessonsEvent(selectedDate: date));
}

void _downloadNameGroups(context) {
  BlocProvider.of<BlocGeneralScheduleBloc>(context).add(DownloadGroupNameEvent());
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    DateTime curentDateTime = context.watch<ProviderCalendar>().currentDate;
    ProviderCalendar provider = Provider.of<ProviderCalendar>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.go('/Groups'),
          child: const Image(
            image: AssetImage(
                'assets/images/arrow_left.png'), // вставляется с фоном , надо что-то придумать
          ),
        ),
        title: Text(
          'Расписание',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: heightScreen * 0.024,
              color: AppColors.black212525),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<BlocTeacherGroupsBloc, BlocTeacherGroupsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.06),
                child: Column(
                  children: [
                    SizedBox(height: heightScreen * 0.02),
                    Container(
                      height: heightScreen * 0.3,
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
                                  // Text(
                                  //   DateFormat('MMM', 'ru')
                                  //       .format(DateTime.now()),
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: heightScreen * 0.024,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
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
                                        // curentDateTime.day == index;

                                        // curentDateTime = DateTime.now().add(
                                        //     Duration(
                                        //         days: index -
                                        //             DateTime.now().day +
                                        //             1));
                                        context
                                            .read<ProviderCalendar>()
                                            .getSelectedDate(index);
                                        _getAllLessons(context, provider.day);
                                      });
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

                                          ///День недели выводит
                                          // Text(
                                          //   providerDays[DateTime.now()
                                          //           .add(Duration(days: index))
                                          //           .weekday -
                                          //       1],
                                          //   style: TextStyle(
                                          //       color: providerSelectedIndex ==
                                          //               index
                                          //           ? Colors.black
                                          //           : Colors.white),
                                          // ),

                                          /// Выводит актуальный день
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: widthScreen * 0.05,
                                  right: widthScreen * 0.05,
                                  top: heightScreen * 0.02,
                                  bottom: heightScreen * 0.035),
                              child: SizedBox(
                                height: heightScreen * 0.065,
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.white),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      barrierColor: Colors.transparent,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) =>
                                          const TeacherChangeSchedule(),
                                    );
                                  },
                                  child: const Text(
                                    'Изменить расписание',
                                    style: TextStyle(
                                      color: AppColors.black343434,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) => const BottomSheetModal(),
                            );
                          },
                          icon: const Image(
                            image: AssetImage('assets/images/plus.png'),
                          ),
                        ),
                      ],
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
                    const LessonsInGeneralSchedule(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
