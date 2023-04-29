import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/autentification/data/datasources/remote_data_source.dart';
import 'package:school_journal/features/autentification/data/repositories/user_repository_impl.dart';
import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/pages/email_verification_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/recover_password.dart';
import 'package:school_journal/features/autentification/presentation/pages/signup_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/signin_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/welcome_page.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';
import 'package:school_journal/features/student_scores/presentation/pages/student_scores.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/group_list_page.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_profile/Presentation/pages/profile_page.dart';

import 'package:school_journal/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => Providerbool(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
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
            path: 'EmailVerification',
            builder: (context, state) => const EmailVerificationPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/Groups',
        builder: (context, state) => const GroupListPage(),
        routes: [
          GoRoute(
            path: 'TeacherGroup',
            name: 'TeacherGroup',
            builder: (context, state) => const TeacherGroupPage(),
          ),
          GoRoute(
            path: 'Profile',
            name: 'Profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'StudentScores',
            name: 'StudentScores',
            builder: (context, state) => const StudentScores(),
          ),
        ],
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      lazy: false,
      create: (context) => UserRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
      child: BlocProvider<AuthBloc>(
        lazy: false,
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: MaterialApp.router(
            theme: ThemeData(
                fontFamily: 'SF-Pro',
                appBarTheme: const AppBarTheme(color: AppColors.greyLight)),
            routerConfig: _router),
      ),
    );
  }
}
