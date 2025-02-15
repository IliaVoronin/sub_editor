import 'package:flutter/material.dart';

class NameRow extends StatelessWidget {

  final String userEmail;
  
  const NameRow({
    super.key,
    required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.red
            ),
            child: Center(
              child: Text(
                userEmail[0].toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            userEmail,
            textAlign: TextAlign.center,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            )
          ),
        )
      ],
    );
  }
}