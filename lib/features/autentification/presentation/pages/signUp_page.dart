import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';
import 'package:school_journal/features/autentification/presentation/widgets/double_button.dart';

class SignUpPageBloc extends StatelessWidget {
  const SignUpPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, BlocAuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/Groups');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SignUpWidget();
        },
      ),
    );
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  // bool _isHiddenPassword = true;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  // String _password = '';

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentfocus,
    FocusNode nextFocus,
  ) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(emailController.text, passwordController.text),
      );
    }
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
                    'Регистрация',
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
                    context.watch<Providerbool>().teacher
                        ? TextFormField(
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _fullNameFocus, _emailFocus);
                            },
                            focusNode: _fullNameFocus,
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: fullNameController,
                            decoration: DecorationClass()
                                .decoration('Введите полное имя', 'ФИО'),
                          )
                        : TextFormField(
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _fullNameFocus, _emailFocus);
                            },
                            focusNode: _fullNameFocus,
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: fullNameController,
                            decoration: DecorationClass().decoration(
                                'Ccылка на группу', 'Введите ссылку'),
                          ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(context, _emailFocus, _passwordFocus);
                      },
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: emailController,
                      decoration: DecorationClass()
                          .decoration('Введите почту', 'Почта'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(
                            context, _passwordFocus, _confirmPasswordFocus);
                      },
                      focusNode: _passwordFocus,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: passwordController,
                      decoration: DecorationClass()
                          .decoration('Введите пароль', 'Пароль'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      focusNode: _confirmPasswordFocus,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: confirmPasswordController,
                      decoration: DecorationClass().decoration(
                          'Повторите пароль', 'Подтверждение пароля'),
                    ),
                    const SizedBox(height: 16),
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
                        onPressed: () {
                          _authenticateWithEmailAndPassword(context);
                        },
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go('/SignIn');
                },
                child: const Text('Войти'),
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
