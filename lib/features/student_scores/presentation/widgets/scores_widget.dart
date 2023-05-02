import 'package:flutter/material.dart';
import 'package:school_journal/features/student_scores/presentation/widgets/edit_scores_widget.dart';

class ScoresWidget extends StatelessWidget {
  const ScoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      height: heightScreen * 0.046,
      width: widthScreen * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xffEEEEEE),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onLongPress: () {
          showModalBottomSheet(
            // barrierColor:Colors.transparent ,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) => const EditScoresWidget(),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '4',
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
