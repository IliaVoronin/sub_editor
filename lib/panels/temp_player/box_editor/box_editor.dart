import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/box_editor_cubit/box_editor_cubit.dart';
import 'package:sub_editor/logic/cubits/box_editor_cubit/box_editor_state.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_cubit.dart';
import 'package:sub_editor/panels/temp_player/box_editor/box_number_icon.dart';
import 'package:sub_editor/panels/temp_player/box_editor/box_text_textfield.dart';
import 'package:sub_editor/panels/temp_player/box_editor/box_time_textfield.dart';
import 'package:video_player/video_player.dart';

class BoxEditor extends StatefulWidget {
  final BoxEditorCubit boxEditorCubit;
  final SubtitleBoxCubit subtitleBoxCubit;
  final VideoPlayerController videoController;

  const BoxEditor(
      {super.key,
      required this.boxEditorCubit,
      required this.subtitleBoxCubit,
      required this.videoController});

  @override
  State<BoxEditor> createState() => _BoxEditorState();
}

class _BoxEditorState extends State<BoxEditor> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.boxEditorCubit,
      child: BlocBuilder<BoxEditorCubit, BoxEditorState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Номер субтитра
                  BoxNumberIcon(subNumber: state.subtitleBox.id.toString()),
                  const SizedBox(width: 15),

                  // Тайминг начала
                  const Text(
                    'Begining: ',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  BoxTimeTextfield(controller: state.controllers.start),
                  IconButton(
                      onPressed: () {
                        String currentPosition =
                            widget.videoController.value.position.toString();
                        currentPosition = currentPosition.substring(
                            0, currentPosition.length - 3);
                        currentPosition =
                            '0${currentPosition.replaceAll('.', ',')}';
                        state.controllers.start.text = currentPosition;
                      },
                      icon: const Icon(Icons.timer, color: Colors.red)),
                  const SizedBox(width: 15),

                  // Тайминг конца
                  const Text(
                    'Ending: ',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  BoxTimeTextfield(controller: state.controllers.end),
                  IconButton(
                      onPressed: () {
                        String currentPosition =
                            widget.videoController.value.position.toString();
                        currentPosition = currentPosition.substring(
                            0, currentPosition.length - 3);
                        currentPosition =
                            '0${currentPosition.replaceAll('.', ',')}';
                        state.controllers.end.text = currentPosition;
                      },
                      icon: const Icon(Icons.timer, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 15),
              BoxTextTextfield(controller: state.controllers.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        widget.subtitleBoxCubit.editSubtitle(state.subtitleBox.id, state.controllers.start.text, state.controllers.end.text, state.controllers.text.text);
                        widget.subtitleBoxCubit.updateContent();
                      },
                      icon: const Icon(Icons.save, color: Colors.red, size: 40,)),
                  const SizedBox(width: 20),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.translate, color: Colors.red, size: 40,))    
                ],
              ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}


//state.subtitleBox.toString()