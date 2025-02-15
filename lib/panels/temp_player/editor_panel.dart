import 'package:flutter/material.dart';
import 'package:sub_editor/logic/cubits/box_editor_cubit/box_editor_cubit.dart';
import 'package:sub_editor/panels/temp_player/box_editor/box_editor.dart';
import 'package:sub_editor/panels/temp_player/subtitle_manager.dart';
import 'package:sub_editor/panels/temp_player/test_player.dart';
import 'package:video_player/video_player.dart';

import '../../logic/cubits/subtitle_box_cubit/subtitle_box_cubit.dart';
import '../../logic/models/project_icon_model.dart';

class EditorPanel extends StatefulWidget {
  final ProjectIconModel model;
  const EditorPanel({
    super.key,
    required this.model,
  });

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  late SubtitleBoxCubit subtitleBoxCubit = SubtitleBoxCubit();
  late BoxEditorCubit boxEditorCubit = BoxEditorCubit();
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    loadSubController();
    loadVideoPlayer();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.network(widget.model.projectVideoUrl);
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  void loadSubController() async {
    await subtitleBoxCubit.loadSubtitles(widget.model.proejctSubUrl);
    subtitleBoxCubit.updateContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.model.projectName),
          backgroundColor: Colors.redAccent,
        ),
        body: Row(
          children: [
            // SubtitleManager
            SubtitleManager(
              subLink: widget.model.proejctSubUrl,
              subtitleBoxCubit: subtitleBoxCubit,
              boxEditorCubit: boxEditorCubit,
            ),
            // VideoPlayer
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Home(
                          subtitleBoxCubit: subtitleBoxCubit,
                          controller: controller,
                        )),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.black12,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: BoxEditor(
                            boxEditorCubit: boxEditorCubit,
                            subtitleBoxCubit: subtitleBoxCubit,
                            videoController: controller,
                          )),
                    ),
                  ],
                )),
          ],
        ));
  }
}
