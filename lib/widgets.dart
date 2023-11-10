import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingcontroller;
  final String hintText;
  final TextInputType tectInputType;
  final bool isPass;

  const TextFieldInput({
    super.key,
    required this.textEditingcontroller,
    required this.hintText,
    required this.tectInputType,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      width: 600,
      child: TextField(
        controller: textEditingcontroller,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: tectInputType,
        obscureText: isPass,
        //textAlign: TextAlign.center,
      ),
    );
  }
}
