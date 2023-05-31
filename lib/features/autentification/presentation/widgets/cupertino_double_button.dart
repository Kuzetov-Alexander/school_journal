import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_journal/features/autentification/presentation/provider.dart/provider.dart';

class CupertinoDoubleButton extends StatefulWidget {
  const CupertinoDoubleButton({super.key});

  @override
  State<CupertinoDoubleButton> createState() => _CupertinoDoubleButtonState();
}

class _CupertinoDoubleButtonState extends State<CupertinoDoubleButton> {
  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderLoginBool>(context);
    // double heightScreen = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
        padding: const EdgeInsets.all(4),
        groupValue: provider.indexDoubleButton,
        children: const {
          0: TextWidget(text: 'Учитель'),
          1: TextWidget(text: 'Ученик'),
        },
        onValueChanged: (int? newIndex) {
          setState(() {
            provider.indexDoubleButton = newIndex;
          });

          getIndex(provider, context);
        },
      ),
    );
  }

  void getIndex(ProviderLoginBool provider, BuildContext context) {
    if (provider.indexDoubleButton == 1) {
      context.read<ProviderLoginBool>().changedTypePerson(false);
    } else {
      context.read<ProviderLoginBool>().changedTypePerson(true);
    }
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: -0.078),
    );
  }
}
