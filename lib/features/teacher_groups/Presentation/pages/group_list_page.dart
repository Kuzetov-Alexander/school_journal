import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/add_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/group_info_widget.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});


  @override
  State<GroupListPage> createState() => _GroupListPageState();
}


class _GroupListPageState extends State<GroupListPage> {
  late DatabaseReference ref ;
  @override
  void initState() {
   
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('Students');
  }
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    // final user = FirebaseAuth.instance.currentUser;
   


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: heightScreen * 0.15,
              width: widthScreen,
              color: AppColors.greyLight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: ()  {
                            // context.go('/');
                      Map <String, String> students = {
                        'name':'sdsdsd'
                      };

                          ref.push().set(students);
                          },
                          icon: const Icon(Icons.arrow_left),
                          iconSize: 35,
                        ),
                        InkWell(
                          onTap: () {
                            context.goNamed('Shedule');
                          },
                          child: const Icon(Icons.calendar_month_outlined),
                        ),
                        SizedBox(
                          width: widthScreen * 0.07,
                        ),
                        InkWell(
                          onTap: () {
                            context.goNamed('Profile');
                          },
                          child: const Image(
                            image: AssetImage('assets/images/profile_icon.png'),
                          ),
                        ),
                        SizedBox(
                          width: widthScreen * 0.07,
                        ),
                        InkWell(
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
                                builder: (context) => const AddNewGroup());
                          },
                          child: const Image(
                            image: AssetImage('assets/images/plus_icon.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, bottom: 2, top: 12),
                        child: Text(
                          // '${user?.email} ${user?.displayName}'
                          'Мои группы',
                          style: TextStyle(
                              fontSize: heightScreen * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            SizedBox(
              height: heightScreen * 0.04,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: heightScreen * 0.02,
                  );
                },
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return GroupInfoWidget(
                      heightScreen: heightScreen, widthScreen: widthScreen);
                },
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/Groups/StudentScores');
              },
              child: const Text('Next Page Student Scores'),
            )
          ],
        ),
      ),
    );
  }
}
