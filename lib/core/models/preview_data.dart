import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'preview_data.g.dart';

@JsonSerializable()
class PreviewData {
  final String? title;
  final String? value;

  PreviewData({this.title, this.value});

  factory PreviewData.fromJson(Map<String, dynamic> json) =>
      _$PreviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewDataToJson(this);
}
