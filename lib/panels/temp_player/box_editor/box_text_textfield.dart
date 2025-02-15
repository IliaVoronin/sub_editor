import 'package:flutter/material.dart';

class BoxTextTextfield extends StatelessWidget {
  final TextEditingController controller;
  const BoxTextTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 300,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
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
                hintText: 'Input text here...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 189, 189, 189))),
          ),
        ),
      ),
    );
  }
}
