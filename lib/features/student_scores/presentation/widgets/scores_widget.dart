import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/edit_scores_widget.dart';

class ScoresWidget extends StatelessWidget {
  const ScoresWidget(
      {super.key, required this.listStudentTable, required this.index});
  final List<dynamic> listStudentTable;
  final int index;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final providerScores = Provider.of<ProviderScores>(context);
    // final providerDate = Provider.of<ProviderCalendar>(context);
    // final userId = FirebaseAuth.instance.currentUser?.uid;

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
              group: providerScores.currentGroup,
              studentName: listStudentTable[index],
            ),
          );
        },
        child: providerScores.getWidgetScore(
            currentStudent: listStudentTable[index]),
      ),
    );
  }
}
