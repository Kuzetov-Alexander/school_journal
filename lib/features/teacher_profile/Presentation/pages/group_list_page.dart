import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(title: const Text('Мои группы', style: TextStyle(fontSize: 41,color: Colors.black
      // ),),),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: heightScreen * 0.15,
            width: widthScreen,
            color: const Color.fromRGBO(243, 243, 243, 1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: 30,
                        image: AssetImage('assets/images/profile_icon.png'), // вставляется с фоном , надо что-то придумать
                      ),
                      
                    ),
                    IconButton(
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
          SizedBox(
            height: heightScreen * 0.01,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: heightScreen * 0.02,
                  );
                },
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(243, 243, 243, 1)),
                        height: heightScreen * 0.15,
                        width: widthScreen * 0.9,
                      ),

                      // color: Colors.red,),
                    ],
                  );
                }),
          ),
        ],
      )),
    );
  }
}
