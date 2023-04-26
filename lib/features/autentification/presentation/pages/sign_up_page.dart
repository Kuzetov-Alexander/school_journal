import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';
import 'package:school_journal/features/autentification/presentation/widgets/double_button.dart';
import 'package:school_journal/features/autentification/presentation/widgets/init_bloc_direction.dart';
import 'package:school_journal/features/autentification/presentation/widgets/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initBlocDirection(unAuthenticationWidget: const SignUpPage());
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
        SignUpRequested(_emailController.text, _passwordController.text),
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
                            controller: _fullNameController,
                            decoration: DecorationClass()
                                .decoration('Введите полное имя', 'ФИО'),
                            validator: ((_) => Validator().validateName(
                                  _fullNameController.text.trim(),
                                )),
                          )
                        : TextFormField(
                            onFieldSubmitted: (_) {
                              _fieldFocusChange(
                                  context, _fullNameFocus, _emailFocus);
                            },
                            focusNode: _fullNameFocus,
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: _fullNameController,
                            decoration: DecorationClass().decoration(
                                'Ccылка на группу', 'Введите ссылку'),
                            validator: (value) => Validator()
                                .validateName(_fullNameController.text),
                          ),
                    const SizedBox(height: 16),
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
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(
                            context, _passwordFocus, _confirmPasswordFocus);
                      },
                      focusNode: _passwordFocus,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: _passwordController,
                      decoration: DecorationClass()
                          .decoration('Введите пароль', 'Пароль'),
                      validator: (value) => Validator().validatePassword(
                          password: _passwordController,
                          confirmPassword: _confirmPasswordController),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      focusNode: _confirmPasswordFocus,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      controller: _confirmPasswordController,
                      decoration: DecorationClass().decoration(
                          'Повторите пароль', 'Подтверждение пароля'),
                      validator: (value) => Validator().validatePassword(
                        password: _confirmPasswordController,
                        confirmPassword: _passwordController,
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
