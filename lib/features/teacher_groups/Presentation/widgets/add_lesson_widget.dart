import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class BottomSheetModal extends StatelessWidget {
  const BottomSheetModal({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.96,
        builder: (_, controller) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Image(
                                image: AssetImage(
                                    'assets/images/cross_icon.png'))),
                        SizedBox(
                          width: widthScreen / 4,
                        ),
                        Text(
                          'Добавить урок',
                          style: TextStyle(
                              color: AppColors.black212525,
                              fontSize: heightScreen * 0.023,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: heightScreen * 0.001,
                  ),
                  Padding(
                    padding: EdgeInsets.all(heightScreen * 0.03),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.greyLight,
                      ),
                      height: heightScreen * 0.28,
                      width: widthScreen * 0.88,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 19.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${DateFormat('EEEE', 'ru').format(DateTime.now()).capitalize()} , ${DateFormat('d MMM', 'ru').format(DateTime.now())}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: heightScreen * 0.016,
                                        // letterSpacing: 1,
                                        color: AppColors.gray5a5a5a),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: heightScreen * 0.08,
                              width: widthScreen,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.greyLightSecond,
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.03,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Начало',
                                  style: TextStyle(
                                      fontSize: heightScreen * 0.02,
                                      fontWeight: FontWeight.w400,color: AppColors.black212525),
                                    
                                ),
                                  Container(color: AppColors.graygrye)
                              ],
                            ),
                            SizedBox(
                              height: heightScreen * 0.03,
                            ),
                            Row(
                              children: [Text('Конец',style: TextStyle(
                                      fontSize: heightScreen * 0.02,
                                      fontWeight: FontWeight.w400,color: AppColors.black212525),)],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.greyLight,
                    ),
                    height: heightScreen * 0.08,
                    width: widthScreen * 0.88,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Добавить в расписание',
      style: TextStyle(
        fontSize: heightScreen * 0.018,
        fontWeight: FontWeight.w600
      ),
    ),
    Platform.isIOS
      ? CupertinoSwitch(
          activeColor: AppColors.purple,
          value: context.watch<ProviderGroupBool>().newLessonAdded,
          onChanged: (value) {
            context.read<ProviderGroupBool>().addNewLesson(value);
          },
        )
      : Switch(
      
          value: context.watch<ProviderGroupBool>().newLessonAdded,
          onChanged: (value) {
            context.read<ProviderGroupBool>().addNewLesson(value);
          },
        ),
  ],
),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.35,
                  ),
                  SizedBox(
                    height: 56,
                    width: widthScreen * 0.88,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            AppColors.purple),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Добавить',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: heightScreen * 0.022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
