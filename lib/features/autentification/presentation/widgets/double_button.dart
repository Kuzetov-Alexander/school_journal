import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';

class DoubleButton extends StatelessWidget {
  const DoubleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromRGBO(118, 118, 128, 0.12),
      ),
      padding: const EdgeInsets.all(2),
      // height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Button(
            onPressed: () =>
                context.read<Providerbool>().changedTypePerson(true),
            nameButton: 'Учитель',
            color: context.watch<Providerbool>().teacher
                ? Colors.white
                : Colors.transparent,
          ),
          const SizedBox(width: 2),
          Button(
            onPressed: () =>
                context.read<Providerbool>().changedTypePerson(false),
            nameButton: 'Ученик',
            color: !context.watch<Providerbool>().teacher
                ? Colors.white
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String nameButton;
  final Color color;
  final void Function() onPressed;

  const Button(
      {super.key,
      required this.nameButton,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: MaterialStatePropertyAll(color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          nameButton,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              letterSpacing: -0.078),
        ),
      ),
    );
  }
}
