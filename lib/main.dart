import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/core/scroll/my_scroll.dart';
import 'package:school_journal/features/autentification/data/datasources/remote_data_source.dart';
import 'package:school_journal/features/autentification/data/repositories/user_repository_impl.dart';
import 'package:school_journal/features/autentification/domain/repositories/user_repository.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/pages/email_verification_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/recover_password.dart';
import 'package:school_journal/features/autentification/presentation/pages/signin_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/signup_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/welcome_page.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';
import 'package:school_journal/features/student_scores/presentation/bloc/scores_page_bloc.dart';
import 'package:school_journal/features/student_scores/presentation/pages/student_scores.dart';
import 'package:school_journal/features/student_scores/presentation/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/bloc/bloc_teacher_groups_bloc.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/group_list_page.dart';
import 'package:school_journal/features/teacher_groups/Presentation/pages/schedule_page.dart';

import 'package:school_journal/features/teacher_groups/Presentation/pages/teacher_group.dart';
import 'package:school_journal/features/teacher_groups/data/data_sources/remote_data_firebase.dart';
import 'package:school_journal/features/teacher_groups/data/repositories/create_group_repository_impl.dart';
import 'package:school_journal/features/teacher_groups/Presentation/domain/repositories/create_group_repository.dart';
import 'package:school_journal/features/teacher_groups/provider/provider.dart';
import 'package:school_journal/features/teacher_groups/provider/provider_calendar.dart';
import 'package:school_journal/features/teacher_profile/Presentation/pages/profile_page.dart';
import 'dart:io' show Platform;

import 'package:school_journal/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderLoginBool>(
          create: (context) => ProviderLoginBool(),
        ),
        ChangeNotifierProvider<ProviderGroup>(
          lazy: false,
          create: (context) => ProviderGroup(),
        ),
        ChangeNotifierProvider<ProviderCalendar>(
          create: (context) => ProviderCalendar(),
        ),
        ChangeNotifierProvider<ProviderScorePage>(
          create: (context) => ProviderScorePage(),
        ),
      ],
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
            path: 'Shedule',
            name: 'Shedule',
            builder: (context, state) => const SchedulePage(),
          ),
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
            builder: (context, state) => LandingPage(),
          ),
        ],
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          lazy: false,
          create: (context) => UserRepositoryImpl(
            remoteDataSource: RemoteDataSourceImpl(),
          ),
        ),
        RepositoryProvider<CreateGroupRepository>(
          lazy: false,
          create: (context) =>
              CreateGroupRepositoryImpl(dataBase: RemoteDataFirebaseImpl()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            lazy: false,
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider<BlocTeacherGroupsBloc>(
            lazy: false,
            create: (context) => BlocTeacherGroupsBloc(
                // repository: RepositoryProvider.of<CreateGroupRepository>(context),
                ),
          ),
          BlocProvider<ScoresPageBloc>(
            lazy: false,
            create: (context) => ScoresPageBloc(
               
                ),
          ),
        ],
        child: MaterialApp.router(
            // themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            scrollBehavior: Platform.isAndroid
                ? MyBehaviorAndroid()
                : const MyBehaviorIOS(),
            theme: ThemeData(
                useMaterial3: true,
                fontFamily: 'SF-Pro',
                appBarTheme: const AppBarTheme(color: AppColors.greyLight)),
            routerConfig: _router),
      ),
    );
  }
}
