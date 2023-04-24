import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/features/autentification/presentation/widgets/double_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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

  // Future<void> _submitForm() async {
  //   if (formKey.currentState!.validate()) {
  //     // formKey.currentState!.save();

  //     debugPrint('---------------Number email: ${emailController.text}');
  //     debugPrint('---------------Number password: ${passwordController.text}');
  //     debugPrint(
  //         '---------------Confirm password: ${confirmPasswordController.text}');
  //   }
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use') {
  //       SnackBarService.showSnackBar(
  //           context, 'Такой Email уже используется', true);
  //       return;
  //     } else {
  //       SnackBarService.showSnackBar(context, 'Неизвестная ошибка', true);
  //     }
  //     debugPrint(e.code);
  //   } catch (e) {
  //     debugPrint('----------$e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Регистрация',
                        textAlign: TextAlign.start,
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
                                context, _fullNameFocus, _emailFocus);
                          },
                          focusNode: _fullNameFocus,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          controller: fullNameController,
                          decoration: decoration('Введите полное имя', 'ФИО'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          onFieldSubmitted: (_) {
                            _fieldFocusChange(
                                context, _emailFocus, _passwordFocus);
                          },
                          focusNode: _emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          controller: emailController,
                          decoration: decoration('Введите почту', 'Почта'),
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
                          decoration: decoration('Введите пароль', 'Пароль'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          focusNode: _confirmPasswordFocus,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          controller: confirmPasswordController,
                          decoration: decoration(
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
                              // emailController.text = 'uraltools96@mail.ru';
                              // emailController.text = 'ip.stolets@yandex.ru';
                              // _password = 'Qazwsxedc1!';
                              // passwordController.text = _password;
                              // confirmPasswordController.text = 'Qazwsxedc1!';
                              // _submitForm().then((value) {
                              //   setState(() {
                              //     context.go('/verifymail');
                              //   });
                              // });
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
                      context.go('/second');
                    },
                    child: const Text('Следующая страница'),
                  ),
                ],
              ),
            ),
          ),
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
