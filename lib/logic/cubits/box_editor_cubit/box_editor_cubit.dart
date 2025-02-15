import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_cubit.dart';
import 'package:sub_editor/logic/models/controllers_model.dart';
import 'package:sub_editor/logic/models/subtitle_box_model.dart';
import 'box_editor_state.dart';

class BoxEditorCubit extends Cubit<BoxEditorState> {
  BoxEditorCubit()
      : super(BoxEditorState(
            subtitleBox: SubtitleBoxModel(
                id: 0,
                start: '00:00:00,000',
                end: '00:00:00,000',
                text: 'Input text here...'),
            controllers: ControllersModel(
                start: TextEditingController(),
                end: TextEditingController(),
                text: TextEditingController())));

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController textController = TextEditingController();

  void setSubtitleBox(SubtitleBoxModel model) {
    emit(BoxEditorState(
        subtitleBox: model,
        controllers: ControllersModel(
            start: startController, 
            end: endController, 
            text: textController)));
  }

  SubtitleBoxModel getCurrentModel() {
    return state.subtitleBox;
  }

  void setControllersText() {
    startController.text = state.subtitleBox.start;
    endController.text = state.subtitleBox.end;
    textController.text = state.subtitleBox.text;
  }

  void editSubtitle(
      int id, String start, String end, String text, SubtitleBoxCubit cubit) {
    cubit.state.subtitleBoxes.changeSub(id, start, end, text);
  }
}
