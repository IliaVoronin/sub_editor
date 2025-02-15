import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class BoxTimeTextfield extends StatelessWidget {
  final TextEditingController controller;
  BoxTimeTextfield({super.key, required this.controller});

  var maskFormatter = MaskTextInputFormatter(
      mask: '##:##:##,###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: TextField(
          inputFormatters: [maskFormatter],
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Color.fromARGB(255, 240, 240, 240),
            filled: true,
            hintText: '00:00:00,000',
            hintStyle: TextStyle(color: Color.fromARGB(255, 189, 189, 189))
          ),
        ));
  }
}
