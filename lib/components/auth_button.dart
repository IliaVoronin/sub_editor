import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  final Function()? onTap;
  final String buttonText;

  const AuthButton({
    super.key,
    required this.onTap,
    required this.buttonText
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: SizedBox(
          width: 400,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Center(child: 
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}