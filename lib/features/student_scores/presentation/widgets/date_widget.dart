import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider_scores.dart';

class DateWidget extends StatelessWidget {
  final int index;
  const DateWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    final providerScore = Provider.of<ProviderScores>(context);
    String text =
        DateFormat('E', 'ru').format(providerScore.dataForDateWidget()[index]);
    String textDate = text[0].toUpperCase() + text.substring(1).toLowerCase();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.purple,
      ),
      height: heightScreen * 0.046,
      width: widthScreen * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textDate,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: heightScreen * 0.012,
            ),
          ),
          Text(
            DateFormat('dd.MM')
                .format(providerScore.dataForDateWidget()[index]),
            maxLines: 1,
            style:
                TextStyle(color: Colors.white, fontSize: heightScreen * 0.016),
          ),
        ],
      ),
    );
  }
}
