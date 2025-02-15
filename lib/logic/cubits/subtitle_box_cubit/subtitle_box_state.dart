import 'package:sub_editor/logic/models/subtitle_box_model.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';

class SubtitleBoxState {
  final Subtitles subtitleBoxes;
  final SubtitleController subtitleController;

  SubtitleBoxState({
    required this.subtitleBoxes, 
    required this.subtitleController
  });
}
