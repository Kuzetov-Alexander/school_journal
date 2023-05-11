import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';

class MyGroupInfoWidget extends StatelessWidget {
  final Map mapGroups;

  final int index;

  const MyGroupInfoWidget(
      {super.key, required this.mapGroups, required this.index});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.greyLight,
          child: InkWell(
            onTap: () {
              context.goNamed('TeacherGroup');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.transparent,
              ),
              height: heightScreen * 0.15,
              width: widthScreen * 0.9,
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 1),
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
                      Text('${mapGroups['amountStudents']} учеников'),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
