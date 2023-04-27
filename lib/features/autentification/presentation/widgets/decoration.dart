import 'package:flutter/material.dart';

class DecorationClass extends InputDecoration {
  InputDecoration decoration(String hintText, String labelText) {
    return InputDecoration(
      // counterText: '',
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
}
