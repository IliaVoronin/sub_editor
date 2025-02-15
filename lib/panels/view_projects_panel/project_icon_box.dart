import 'package:flutter/material.dart';
import '../../logic/models/project_icon_model.dart';

class ProjectIconBox extends StatelessWidget {
  final ProjectIconModel projectIcon;
  final VoidCallback onTap;

  const ProjectIconBox(
      {super.key, required this.projectIcon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.black26]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              projectIcon.projectName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(projectIcon.proejctTime,
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Text(projectIcon.proejctVideoLink.split('/')[2],
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.white,)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.white,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
