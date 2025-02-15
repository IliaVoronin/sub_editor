import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final IconData buttonIcon;
  final Color buttonColor;
  final VoidCallback onTap;

  const CreateButton(
      {super.key,
      required this.buttonIcon,
      required this.buttonColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 126, 197, 255),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Icon(
            buttonIcon,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
