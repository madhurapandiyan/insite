import 'package:json_annotation/json_annotation.dart';

part 'asset_location_history.g.dart';

@JsonSerializable()
class AssetLocationHistory {
  AssetLocationHistory({
    this.pagination,
    this.links,
    this.assetLocation,
  });

  Pagination pagination;
  Links links;
  List<AssetLocation> assetLocation;

  factory AssetLocationHistory.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocationHistoryToJson(this);
}

@JsonSerializable()
class AssetLocation {
  AssetLocation({
    this.assetEventHistoryId,
    this.assetIdentifier,
    this.serialNumber,
    this.makeCode,
    this.model,
    this.locationEventUtc,
    this.locationEventLocalTime,
    this.locationEventLocalTimeZoneAbbrev,
    this.latitude,
    this.longitude,
    this.address,
    this.odometer,
    this.hourmeter,
    this.assetStatus,
  });

  int assetEventHistoryId;
  String assetIdentifier;
  String serialNumber;
  String makeCode;
  String model;
  DateTime locationEventUtc;
  DateTime locationEventLocalTime;
  String locationEventLocalTimeZoneAbbrev;
  double latitude;
  double longitude;
  Address address;
  double odometer;
  double hourmeter;
  String assetStatus;

  factory AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocationToJson(this);
}

@JsonSerializable()
class Address {
  Address({
    this.streetAddress,
    this.city,
    this.state,
    this.county,
    this.country,
    this.zip,
  });

  String streetAddress;
  String city;
  String state;
  String county;
  String country;
  String zip;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Links {
  Links({
    this.self,
  });

  String self;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
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
