import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:school_journal/common/color.dart';
import 'package:school_journal/features/teacher_groups/Presentation/bloc/bloc/bloc_teacher_groups_bloc.dart';

class AddNewGroup extends StatefulWidget {
  
  const AddNewGroup({super.key});

  @override
  State<AddNewGroup> createState() => _AddNewGroupState();
}

class _AddNewGroupState extends State<AddNewGroup> {
  final TextEditingController _controllerClass = TextEditingController();
  DateTime dateTimestart = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  DateTime dateTimefinish = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);

  void _createGroup(context) {
    BlocProvider.of<BlocTeacherGroupsBloc>(context)
        .add(CreateGroup(groupName: _controllerClass.text));
  
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Создание новой группы',
                        style: TextStyle(
                            color: AppColors.black212525,
                            fontSize: heightScreen * 0.023,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: heightScreen * 0.001,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 25),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    autocorrect: false,
                    buildCounter: (BuildContext context,
                            {int? currentLength,
                            required bool isFocused,
                            int? maxLength}) =>
                        null,
                    maxLength: 20,
                    controller: _controllerClass,
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
                      hintText: 'Введите название группы',
                      hintStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      labelText: 'Название группы',
                      labelStyle: TextStyle(
                          color: Color(0xff9D9D9D),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      suffixIcon: Image(
                        height: 20,
                        image: AssetImage('assets/images/pen_icon.png'),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.35,
                ),
                SizedBox(
                  height: 56,
                  width: widthScreen * 0.88,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          AppColors.purple),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _createGroup(context);

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: heightScreen * 0.022,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: heightScreen * 0.015,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
