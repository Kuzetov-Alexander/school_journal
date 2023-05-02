import 'package:flutter/material.dart';

class AttestationWidget extends StatelessWidget {
  const AttestationWidget({super.key, required this.grade});
  final String grade;

  @override
  Widget build(BuildContext context) {
    // double widthScreen = MediaQuery.of(context).size.width;
    // double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: const Color(0xffEEEEEE),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onLongPress: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              grade,
              maxLines: 1,
              style: const TextStyle(
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
