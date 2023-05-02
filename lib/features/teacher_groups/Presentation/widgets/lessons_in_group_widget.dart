import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';
import 'dart:io' show Platform;

class LessonsInGroup extends StatelessWidget {
  const LessonsInGroup({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    '9:00',
                    style: TextStyle(
                        color: AppColors.black212525,
                        fontSize: heightScreen * 0.02),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  Text('10:30',
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
                      height: heightScreen * 0.15,
                      width: widthScreen * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Математика',
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
                                          ? ActionSheetAndroid(
                                              heightScreen, context)
                                          : ActionSheetIos(
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
                                  'Комната 2-136',
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
                                  'Отметить присутсвующих',
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
                                  'Задать домашнее задание',
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
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: heightScreen * 0.01,
        );
      },
    );
  }

  Future<dynamic> ActionSheetIos(BuildContext context, double heightScreen) {
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
                  onPressed: () {},
                  child: Text(
                    'Изменить',
                    style: TextStyle(
                        color: const Color(0xFF56138E),
                        fontSize: heightScreen * 0.022,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {},
                  child: Text('Удалить',
                      style: TextStyle(
                          color: const Color(0xFFFF3B30),
                          fontSize: heightScreen * 0.022,
                          fontWeight: FontWeight.w400)),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Отмена',
                      style: TextStyle(
                          color: const Color(0xFF56138E),
                          fontSize: heightScreen * 0.022,
                          fontWeight: FontWeight.w600))),
            ));
  }

  Future<dynamic> ActionSheetAndroid(
      double heightScreen, BuildContext context) {
    return showAdaptiveActionSheet(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Управление уроком',
                    style: TextStyle(
                        color: AppColors.black212525,
                        fontSize: heightScreen * 0.018,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Среда 26.04, 9:00 -10:30',
                    style: TextStyle(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: heightScreen * 0.018,
                        fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
        context: context,
        actions: <BottomSheetAction>[
          BottomSheetAction(
            title: Text('Удалить',
                style: TextStyle(
                    color: const Color(0xFFFF3B30),
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w400)),
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
            onPressed: (_) {},
          ),
        ],
        cancelAction: CancelAction(
          title: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена',
                style: TextStyle(
                    color: const Color(0xFF56138E),
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w600)),
          ),
        ));
  }
}
