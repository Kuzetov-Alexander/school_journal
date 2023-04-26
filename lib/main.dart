import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/features/autentification/data/datasources/remote_data_source.dart';
import 'package:school_journal/features/autentification/data/repositories/user_repository_impl.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/pages/recover_password.dart';
import 'package:school_journal/features/autentification/presentation/pages/signin_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/signup_page.dart';
import 'package:school_journal/features/autentification/presentation/pages/welcome_page.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';
import 'package:school_journal/features/teacher_profile/presentation/pages/group_list_page.dart';
import 'package:school_journal/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => Providerbool(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepositoryImpl>(
      lazy: false,
      create: (context) => UserRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
      child: BlocProvider<AuthBloc>(
        lazy: false,
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<UserRepositoryImpl>(context),
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
