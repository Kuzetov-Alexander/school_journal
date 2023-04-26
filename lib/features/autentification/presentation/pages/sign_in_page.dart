import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';

import 'package:school_journal/features/autentification/presentation/widgets/double_button.dart';
import 'package:school_journal/features/autentification/presentation/widgets/validator.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, BlocAuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/Groups');
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
          return const SignInWidget();
        },
      ),
    );
  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      print('балбесы');
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentfocus,
    FocusNode nextFocus,
  ) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Вход',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: heightScreen * 0.024,
                        letterSpacing: 1.4),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SizedBox(
                child: Image(
                  image: AssetImage('assets/images/book.png'),
                ),
              ),
              const DoubleButton(),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(context, _emailFocus, _passwordFocus);
                      },
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: _emailController,
                      decoration: DecorationClass()
                          .decoration('Введите почту', 'Почта'),
                      validator: (value) =>
                          Validator().validateEmail(_emailController.text),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      focusNode: _passwordFocus,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: _passwordController,
                      decoration: DecorationClass()
                          .decoration('Введите пароль', 'Пароль'),
                      validator: (value) => Validator()
                          .validatePassword(_passwordController.text),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.green),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          _authenticateWithEmailAndPassword(context);
                          // try {
                          //   await FirebaseAuth.instance
                          //       .signInWithEmailAndPassword(
                          //           email: _emailController.text,
                          //           password: _passwordController.text);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'user-not-found') {
                          //     throw Exception('No user found for that email.');
                          //   } else if (e.code == 'wrong-password') {
                          //     throw Exception(
                          //         'Wrong password provided for that user.');
                          //   }
                          // }
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go('/RecoverPassword');
                          },
                          child: const Text(
                            'Восстановить пароль',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/SignUp');
                },
                child: const Text('Регистрация'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/Groups');
                },
                child: const Text('Следующая страница'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
