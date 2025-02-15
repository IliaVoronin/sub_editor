import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_state.dart';
import 'package:sub_editor/logic/models/subtitle_box_model.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';

class SubtitleBoxCubit extends Cubit<SubtitleBoxState> {
  SubtitleBoxCubit()
      : super(SubtitleBoxState(subtitleBoxes: Subtitles(subtitles: []), subtitleController: SubtitleController()));


  final subController = SubtitleController(
      showSubtitles: true,
      subtitlesContent: '',
      subtitleType: SubtitleType.srt,
    );

  
  void addSubtitle (String end, String text) {
    Subtitles newList = state.subtitleBoxes;
    newList.addSubtitle(end, text);
    emit(SubtitleBoxState(subtitleBoxes: newList, subtitleController: subController));
  }

  void deleteSubtitle () {
    Subtitles newList = state.subtitleBoxes;
    newList.deleteSubtitle();
    emit(SubtitleBoxState(subtitleBoxes: newList, subtitleController: subController));
  }

  void editSubtitle(int id, String start, String end, String text) {
    Subtitles newList = state.subtitleBoxes;
    newList.changeSub(id, start, end, text);
    emit(SubtitleBoxState(subtitleBoxes: newList, subtitleController: subController));
  }
  
  void updateContent() {
    state.subtitleController.updateSubtitleContent(content: getSubsInString());
  }

  //Метод подгрузки субтитров с облака
  Future loadSubtitles(String subLink) async {
    final ref = FirebaseStorage.instance.refFromURL(subLink);
    Uint8List? downloadedData = await ref.getData();

    Subtitles subs = getSubsFromString(utf8.decode(downloadedData!));
    emit(SubtitleBoxState(subtitleBoxes: subs, subtitleController: subController));
  }

  //Метод получения String из модели Subtitles
  String getSubsInString() {
    return state.subtitleBoxes.toString();
  }

  //Обратный метод получения модели Subtitles из String
  Subtitles getSubsFromString(String subsString) {
    List<SubtitleBoxModel> tempList = [];
    List<String> subBoxesStrings = subsString.split("\n\n");

    for (int i = 0; i < subBoxesStrings.length; i++) {
      List<String> subBoxStrings = subBoxesStrings[i].split('\n');
      String idField = subBoxStrings[0].trim();
      String textField = subBoxStrings[2].trim();
      String startField = subBoxStrings[1].split(' ')[0].trim();
      String endField = subBoxStrings[1].split(' ')[2].trim();

      SubtitleBoxModel temp = SubtitleBoxModel(
        id: int.parse(idField),
        start: startField,
        end: endField,
        text: textField,
      );
      tempList.add(temp);
    }
    return Subtitles(subtitles: tempList);
  }
}
