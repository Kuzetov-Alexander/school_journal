import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/student_scores/domain/entities/entity_student_scores.dart';

class StudentProfile extends StatefulWidget {
  final EntityStudentScores student;

  const StudentProfile({
    super.key,
    required this.student,
  });

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: heightScreen * 0.95,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Image(
                            image: AssetImage('assets/images/cross_icon.png'))),
                    SizedBox(
                      width: widthScreen / 5,
                    ),
                    Text(
                      'Профиль ученика',
                      style: TextStyle(
                          color: AppColors.black212525,
                          fontSize: heightScreen * 0.023,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                height: heightScreen * 0.001,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: heightScreen * 0.025,
                    horizontal: widthScreen * 0.06),
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
                      controller: _controllerName,
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
                        hintText: 'Введите ФИО',
                        hintStyle: const TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        labelText: widget.student.fullName,
                        labelStyle: const TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        suffixIcon: const Image(
                          height: 20,
                          image: AssetImage('assets/images/pen_icon.png'),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.02),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      buildCounter: (BuildContext context,
                              {int? currentLength,
                              required bool isFocused,
                              int? maxLength}) =>
                          null,
                      maxLength: 20,
                      controller: _controllerEmail,
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
                        hintText: 'Введите почту',
                        hintStyle: const TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        labelText: widget.student.email,
                        labelStyle: const TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        suffixIcon: const Image(
                          height: 20,
                          image: AssetImage('assets/images/pen_icon.png'),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.02),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      buildCounter: (BuildContext context,
                              {int? currentLength,
                              required bool isFocused,
                              int? maxLength}) =>
                          null,
                      maxLength: 20,
                      controller: _controllerEmail,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF3F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xffF3F3F3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(color: Color(0xffF3F3F3)),
                        ),
                        hintText: 'Личная ссылка',
                        hintStyle: TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        labelText: 'Ссылка',
                        labelStyle: TextStyle(
                            color: Color(0xff9D9D9D),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        suffixIcon: Image(
                          height: 20,
                          image: AssetImage('assets/images/import.png'),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.03),
                    SizedBox(
                      height: heightScreen * 0.07,
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Color(0xffF3F3F3)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            SizedBox(width: widthScreen * 0.011),
                            Text(
                              'Удалить',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: const Color(0xffF82525),
                                fontSize: heightScreen * 0.017,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
