import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_journal/common/color.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 1,
      builder: (_, controller) => Container(
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
                      image: AssetImage('assets/images/cross_icon.png'),
                    ),
                  ),
                  SizedBox(
                    width: widthScreen / 5,
                  ),
                  Text(
                    'Добавить Ученика',
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
                      hintText: 'Введите ФИО',
                      hintStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      labelText: 'фИО',
                      labelStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      suffixIcon: Image(
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
                      hintText: 'Введите почту',
                      hintStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      labelText: 'Почта (не обязательно)',
                      labelStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      suffixIcon: Image(
                        height: 20,
                        image: AssetImage('assets/images/pen_icon.png'),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            SizedBox(
              height: 56,
              width: widthScreen * 0.88,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(AppColors.purple),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Добавить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: heightScreen * 0.022,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.065)
          ],
        ),
      ),
    );
  }
}