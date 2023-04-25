import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';
import '../widgets/widgets.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: heightScreen * 0.15,
            width: widthScreen,
            color: AppColors.greyLight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/');
                      },
                      icon: const Icon(Icons.arrow_left),
                      iconSize: 35,
                    ),
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {},
                      icon: const Image(
                        width: 30,
                        image: AssetImage(
                            'assets/images/profile_icon.png'), // вставляется с фоном , надо что-то придумать
                      ),
                    ),
                    IconButton(
                      splashRadius: 1,
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      iconSize: 40,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, bottom: 11, top: 18),
                      child: Text(
                        'Мои группы',
                        style: TextStyle(
                            fontSize: heightScreen * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            height: heightScreen * 0.001,
          ),
          SizedBox(
            height: heightScreen * 0.04,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: heightScreen * 0.02,
                  );
                },
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return GroupInfoWidget(
                      heightScreen: heightScreen, widthScreen: widthScreen);
                }),
          ),
        ],
      )),
    );
  }
}
