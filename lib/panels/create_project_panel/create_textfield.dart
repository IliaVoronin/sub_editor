import 'package:flutter/material.dart';

class CreateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  

  const CreateTextField({
    super.key,
    required this.controller,
    required this.hintText,
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      fillColor: const Color.fromARGB(255, 240, 240, 240),
                      filled: true,
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Color.fromARGB(255, 189, 189, 189))
                    ),
                  ),
                ),
              );
  }
}