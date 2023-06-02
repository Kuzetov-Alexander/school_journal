import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:school_journal/features/autentification/presentation/bloc/bloc/bloc_auth_bloc.dart';
import 'package:school_journal/features/autentification/presentation/widgets/decoration.dart';
import 'package:school_journal/features/teacher_profile/Presentation/bloc/bloc_user_profile_bloc.dart';
import 'package:school_journal/features/teacher_profile/Presentation/widgets/edit_certificate_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();

    _fullNameFocus.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  void _signOut(context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutRequestedEvent(),
    );
  }

  void _deleteUserProfile() {
    BlocProvider.of<BlocUserProfileBloc>(context).add(
      DeleteUserProfileEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(widthScreen * 0.06),
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
                controller: fullNameController,
                decoration: InputDecoration(
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
                    borderSide: BorderSide(color: Color(0xffF3F3F3)),
                  ),
                  hintText: '',
                  hintStyle: const TextStyle(
                      color: Color(0xffB6B6B6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  labelText: '${user?.displayName}',
                  labelStyle: const TextStyle(
                      color: Color(0xffB6B6B6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  suffixIcon: const Image(
                    height: 20,
                    image: AssetImage('assets/images/pen_icon.png'),
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailController,
                decoration: DecorationClass().decoration('', '${user?.email}'),
              ),
              SizedBox(height: heightScreen * 0.019),
              SizedBox(
                height: heightScreen * 0.065,
                width: widthScreen * 0.88,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xffF3F3F3)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) => const EditCertificateWidget(),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.013),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Настройка аттестации',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: heightScreen * 0.019,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: heightScreen * 0.019),
              SizedBox(
                height: heightScreen * 0.065,
                width: widthScreen * 0.88,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xffF3F3F3)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _signOut(context);
                    context.go('/');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.013),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Выйти',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: heightScreen * 0.019,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                height: heightScreen * 0.065,
                width: widthScreen * 0.88,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xffF3F3F3)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Future deleteUserProfile() async {
                    //   final Future<SharedPreferences> prefs =
                    //       SharedPreferences.getInstance();
                    //   final sharedPreferences = await prefs;
                    //   final String passwordUser =
                    //       sharedPreferences.getString('password').toString();
                    //   final String emailUser =
                    //       sharedPreferences.getString('email').toString();
                    //   AuthCredential credentials = EmailAuthProvider.credential(
                    //       email: emailUser, password: passwordUser);
                    //   await user?.reauthenticateWithCredential(credentials);
                    //   final userId = FirebaseAuth.instance.currentUser?.uid;
                    //   final dataBase = FirebaseDatabase.instance.ref();
                    //   final userDB = dataBase.child('Users/$userId');
                    //   userDB.set({});
                    //   await user?.delete();
                    // }

                    // await deleteUserProfile();
                    _deleteUserProfile();
                    context.go('/');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScreen * 0.013),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Удалить профиль',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: heightScreen * 0.019,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
