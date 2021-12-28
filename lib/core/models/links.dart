import 'package:json_annotation/json_annotation.dart';
part 'links.g.dart';

@JsonSerializable()
class Links {
  final String? self;
  final String? next;
  final String? prev;
  final String? rel;
  final String? href;

  Links({this.self, this.next, this.href, this.rel, this.prev});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
