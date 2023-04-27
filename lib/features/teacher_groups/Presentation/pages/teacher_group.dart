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
        title: Text(
          'Группа 112',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: heightScreen * 0.022,
              color: AppColors.black212525),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    const Text(
                      '27 учеников',
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Все',
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.019,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.015),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Расписание',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: heightScreen * 0.024,
                    color: AppColors.black212525),
              ),
            ),
            SizedBox(height: heightScreen * 0.01),
            Container(
              height: heightScreen * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(33)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            splashRadius: 1,
                            onPressed: () {},
                            icon: const Image(
                                image: AssetImage(
                                    'assets/images/arrow_left_white.png'))),
                        Text(
                          'Апрель',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: heightScreen * 0.024,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            splashRadius: 1,
                            onPressed: () {},
                            icon: const Image(
                                image: AssetImage(
                                    'assets/images/arrow_right_white.png')))
                      ],
                    ),
                    SizedBox(height: heightScreen*0.03,),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 15,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(border: Border.all(width: 2,color: AppColors.purple.withOpacity(0.4),)),
                              height: heightScreen * 0.02,
                             
                              width: widthScreen * 0.1,
                            
                              margin: EdgeInsets.symmetric(
                                  horizontal: widthScreen * 0.03),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16.0,right: 16, top: 16,bottom: 32),
                      child: SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.white),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Изменить расписание',
                            style: TextStyle(
                              color: AppColors.black343434,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
