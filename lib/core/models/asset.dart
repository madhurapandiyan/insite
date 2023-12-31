import 'package:insite/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'links.dart';
part 'asset.g.dart';

@JsonSerializable()
class Asset {
  final String? assetUid;
  final String? assetId;
  final String? makeCode;
  final String? model;
  final String? serialNumber;
  final AssetIconKey? assetIcon;
  final String? productFamily;
  final double? distanceTravelledKilometers;
  final String? customStateDescription;
  final double? dateRangeRuntimeDuration;
  final AssetLastReceivedEvent? assetLastReceivedEvent;
  final List<AssetLocalDate>? assetLocalDates;
  Asset(
      this.assetId,
      this.assetUid,
      this.makeCode,
      this.model,
      this.assetLocalDates,
      this.serialNumber,
      this.assetIcon,
      this.productFamily,
      this.assetLastReceivedEvent,
      this.customStateDescription,
      this.dateRangeRuntimeDuration,
      this.distanceTravelledKilometers);

  factory Asset.fromJson(dynamic json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetIconKey {
  final int? key;
  AssetIconKey({this.key});

  factory AssetIconKey.fromJson(Map<String, dynamic> json) =>
      _$AssetIconKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AssetIconKeyToJson(this);
}

@JsonSerializable()
class AssetLastReceivedEvent {
  final String? lastReceivedEvent;
  final String? lastReceivedEventTimeLocal;
  final String? lastReceivedEventUTC;
  final String? timezoneAbbrev;
  final String? serialNumber;
  final String? segmentType;

  AssetLastReceivedEvent(
    this.lastReceivedEvent,
    this.lastReceivedEventTimeLocal,
    this.lastReceivedEventUTC,
    this.timezoneAbbrev,
    this.serialNumber,
    this.segmentType,
  );

  factory AssetLastReceivedEvent.fromJson(Map<String, dynamic> json) =>
      _$AssetLastReceivedEventFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLastReceivedEventToJson(this);
}

@JsonSerializable()
class AssetSummaryResponse {
  final List<Links>? links;
  final Pagination? pagination;
  final List<Asset>? assets;
  AssetSummaryResponse({this.assets, this.links, this.pagination});

  factory AssetSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetSummaryResponseToJson(this);
}

@JsonSerializable()
class AssetResponse {
  final AssetSummaryResponse? assetOperations;
  AssetResponse({this.assetOperations});
  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResponseToJson(this);
}

@JsonSerializable()
class AssetLocalDate {
  final String? assetLocalDate;
  final double? totalRuntimeDurationSeconds;
  final AssetSegmentDuration? segmentDuration;
  AssetLocalDate(
      {this.assetLocalDate,
      this.segmentDuration,
      this.totalRuntimeDurationSeconds});

  factory AssetLocalDate.fromJson(Map<String, dynamic> json) =>
      _$AssetLocalDateFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocalDateToJson(this);
}

@JsonSerializable()
class AssetSegmentDuration {
  final double? runningDurationSeconds;
  final double? workingDurationSeconds;
  final double? idleDurationSeconds;

  AssetSegmentDuration(
      {this.runningDurationSeconds,
      this.workingDurationSeconds,
      this.idleDurationSeconds});

  factory AssetSegmentDuration.fromJson(Map<String, dynamic> json) =>
      _$AssetSegmentDurationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetSegmentDurationToJson(this);
}
