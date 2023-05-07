import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
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
    List<List<Object?>> listAllGroups = [];
    final db = FirebaseDatabase.instance.ref().child('Groups');

    return Scaffold(
      body: BlocConsumer<BlocTeacherGroupsBloc, BlocTeacherGroupsState>(
        listener: (context, state) {
          if (state is IsCreatedGroup) {
            print('---------------${state.allCreatedGroup}');
            listAllGroups = state.allCreatedGroup;
            print('---------------$listAllGroups');

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Новая группа успешно создана'),
              ),
            );
          }
          if (state is IsCreatingGroup) {
            Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            );
          }
          if (state is DatabaseError) {
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
                                context.go('/');
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
                SizedBox(height: heightScreen * 0.04),
                Expanded(
                  child: SizedBox(
                    height: heightScreen * 0.02,
                    child: FirebaseAnimatedList(
                      query: db,
                      itemBuilder: (context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map<dynamic, dynamic> student = snapshot.value as Map;
                        student['key'] = snapshot.key;

                        return Column(
                          children: [
                            MyGroupInfoWidget(mapGroups: student, index: index),
                            SizedBox(height: heightScreen * 0.04)
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     separatorBuilder: (context, index) {
                //       return SizedBox(
                //         height: heightScreen * 0.02,
                //       );
                //     },
                //     itemCount: listAllGroups.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return GroupInfoWidget(
                //         listGroups: listAllGroups,
                //         index: index,
                //       );
                //     },
                //   ),
                // ),
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
