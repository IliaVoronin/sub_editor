import 'package:flutter/material.dart';
import 'package:sub_editor/logic/cubits/box_editor_cubit/box_editor_cubit.dart';

import '../../logic/models/subtitle_box_model.dart';

class SubtitleBox extends StatelessWidget {
  final BoxEditorCubit boxEditorCubit;
  final SubtitleBoxModel model;
  const SubtitleBox(
      {super.key, required this.model, required this.boxEditorCubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        boxEditorCubit.setSubtitleBox(model);
        boxEditorCubit.setControllersText();
      },
      child: Container(
          width: 500,
          height: 60,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Stack(children: [
            Row(
              children: [
                // Номер субтитра
                const SizedBox(width: 10),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        model.id.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Тайминг субтитров
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.start),
                    const Icon(
                      Icons.arrow_downward_rounded,
                      size: 15,
                    ),
                    Text(model.end),
                  ],
                ),

                const SizedBox(width: 15),
                Flexible(
                    child: Text(model.text,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ))),
                IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_downward_rounded, color: Colors.red,size: 20)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: Colors.red, size: 20))
              ],
            ),
          ])),
    );
  }
}
