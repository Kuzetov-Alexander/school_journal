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
  // final DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();

    // ref = FirebaseDatabase.instance.ref('students');

    // ref = FirebaseDatabase.instance.refFromURL('');
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

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
                          onPressed: () async {
                            // context.go('/');
                            // final ref = FirebaseDatabase.instance;
                            // ref.ref().
                            // ;
                            // database("https://<databaseName><region>.firebasedatabase.app");

                            // Map<String, String> students = {
                            //   'name': 'asdsasdsdsd'
                            // };
                            // FirebaseDatabase.instance
                            //     .ref()
                            //     .child('TEAM')
                            //     .set({'name': 'asdsasdsdsd'});
                            // final ref = FirebaseDatabase.instance.refFromURL(
                            //     'https://schooldiary-55bc7-default-rtdb.europe-west1.firebasedatabase.app/');

                            // ref.child('TEAM').set({'name': 'asdsasdsdsd'});
                            // print(ref);

                            final ref = FirebaseDatabase.instance.ref();
                            final snapshot = await ref.child('name').get();
                            if (snapshot.exists) {
                              print(snapshot.value);
                            } else {
                              print('No data');
                            }
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
