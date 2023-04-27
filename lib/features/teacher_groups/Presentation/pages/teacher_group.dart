import 'package:flutter/material.dart';

class TeacherGroupPage extends StatelessWidget {
  const TeacherGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: const [Text('Ученики')],
            ),
            Container(
              height: heightScreen * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  const Text('27 учеников'),
                  ElevatedButton(onPressed: () {}, child: const Text(''))
                ],
              ),
            )
          ],
        ),
      ))),
    );
  }
}
