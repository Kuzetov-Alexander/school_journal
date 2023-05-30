import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';

import 'package:school_journal/features/teacher_groups/Presentation/bloc/general_schedule/bloc_general_schedule_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/teacher_group/bloc_teacher_group_event.dart';

import 'package:school_journal/features/teacher_groups/Presentation/bloc/teacher_group/bloc_teacher_groups_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/add_group.dart';
import 'package:school_journal/features/teacher_groups/Presentation/widgets/group_info_widget.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

import '../../provider/provider.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  
  void _deleteGroup(context, {required String key}) {
    BlocProvider.of<BlocTeacherGroupsBloc>(context)
        .add(DeleteGroupEvent(key: key));
  }

   void _getAllLessons(context,String date) {
    BlocProvider.of<BlocGeneralScheduleBloc>(context).add(
                GetAllLessonsEvent(selectedDate: date
                    ));
  }

  @override
  Widget build(BuildContext context) {
  
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final db = FirebaseDatabase.instance.ref().child('Users/$userId/Groups');
    ProviderGroup provider = Provider.of<ProviderGroup>(context);
    ProviderCalendar providerDate = Provider.of<ProviderCalendar>(context);
    return Scaffold(
      body: BlocConsumer<BlocTeacherGroupsBloc, BlocTeacherGroupsState>(
        listener: (context, state) {
          if (state is IsCreatedGroupState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Новая группа успешно создана'),
              ),
            );
          }
          if (state is IsCreatingGroupState) {
            Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(),
            );
          }
          if (state is DatabaseErrorStat) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.er),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NoGroupsState) {
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
                              onPressed: () {
                                //
                                final firebaseAuth = FirebaseAuth.instance;
                                firebaseAuth.currentUser!.displayName;
                              },
                              icon: const Icon(Icons.arrow_left),
                              iconSize: 35,
                            ),
                            InkWell(
                              onTap: () {
                                _getAllLessons(context,providerDate.day);
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
                              'Мои группы',
                              style: TextStyle(
                                  fontSize: heightScreen * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
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
                        snapshot.key;
                       
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthScreen * 0.05),
                              child: Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          _deleteGroup(context,
                                              key:
                                                  'Users/$userId/Groups/${snapshot.key}');
                                          provider.deleteGroupName(snapshot
                                              .children.first.value
                                              .toString());
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        icon: Icons.delete_outlined,
                                        label: 'Удалить',
                                      ),
                                    ]),
                                child: MyGroupInfoWidget(
                                    mapGroups: student, index: index),
                              ),
                            ),
                            SizedBox(height: heightScreen * 0.02)
                          ],
                        );
                      },
                    ),
                  ),
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
