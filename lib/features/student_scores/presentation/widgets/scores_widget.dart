import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/edit_scores_widget.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';

class ScoresWidget extends StatelessWidget {
  const ScoresWidget(
      {super.key, required this.listStudentTable, required this.index});
  final List<dynamic> listStudentTable;
  final int index;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderScores>(context);
    final providerDate = Provider.of<ProviderCalendar>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    //  subject: '${provider.currentsubject}',
    //                 studentName: widget.studentName,
    //                 groupName: widget.group,
    //                 score: 5,
    //                 currentDay:

    final db = FirebaseDatabase.instance.ref().child(
        'Users/$userId/Groups/${provider.currentGroup}/allSubject/${provider.currentsubject}/Students/${listStudentTable[index]}/${DateFormat('dd-MM-yyyy', 'ru').format(providerDate.currentDate)}/score');
    return Container(
      height: heightScreen * 0.046,
      width: widthScreen * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xffEEEEEE),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        // onTap: () {
        //   print(listStudentTable);
        // },
        onLongPress: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => EditScoresWidget(
              group: provider.currentGroup,
              studentName: listStudentTable[index],
            ),
          );
        },
        child: SizedBox(
          child: FirebaseAnimatedList(
            query: db,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              print(snapshot.value);
              return Text(
                '${snapshot.value}',
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
