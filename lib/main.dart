import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/pages/registration_page.dart';
import 'package:school_journal/features/teacher_profile/Presentation/pages/group_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      theme: ThemeData(
        
        fontFamily: 'SF-Pro'),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const RegistrationPage(),
            routes: [
              GoRoute(
                path: 'second',
                builder: (context, state) => const GroupListPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
