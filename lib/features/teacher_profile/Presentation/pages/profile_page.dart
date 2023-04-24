import 'package:flutter/material.dart';

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
