import 'package:flutter/material.dart';


class GroupInfoWidget extends StatelessWidget {
  const GroupInfoWidget({
    super.key,
    required this.heightScreen,
    required this.widthScreen,
  });

  final double heightScreen;
  final double widthScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(243, 243, 243, 1)),
          height: heightScreen * 0.15,
          width: widthScreen * 0.9,
          child: Column(children: [
            Row(children: [
              Text('Группа 112',style: TextStyle(fontWeight: FontWeight.w600,fontSize: heightScreen*0.02),),
            ],)
          ]),
        ),

        
      ],
    );
  }
}