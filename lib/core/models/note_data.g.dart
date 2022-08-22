// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesData _$NotesDataFromJson(Map<String, dynamic> json) => NotesData(
      getMetadataNotes: (json['getMetadataNotes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotesDataToJson(NotesData instance) => <String, dynamic>{
      'getMetadataNotes': instance.getMetadataNotes,
    };
