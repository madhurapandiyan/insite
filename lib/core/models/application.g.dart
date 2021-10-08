// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationData _$ApplicationDataFromJson(Map<String, dynamic> json) {
  return ApplicationData(
    applications: (json['applications'] as List)
        ?.map((e) =>
            e == null ? null : Application.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ApplicationDataToJson(ApplicationData instance) =>
    <String, dynamic>{
      'applications': instance.applications,
    };

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return Application(
    appOwner: json['appOwner'] as String,
    iconUrl: json['iconUrl'] as String,
    appUID: json['appUID'] as String,
    appUrl: json['appUrl'] as String,
    displayOrder: json['displayOrder'] as int,
    enabled: json['enabled'] as bool,
    marketUrl: json['marketUrl'] as String,
    name: json['name'] as String,
    tpaasAppId: (json['tpaasAppId'] as num)?.toDouble(),
    tpaasAppName: json['tpaasAppName'] as String,
    welcomePageInd: json['welcomePageInd'] as int,
  );
}

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'appUID': instance.appUID,
      'iconUrl': instance.iconUrl,
      'appUrl': instance.appUrl,
      'marketUrl': instance.marketUrl,
      'name': instance.name,
      'enabled': instance.enabled,
      'displayOrder': instance.displayOrder,
      'tpaasAppName': instance.tpaasAppName,
      'tpaasAppId': instance.tpaasAppId,
      'appOwner': instance.appOwner,
      'welcomePageInd': instance.welcomePageInd,
    };
