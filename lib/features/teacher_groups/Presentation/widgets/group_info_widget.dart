import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';

class GroupInfoWidget extends StatelessWidget {
  const GroupInfoWidget({
    super.key,
    required this.heightScreen,
    required this.widthScreen,
  });

  final double heightScreen;
  final double widthScreen;

  @override
  Widget build(BuildContext context) {
    // List<GroupsInformation> allgroups = [];
    // List<String> textOptions = ['Ученика', 'Ученик', 'Учеников'];
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
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: heightScreen * 0.02),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('Ближайшее занятие: '),
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
                    children: const [
                      Image(image: AssetImage('assets/images/mini_person.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Text(' учеников'),
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
