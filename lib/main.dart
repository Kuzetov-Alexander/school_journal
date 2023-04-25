import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/pages/recover_password.dart';
import 'package:school_journal/features/autentification/presentation/pages/signIn_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/signUp_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/welcome_page.dart';
import 'package:school_journal/features/teacher_profile/Presentation/pages/group_list_page.dart';
import 'package:school_journal/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp.router(
          theme: ThemeData(fontFamily: 'SF-Pro'),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const WelcomePage(),
                routes: [
                  GoRoute(
                    path: 'SignUp',
                    builder: (context, state) => const SignUpPage(),
                  ),
                  GoRoute(
                    path: 'SignIn',
                    builder: (context, state) => const SignInPage(),
                  ),
                  GoRoute(
                    path: 'RecoverPassword',
                    builder: (context, state) => const RecoverPasswordPage(),
                  ),
                  GoRoute(
                    path: 'Groups',
                    builder: (context, state) => const GroupListPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
