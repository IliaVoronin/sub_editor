import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_cubit.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_state.dart';
import 'package:sub_editor/panels/temp_player/subtitle_box.dart';

import '../../logic/cubits/box_editor_cubit/box_editor_cubit.dart';

class SubtitleManager extends StatefulWidget {
  final BoxEditorCubit boxEditorCubit;
  final SubtitleBoxCubit subtitleBoxCubit;
  final String subLink;
  
  const SubtitleManager({super.key, required this.subLink, required this.subtitleBoxCubit, required this.boxEditorCubit});

  @override
  State<SubtitleManager> createState() => _SubtitleManagerState();
}

class _SubtitleManagerState extends State<SubtitleManager> {

  @override
  void initState() {
    super.initState();
    widget.subtitleBoxCubit.loadSubtitles(widget.subLink);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.subtitleBoxCubit,
      child: BlocBuilder<SubtitleBoxCubit, SubtitleBoxState>(
        builder: (context, state) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ListView(
                children: [
                  for (int i = 0; i < state.subtitleBoxes.subtitles.length; i++)
                    SubtitleBox(model: state.subtitleBoxes.subtitles[i], boxEditorCubit: widget.boxEditorCubit),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.subtitleBoxCubit.addSubtitle('00:00:00,000', '');
                          widget.boxEditorCubit.setSubtitleBox(state.subtitleBoxes.subtitles.last);
                          widget.boxEditorCubit.setControllersText();
                          widget.subtitleBoxCubit.updateContent();
                         },
                        icon: const Icon(
                          Icons.add)),
                      IconButton(
                        onPressed: () {
                          widget.subtitleBoxCubit.deleteSubtitle();
                          widget.boxEditorCubit.setSubtitleBox(state.subtitleBoxes.subtitles.last);
                          widget.boxEditorCubit.setControllersText();
                          widget.subtitleBoxCubit.updateContent();
                         },
                        icon: const Icon(Icons.remove)),
                        //IconButton(onPressed: () {}, icon: const Icon(Icons.save, size: 25)),
                        //IconButton(onPressed: () {}, icon: const Icon(Icons.translate, size: 25)),
                        //IconButton(onPressed: () {}, icon: const Icon(Icons.generating_tokens_outlined , size: 25)),
                        //IconButton(onPressed: () {}, icon: const Icon(Icons.download, size: 25)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
