import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';

class TeacherGroupPage extends StatelessWidget {
  const TeacherGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => context.go('/Groups'),
          child: const Image(
          
            image: AssetImage(
                'assets/images/arrow_left.png'), // вставляется с фоном , надо что-то придумать
          ),
        ),
        title: Text('Группа 112',style: TextStyle(fontWeight: FontWeight.w600,fontSize: heightScreen*0.022,color: Colors.black),),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [Text('Ученики',style: TextStyle(fontWeight: FontWeight.w700,fontSize: heightScreen*0.024,color: AppColors.blackAlmost),), ],
            ),
            Container(
              height: heightScreen * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  Text('27 учеников'),
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      child: Text('Все'))
                ],
              ),
            )
          ],
        ),
      ))),
    );
  }
}
