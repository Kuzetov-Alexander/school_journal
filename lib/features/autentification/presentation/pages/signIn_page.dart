import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/widgets/double_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isHiddenPassword = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
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

  void _authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      // If email is valid adding new event [SignUpRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(emailController.text, passwordController.text),
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

  void _passwordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<AuthBloc, BlocAuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            context.go('/second');
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, BlocAuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return const Center(child: Text('Юзер не авторизован'));
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
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(
                                    context, _emailFocus, _passwordFocus);
                              },
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              controller: emailController,
                              decoration:
                                  decoration('Введите почту', 'Почта'),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(context, _passwordFocus,
                                    _confirmPasswordFocus);
                              },
                              focusNode: _passwordFocus,
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              controller: passwordController,
                              decoration:
                                  decoration('Введите пароль', 'Пароль'),
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                TextButton(
                                   onPressed: () {
                                    context.go("/RecoverPassword");
                                  },
                                  child: const Text('Восстановить пароль',
                                  style: TextStyle(color: Colors.blue),),
                                  
                                 
                                )
                              ],
                            )
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
          },
        ),
      ),
    );
  }
}

InputDecoration decoration(String hintText, String labelText) {
  return InputDecoration(
    filled: true,
    fillColor: const Color(0xffF3F3F3),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: Color(0xffF3F3F3),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(color: Colors.white),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
        color: Color(0xffB6B6B6), fontWeight: FontWeight.w600, fontSize: 14),
    labelText: labelText,
    labelStyle: const TextStyle(
        color: Color(0xffB6B6B6), fontWeight: FontWeight.w600, fontSize: 14),
  );
}