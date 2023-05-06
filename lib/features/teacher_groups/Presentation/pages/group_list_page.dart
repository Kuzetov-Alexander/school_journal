import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/bloc/bloc_teacher_groups_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/add_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/group_info_widget.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {

//  void _createGroup(context) {
//   BlocProvider.of<BlocTeacherGroupsBloc>(context).add(CreateGroup(groupName: ))
//  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<BlocTeacherGroupsBloc, BlocTeacherGroupsState>(
        listener: (context, state) {
          if (state is IsCreatedGroup) {
            print('Новая группа создана');
          }
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NoGroups) {
            const Center(child: Text('Нет групп'));
          }
          return SafeArea(
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
                                final setValue =
                                    FirebaseDatabase.instance.ref().child('User');
                                final setSnapshot = setValue.set({
                                  'name': 'sasha',
                                  'age': 15,
                                  'addres': {'line': '100 mountain View'}
                                }); // перезаписывает данные

                                // final updateAge = await FirebaseDatabase.instance
                                //     .ref()
                                //     .child('User')
                                //     .update({'ads': 'value'});

                                // final deleteAddres =
                                //     await FirebaseDatabase.instance.ref().set(null);

                                final ref = FirebaseDatabase.instance.ref();
                                final getSnapshot =
                                    await ref.child('User').get();
                                if (getSnapshot.exists) {
                                  print(getSnapshot.value);
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
                                image: AssetImage(
                                    'assets/images/profile_icon.png'),
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
                                image:
                                    AssetImage('assets/images/plus_icon.png'),
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
          );
        },
      ),
    );
  }
}
