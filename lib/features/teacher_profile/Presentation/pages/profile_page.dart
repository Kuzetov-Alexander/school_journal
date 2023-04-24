import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
>>>>>>> d03ddb63cb769ebbb5ee3e6f63bf01e6a332fd96

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Container();
      })),
    );
  }
}
