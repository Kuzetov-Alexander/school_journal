import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<AuthBloc, BlocAuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/Groups');
          }
          if (state is UnEmailVerification) {
            context.go('/EmailVerification');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: heightScreen * 0.10),
                    const SizedBox(
                      child: Image(
                        image: AssetImage('assets/images/notebook.png'),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.02,
                    ),
                    SizedBox(
                      height: heightScreen * 0.15,
                      child: Text(
                        'Письмо подтверждения email отправлено на вашу электронную почту.',
                        style: TextStyle(fontSize: heightScreen * 0.02),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.015,
                    ),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                            Color(0xff56138E),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.currentUser!.delete();
                          void back() {
                            context.go('/SignUp');
                          }

                          back();
                        },
                        child: const Text(
                          'Назад',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.015,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
