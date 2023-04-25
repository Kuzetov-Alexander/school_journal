import 'package:flutter/material.dart';

class DoubleButton extends StatelessWidget {
  const DoubleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromRGBO(118, 118, 128, 0.12),
      ),
      padding: const EdgeInsets.all(21),
      // height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Button(
            nameButton: 'Учитель',
            color: Colors.white,
          ),
          SizedBox(width: 2),
          Button(
            nameButton: 'Ученик',
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String nameButton;
  final Color color;

  const Button({super.key, required this.nameButton, required this.color});

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
        onPressed: () {},
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
