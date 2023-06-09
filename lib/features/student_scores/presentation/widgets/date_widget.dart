import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_journal/common/color.dart';

class DateWidget extends StatelessWidget {
  final int index;
  const DateWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    String text = DateFormat('E', 'ru').format(DateTime.now());
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
            DateFormat('d').format(DateTime.now().add(Duration(days: index))),
            maxLines: 1,
            style:
                TextStyle(color: Colors.white, fontSize: heightScreen * 0.018),
          ),
        ],
      ),
    );
  }
}
