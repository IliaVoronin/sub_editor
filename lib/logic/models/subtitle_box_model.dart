class SubtitleBoxModel {
  final int id;
  final String start;
  final String end;
  final String text;

  SubtitleBoxModel(
      {required this.id,
      required this.start,
      required this.end,
      required this.text});

    @override
  String toString() {
    return '$id\n$start --> $end\n$text';
  }
}


class Subtitles {
  final List<SubtitleBoxModel> subtitles;

  Subtitles({required this.subtitles});

  @override
  String toString() {
    String stringSubs = '';
    for (int i = 0; i < subtitles.length; i++) {
      stringSubs = '$stringSubs${subtitles[i]}\n\n';
    }
    return stringSubs;
  }


  // Метод добавления субтитра в конец
  void addSubtitle(String end, String text) {
    int newId = subtitles.isEmpty ? 1 : subtitles.last.id + 1;
    SubtitleBoxModel newSub =
        SubtitleBoxModel(id: newId, start: subtitles.last.end, end: end, text: text);
    subtitles.add(newSub);
  }

  // Метод удаления последнего субтитра
  void deleteSubtitle() {
    subtitles.removeLast();
  }

  // Метод изменения субтитра по id
  void changeSub(int id, String start, String end, String text) {
    for (int i = 0; i < subtitles.length; i++) {
      if (subtitles[i].id == id) {
        subtitles[i] = SubtitleBoxModel(
          id: id,
          start: start,
          end: end,
          text: text,
        );
        break;
      }
    }
  }
}