import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';

import 'package:school_journal/features/teacher_groups/Presentation/widgets/lessons_in_group_widget.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class TeacherGroupPage extends StatelessWidget {
  const TeacherGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final provider = context.watch<ProviderGroupBool>().isSelected;
    final dayofweek = DateFormat('EEEE', 'ru').format(DateTime.now());
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
          'Группа 112',
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
                                onPressed: () {},
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
                      height: heightScreen * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.circular(33)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                      onPressed: () {},
                                      icon: const Image(
                                          image: AssetImage(
                                              'assets/images/arrow_left_white.png'))),
                                  Text(
                                    'Апрель',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: heightScreen * 0.024,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                      splashRadius: 1,
                                      onPressed: () {},
                                      icon: const Image(
                                          image: AssetImage(
                                              'assets/images/arrow_right_white.png')))
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 30,
                                itemBuilder: (BuildContext context, index) {
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<ProviderGroupBool>()
                                          .changeColor();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: provider
                                              ? Colors.white
                                              : AppColors.purple,
                                          border: Border.all(
                                            width: 2,
                                            color:
                                                Colors.purple.withOpacity(0.4),
                                          )),
                                      height: heightScreen * 0.02,
                                      width: widthScreen * 0.13,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: widthScreen * 0.015),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            DateFormat('E', 'ru')
                                                .format(DateTime.now()),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: !provider
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            DateFormat('d')
                                                .format(DateTime.now()),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: !provider
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Icon(
                                            Icons.circle_rounded,
                                            color: !provider
                                                ? Colors.white
                                                : AppColors.purple,
                                            size: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16, top: 16, bottom: 32),
                              child: SizedBox(
                                height: 56,
                                width: double.infinity,
                                
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
                          '${dayofweek.capitalize()} , ${DateFormat('d MMM', 'ru').format(DateTime.now())}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: heightScreen * 0.024,
                              // letterSpacing: 1,
                              color: AppColors.black212525),
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
                    const LessonsInGroup(),
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
