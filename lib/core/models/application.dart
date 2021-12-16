import 'package:json_annotation/json_annotation.dart';
part 'application.g.dart';

@JsonSerializable()
class ApplicationData {
  final List<Application>? applications;
  ApplicationData({this.applications});
  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      _$ApplicationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationDataToJson(this);
}

@JsonSerializable()
class Application {
  final String? appUID;
  final String? iconUrl;
  final String? appUrl;
  final String? marketUrl;
  final String? name;
  final bool? enabled;
  final int? displayOrder;
  final String? tpaasAppName;
  final double? tpaasAppId;
  final String? appOwner;
  final int? welcomePageInd;
  Application(
      {this.appOwner,
      this.iconUrl,
      this.appUID,
      this.appUrl,
      this.displayOrder,
      this.enabled,
      this.marketUrl,
      this.name,
      this.tpaasAppId,
      this.tpaasAppName,
      this.welcomePageInd});
  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationToJson(this);
}
