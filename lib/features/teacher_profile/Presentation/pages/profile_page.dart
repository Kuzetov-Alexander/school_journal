import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentfocus,
    FocusNode nextFocus,
  ) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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

  void _signOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        buildCounter: (BuildContext context,
                                {int? currentLength,
                                required bool isFocused,
                                int? maxLength}) =>
                            null,
                        maxLength: 20,
                        // controller: _controllerClass,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffFAFAFA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xffFAFAFA),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Color(0xffFAFAFA)),
                          ),
                          hintText: 'Введите кабинет',
                          hintStyle: TextStyle(
                              color: Color(0xff9D9D9D),
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          labelText: 'Кабинет (не обязательно)',
                          labelStyle: TextStyle(
                              color: Color(0xff9D9D9D),
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                          suffixIcon: Image(
                            height: 20,
                            image: AssetImage('assets/images/pen_icon.png'),
                            color: Colors.black,
                          ),
                        ),
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
                  decoration:
                      DecorationClass().decoration('', '${user?.email}'),
                ),
                const SizedBox(height: 16),
                Material(
                  child: InkWell(
                    onTap: () {
                      _signOut(context);
                      context.go('/');
                    },
                    child: Container(
                      height: 30,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent,
                      ),
                      child: const Text(
                        'Выйти',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}





class TextformFieldWidget extends StatelessWidget {
  const TextformFieldWidget({
    super.key,
    required TextEditingController controllerClass,
    required this.hintTextx,
    required this.labelTextx,
  }) : _controllerClass = controllerClass;

  final TextEditingController _controllerClass;
  final String hintTextx;
  final String labelTextx;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      autocorrect: false,
      buildCounter: (BuildContext context,
              {int? currentLength, required bool isFocused, int? maxLength}) =>
          null,
      maxLength: 20,
      controller: _controllerClass,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffFAFAFA),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: Color(0xffFAFAFA),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(color: Color(0xffFAFAFA)),
        ),
        hintText: hintTextx,
        hintStyle: const TextStyle(
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w600,
            fontSize: 14),
        labelText: labelTextx,
        labelStyle: const TextStyle(
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w600,
            fontSize: 10),
        suffixIcon: const Image(
          height: 20,
          image: AssetImage('assets/images/pen_icon.png'),
          color: Colors.black,
        ),
      ),
    );
  }
}