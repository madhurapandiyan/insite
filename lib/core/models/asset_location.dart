import 'package:json_annotation/json_annotation.dart';

part 'asset_location.g.dart';

@JsonSerializable()
class AssetLocationData {
  AssetLocationData({
    this.pagination,
    this.links,
    this.mapRecords,
    this.countData,
  });

  Pagination pagination;
  Links links;
  List<MapRecord> mapRecords;
  List<CountDatum> countData;

  factory AssetLocationData.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocationDataToJson(this);
}

@JsonSerializable()
class CountDatum {
  CountDatum({
    this.countOf,
    this.count,
  });

  String countOf;
  int count;

  factory CountDatum.fromJson(Map<String, dynamic> json) =>
      _$CountDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CountDatumToJson(this);
}

@JsonSerializable()
class Links {
  Links({
    this.self,
    this.next,
    this.prev,
  });

  String self;
  String next;
  dynamic prev;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class MapRecord {
  MapRecord({
    this.assetIdentifier,
    this.assetSerialNumber,
    this.manufacturer,
    this.makeCode,
    this.model,
    this.assetIcon,
    this.status,
    this.hourMeter,
    this.odometer,
    this.lastReportedLocationLatitude,
    this.lastReportedLocationLongitude,
    this.lastReportedLocation,
    this.lastReportedUtc,
    this.fuelLevelLastReported,
    this.notifications,
    this.geofences,
    this.lastLocationUpdateUtc,
  });

  String assetIdentifier;
  String assetSerialNumber;
  String manufacturer;
  String makeCode;
  String model;
  int assetIcon;
  String status;
  double hourMeter;
  double odometer;
  double lastReportedLocationLatitude;
  double lastReportedLocationLongitude;
  String lastReportedLocation;
  DateTime lastReportedUtc;
  double fuelLevelLastReported;
  int notifications;
  List<dynamic> geofences;
  DateTime lastLocationUpdateUtc;

  factory MapRecord.fromJson(Map<String, dynamic> json) =>
      _$MapRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MapRecordToJson(this);
}

@JsonSerializable()
class Pagination {
  Pagination({
    this.totalCount,
    this.pageNumber,
    this.pageSize,
  });

  int totalCount;
  int pageNumber;
  int pageSize;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
