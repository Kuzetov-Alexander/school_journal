import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';
import 'package:school_journal/features/student_scores/presentation/bloc/scores_page_bloc.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/add_student_widget.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/student_profile.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class EditStudentsPage extends StatefulWidget {
  const EditStudentsPage({super.key});

  @override
  State<EditStudentsPage> createState() => _EditStudentsPageState();
}

class _EditStudentsPageState extends State<EditStudentsPage> {
  void _deleteStudent({
    required String studentName,
    required String groupName,
  }) {
    BlocProvider.of<ScoresPageBloc>(context).add(
      DeleteStudentEvent(
        studentName: studentName,
        groupName: groupName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderGroup>(context);

    final userId = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Groups/${provider.currentGroup}/allStudents');

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.goNamed('Journal'),
          child: const Image(
            image: AssetImage('assets/images/arrow_left.png'),
          ),
        ),
        title: Text(
          'Группа  ${provider.currentGroup}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: heightScreen * 0.022,
              color: AppColors.black212525),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widthScreen * 0.06, vertical: heightScreen * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
              SizedBox(height: heightScreen * 0.01),
              Expanded(
                child: FirebaseAnimatedList(
                  query: db,
                  itemBuilder: (context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map mapDataStudent = snapshot.value as Map;
                    return Column(
                      children: [
                        Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      _deleteStudent(
                                          studentName:
                                              '${mapDataStudent['FullName'][index]}',
                                          groupName: provider.currentGroup);
                                    });
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  icon: Icons.delete_outlined,
                                  label: 'Удалить',
                                ),
                              ]),
                          child: ElevatedButton(
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
                                builder: (context) => StudentProfile(
                                  student: EntityStudentScores(
                                      fullName: '${mapDataStudent['FullName']}',
                                      email: '${mapDataStudent['email']}',
                                      groupName: provider.currentGroup),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(widthScreen, heightScreen * 0.06),
                              backgroundColor: AppColors.greyLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              '${mapDataStudent['FullName']}',
                              style: TextStyle(
                                  color: AppColors.black212525,
                                  fontSize: heightScreen * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: heightScreen * 0.01)
                      ],
                    );
                  },
                ),
              ),
              FloatingActionButton(
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
                    builder: (context) => const AddStudentWidget(),
                  );
                },
                backgroundColor: AppColors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
