// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_single_transfer_deviceId_graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceIdValues _$DeviceIdValuesFromJson(Map<String, dynamic> json) =>
    DeviceIdValues(
      hierarchyFleetSearch: (json['hierarchyFleetSearch'] as List<dynamic>?)
          ?.map((e) => HierarchyFleetSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeviceIdValuesToJson(DeviceIdValues instance) =>
    <String, dynamic>{
      'hierarchyFleetSearch': instance.hierarchyFleetSearch,
    };

HierarchyFleetSearch _$HierarchyFleetSearchFromJson(
        Map<String, dynamic> json) =>
    HierarchyFleetSearch(
      vin: json['vin'] as String?,
      gpsDeviceID: json['gpsDeviceID'] as String?,
      typeName: json['__typename'] as String?,
    );

Map<String, dynamic> _$HierarchyFleetSearchToJson(
        HierarchyFleetSearch instance) =>
    <String, dynamic>{
      'vin': instance.vin,
      'gpsDeviceID': instance.gpsDeviceID,
      '__typename': instance.typeName,
    };
