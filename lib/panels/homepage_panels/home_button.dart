import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  
  final String buttonText;
  final IconData buttonIcon;
  final Color buttonColor;
  final VoidCallback onTap;

  const HomeButton({
    super.key, 
    required this.buttonText,
    required this.buttonIcon, 
    required this.buttonColor, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
        child: SizedBox(
          width: 300,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  buttonIcon,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Center(
                    child: Text(
                      buttonText,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}