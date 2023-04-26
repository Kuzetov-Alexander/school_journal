import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    void _authenticateWithEmailAndPassword(context) {
      BlocProvider.of<AuthBloc>(context).add(
        SignOutRequested(),
      );
    }

    return Scaffold(
      body: SafeArea(child:
          ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Container(
          child: TextButton(
            child: const Text('выйти'),
            onPressed: () {
              _authenticateWithEmailAndPassword(context);
            },
          ),
        );
      })),
    );
  }
}
