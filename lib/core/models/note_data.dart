import 'package:insite/core/models/note.dart';
import 'package:json_annotation/json_annotation.dart';
part 'note_data.g.dart';

@JsonSerializable()
class NotesData {
  List<Note>? getMetadataNotes;
  NotesData({this.getMetadataNotes});
  factory NotesData.fromJson(Map<String, dynamic> json) =>
      _$NotesdataFromJson(json);

  Map<String, dynamic> toJson() => _$NotesdataToJson(this);
}
