// "fault":{"code":900903,"message":"Authentication Failure","description":"Access Token Expired"}
import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable()
class Error {
  final int? code;
  final String? message;
  final String? description;
  Error({this.code, this.message, this.description});
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
