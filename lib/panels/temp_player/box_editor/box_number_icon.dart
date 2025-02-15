import 'package:flutter/material.dart';

class BoxNumberIcon extends StatelessWidget {
  final String subNumber;
  const BoxNumberIcon({super.key, required this.subNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.red),
        child: Center(
          child: Text(
            subNumber,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
