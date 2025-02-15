import 'package:flutter/material.dart';

class ProjectBox extends StatelessWidget {
  const ProjectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        
      ),
    );
  }
}