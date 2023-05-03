import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';

class EditScoresWidget extends StatefulWidget {
  const EditScoresWidget({super.key, required this.list});
  final List<String> list;

  @override
  State<EditScoresWidget> createState() => _EditScoresWidgetState();
}

class _EditScoresWidgetState extends State<EditScoresWidget> {
  @override
  Widget build(BuildContext context) {
    final dayofweek = DateFormat('dd.MM').format(DateTime.now());
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Text(
                    'Kuzetov Alexander, $dayofweek',
                    style: TextStyle(
                        color: AppColors.black212525,
                        fontSize: heightScreen * 0.02,
                        fontWeight: FontWeight.w600),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xffEEEEEE),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Image(
                      image: AssetImage('assets/images/close_icon.png'),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: heightScreen * 0.027,
                  horizontal: widthScreen * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.greyLight,
                    ),
                    height: heightScreen * 0.08,
                    width: widthScreen * 0.88,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Был на занятии',
                            style: TextStyle(
                                fontSize: heightScreen * 0.018,
                                fontWeight: FontWeight.w600),
                          ),
                          Platform.isIOS
                              ? CupertinoSwitch(
                                  activeColor: AppColors.purple,
                                  value: context
                                      .watch<ProviderGroupBool>()
                                      .newLessonAdded,
                                  onChanged: (value) {
                                    context
                                        .read<ProviderGroupBool>()
                                        .addNewLesson(value);
                                  },
                                )
                              : Switch(
                                  value: context
                                      .watch<ProviderGroupBool>()
                                      .newLessonAdded,
                                  onChanged: (value) {
                                    context
                                        .read<ProviderGroupBool>()
                                        .addNewLesson(value);
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.025),
                  const Text(
                    'Оценки',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: heightScreen * 0.025),
                  IconButton(
                    style: IconButton.styleFrom(
                      fixedSize: const Size(56, 56),
                      backgroundColor: const Color(0xffEEEEEE),
                    ),
                    onPressed: () {
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
                        builder: (context) => const AddScoresNumberWidget(),
                      );
                    },
                    icon: const Image(
                      image: AssetImage('assets/images/plus_icon.png'),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            SizedBox(
              height: 56,
              width: widthScreen * 0.88,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(AppColors.purple),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.065)
          ],
        ),
      ),
    );
  }
}

class AddScoresNumberWidget extends StatefulWidget {
  const AddScoresNumberWidget({super.key});

  @override
  State<AddScoresNumberWidget> createState() => _AddScoresNumberWidgetState();
}

class _AddScoresNumberWidgetState extends State<AddScoresNumberWidget> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 16),
              child: Text(
                'Выберите оценку',
                style: TextStyle(
                    color: AppColors.black212525,
                    fontSize: heightScreen * 0.02,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            SizedBox(
              height: 61,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '2',
                  style: TextStyle(
                      color: Color(0xff56138E),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            SizedBox(
              height: 61,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '3',
                  style: TextStyle(
                      color: Color(0xff56138E),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            SizedBox(
              height: 61,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '4',
                  style: TextStyle(
                      color: Color(0xff56138E),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              height: heightScreen * 0.001,
            ),
            SizedBox(
              height: 61,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '5',
                  style: TextStyle(
                      color: Color(0xff56138E),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              width: widthScreen * 0.88,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(AppColors.purple),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Отмена',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.065)
          ],
        ),
      ),
    );
  }
}
