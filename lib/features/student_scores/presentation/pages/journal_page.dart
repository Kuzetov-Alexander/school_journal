import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/bloc/scores_page_bloc.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  /// Выгрузка всего расписания
  void _getInfoSchedule(context) {
    BlocProvider.of<ScoresPageBloc>(context).add(
      GetInfoScheduleEvent(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getInfoSchedule(context);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderGroup>(context);
    final providerScores = Provider.of<ProviderScores>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${providerScores.currentGroup}/allSubject');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Image(
            image: AssetImage('assets/images/arrow_left.png'),
          ),
        ),
        title: Text(
          'Группа  ${providerScores.currentGroup}',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: heightScreen * 0.022,
              color: AppColors.black212525),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.06),
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
                      BlocBuilder<ScoresPageBloc, ScoresPageState>(
                          builder: (context, state) {
                        if (state is GetSnapshotState) {
                          providerScores.updateStudentsNameList();
                          provider.updateGroupNameList(state.data);
                        }
                        return Text(
                          '${providerScores.studentsNameList.length} учеников',
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed('EditStudents');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Редактировать',
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.019,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightScreen * 0.015),
              Row(
                children: [
                  Text(
                    'Предметы',
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
                        'Выбор предмета',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //           providerScores.updateLessonsMap(
                          // lessonData: state.data,
                          // subject: Provider.of<ProviderScores>(context, listen: false)
                          //     .currentSubject);
                          context.goNamed('StudentScores');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Все',
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.019,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightScreen * 0.01),
              Expanded(
                child: SizedBox(
                  height: heightScreen * 0.02,
                  child: FirebaseAnimatedList(
                    query: db,
                    itemBuilder: (context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      final String? dataSubjects = snapshot.key;

                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              providerScores.currentSubject = dataSubjects;
                              context.goNamed('StudentScores');
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(widthScreen * 0.8, heightScreen * 0.08),
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              '$dataSubjects',
                              style: TextStyle(
                                  color: AppColors.black212525,
                                  fontSize: heightScreen * 0.019,
                                  fontWeight: FontWeight.w600),
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
        ),
      ),
    );
  }
}
