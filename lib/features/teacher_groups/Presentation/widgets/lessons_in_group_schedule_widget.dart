import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'dart:io' show Platform;

import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_edit_class.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

import '../../provider/provider_calendar.dart';

class LessonsInGroupSchedule extends StatelessWidget {
  const LessonsInGroupSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderGroup>(context);
      String providerDate = context.watch<ProviderCalendar>().day;
  

    final userId = FirebaseAuth.instance.currentUser?.uid;

    var dataBase = FirebaseDatabase.instance
        .ref()
        .child('Users/$userId/Schedule/$providerDate');
   
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return FirebaseAnimatedList(
      query: dataBase,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, DataSnapshot snapshot, Animation<double> animation,
          int index) {
          
            
              

            

        Map<dynamic, dynamic> lessonsInfo = snapshot.value as Map;

        List<dynamic> lessonInfo = lessonsInfo.values.toList();
      
        return Padding(
          padding: EdgeInsets.only(bottom: heightScreen * 0.022),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '${lessonInfo[2]}',
                    style: TextStyle(
                        color: AppColors.black212525,
                        fontSize: heightScreen * 0.018),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  Text('${lessonInfo[4]}',
                      style: TextStyle(
                          color: AppColors.greybcc1cd,
                          fontSize: heightScreen * 0.018))
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.greyLight,
                      ),
                      height: heightScreen * 0.19,
                      width: widthScreen * 0.7,
                      child: Padding(
                        padding: EdgeInsets.only(left: widthScreen * 0.04),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${lessonInfo[0]}',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.02,
                                    color: AppColors.black212525,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      Platform.isAndroid
                                          ? actionSheetAndroid(
                                              heightScreen, context)
                                          : actionSheetIos(
                                              context, heightScreen);
                                    },
                                    icon: const Image(
                                        image: AssetImage(
                                            'assets/images/settings_icon.png')))
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/point_icon.png')),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.025,
                                ),
                                Text(
                                  '${lessonInfo[1]}',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.015,
                                    color: AppColors.black212525,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: heightScreen * 0.01,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    size: widthScreen * 0.030,
                                    color: const Color(0xff88889D),
                                  ),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.025,
                                ),
                                Text(
                                  '${lessonInfo[5]}',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.015,
                                    color: AppColors.black212525,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: heightScreen * 0.01,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/user_icon.png')),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.025,
                                ),
                                Text(
                                  '${lessonInfo[3]}',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.015,
                                    color: AppColors.black212525,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: heightScreen * 0.01,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/home_icon.png')),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.025,
                                ),
                                Text(
                                  '${lessonInfo[6]}',
                                  style: TextStyle(
                                    fontSize: heightScreen * 0.015,
                                    color: AppColors.black212525,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> actionSheetIos(BuildContext context, double heightScreen) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Управление уроком',
            style: TextStyle(
                color: AppColors.black212525,
                fontSize: heightScreen * 0.018,
                fontWeight: FontWeight.w600)),
        message: Text('Среда 26.04, 9:00 -10:30',
            style: TextStyle(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: heightScreen * 0.018,
                fontWeight: FontWeight.w400)),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              const TeacherEditClass();
            },
            child: Text(
              'Изменить',
              style: TextStyle(
                  color: const Color(0xFF56138E),
                  fontSize: heightScreen * 0.022,
                  fontWeight: FontWeight.w400),
            ),
            // onPressed: (_) {
            //   Navigator.of(context).pop();
            //   showModalBottomSheet(
            //     // barrierColor:Colors.transparent ,
            //     isScrollControlled: true,
            //     backgroundColor: Colors.transparent,

            //     context: context,
            //     builder: (context) => const TeacherEditClass(),
            //   );
            // },
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              'Удалить',
              style: TextStyle(
                  color: const Color(0xFFFF3B30),
                  fontSize: heightScreen * 0.022,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Отмена',
            style: TextStyle(
                color: const Color(0xFF56138E),
                fontSize: heightScreen * 0.022,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Future<dynamic> actionSheetAndroid(
      double heightScreen, BuildContext context) {
    return showAdaptiveActionSheet(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Управление уроком',
                style: TextStyle(
                    color: AppColors.black212525,
                    fontSize: heightScreen * 0.018,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Среда 26.04, 9:00 -10:30',
                style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: heightScreen * 0.018,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            'Удалить',
            style: TextStyle(
                color: const Color(0xFFFF3B30),
                fontSize: heightScreen * 0.022,
                fontWeight: FontWeight.w400),
          ),
          onPressed: (_) {},
        ),
        BottomSheetAction(
          title: Text(
            'Изменить',
            style: TextStyle(
                color: const Color(0xFF56138E),
                fontSize: heightScreen * 0.022,
                fontWeight: FontWeight.w400),
          ),
          onPressed: (_) {
            Navigator.of(context).pop();
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
              builder: (context) => const TeacherEditClass(),
            );
          },
        ),
      ],
      cancelAction: CancelAction(
        title: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Отмена',
            style: TextStyle(
                color: const Color(0xFF56138E),
                fontSize: heightScreen * 0.022,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
