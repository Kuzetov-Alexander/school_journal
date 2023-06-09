import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/bloc/scores_page_bloc.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class EditScoresWidget extends StatefulWidget {
  const EditScoresWidget({super.key});

  @override
  State<EditScoresWidget> createState() => _EditScoresWidgetState();
}

class _EditScoresWidgetState extends State<EditScoresWidget> {
  String selectedSubject = 'Математика';

  void _editScore(context,
      {required String subject,
      required String studentName,
      // required String groupName,
      required int score,
      required String currentDay}) {
    BlocProvider.of<ScoresPageBloc>(context).add(EditScoreEvent(
        subject: subject,
        studentName: studentName,
        groupName:
            Provider.of<ProviderScores>(context, listen: false).currentGroup,
        score: score,
        currentDay: currentDay));
  }

  @override
  Widget build(BuildContext context) {
    final dayofweek = DateFormat('dd.MM').format(DateTime.now());
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderScores>(context);
    // TODO(Sanya) Чужой провайдер!

    final providerDate = Provider.of<ProviderCalendar>(context);
    return Container(
      height: heightScreen * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 24,
                ),
                Text(
                  // print('не доходит student');
                  '${provider.currentStudent}, $dayofweek',
                  style: TextStyle(
                      color: AppColors.black212525,
                      fontSize: heightScreen * 0.02,
                      fontWeight: FontWeight.w600),
                ),
                const Expanded(child: SizedBox.shrink()),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffEEEEEE),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Image(
                    image: AssetImage('assets/images/close_icon.png'),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            height: heightScreen * 0.001,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: heightScreen * 0.027, horizontal: widthScreen * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.greyLight,
                  ),
                  height: heightScreen * 0.08,
                  width: widthScreen * 0.88,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Был на занятии',
                          style: TextStyle(
                              fontSize: heightScreen * 0.018,
                              fontWeight: FontWeight.w600),
                        ),
                        Platform.isIOS
                            ? CupertinoSwitch(
                                activeColor: AppColors.purple,
                                value: context
                                    .watch<ProviderGroup>()
                                    .newLessonAdded,
                                onChanged: (value) {
                                  context
                                      .read<ProviderGroup>()
                                      .addNewLesson(value);
                                },
                              )
                            : Switch(
                                value: context
                                    .watch<ProviderGroup>()
                                    .newLessonAdded,
                                onChanged: (value) {
                                  context
                                      .read<ProviderGroup>()
                                      .addNewLesson(value);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: heightScreen * 0.025),
                const Text(
                  'Оценки',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: heightScreen * 0.025),
                IconButton(
                  style: IconButton.styleFrom(
                    fixedSize: const Size(56, 56),
                    backgroundColor: const Color(0xffEEEEEE),
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(top: heightScreen * 0.7),
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          scrollController:
                              FixedExtentScrollController(initialItem: 1),
                          itemExtent: 30,
                          onSelectedItemChanged: (value) {
                            setState(
                              () {
                                selectedSubject = [
                                  '2',
                                  '3',
                                  '4',
                                  '5',
                                ][value];
                              },
                            );
                          },
                          children: const [
                            Text('2'),
                            Text('3'),
                            Text('4'),
                            Text('5'),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Image(
                    image: AssetImage('assets/images/plus_icon.png'),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            height: 56,
            width: widthScreen * 0.88,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(AppColors.purple),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              onPressed: () {
                _editScore(context,
                    subject: '${provider.currentsubject}',
                    studentName: provider.currentStudent,
                    // groupName: provider.currentGroup,
                    score: 5,
                    currentDay: DateFormat('dd-MM-yyyy', 'ru')
                        .format(providerDate.currentDate));
                context.pop();
              },
              child: Text(
                'Сохранить',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: heightScreen * 0.022,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: heightScreen * 0.065)
        ],
      ),
    );
  }
}
