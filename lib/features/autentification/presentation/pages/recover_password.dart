import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';
import 'package:school_journal/features/autentification/presentation/widgets/init_bloc_direction.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void initState()  {
    initBlocDirection(unAuthenticationWidget: const RecoverPasswordPage());
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
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
                      'Восстановление пароля',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: heightScreen * 0.024,
                          letterSpacing: 1.4),
                    ),
                  ],
                ),
                SizedBox(height: heightScreen * 0.3),
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
                        decoration: DecorationClass()
                            .decoration('Введите почту', 'Почта'),
                      ),
                      SizedBox(height: heightScreen * 0.1),
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
                          onPressed: () {},
                          child: const Text(
                            'Отправить новый пароль на почту',
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
                  child: const Text('Предыдущая страница'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
