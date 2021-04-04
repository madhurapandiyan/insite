import 'package:insite/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
import 'links.dart';
part 'asset.g.dart';

@JsonSerializable()
class Asset {
  final String assetUid;
  final String assetId;
  final String makeCode;
  final String model;
  final String serialNumber;
  final String productFamily;
  final String customStateDescription;
  final double dateRangeRuntimeDuration;
  final String lastKnownOperator;
  final String capabilities;
  final AssetLastReceivedEvent assetLastReceivedEvent;
  Asset(
      this.assetId,
      this.assetUid,
      this.makeCode,
      this.model,
      this.serialNumber,
      this.productFamily,
      this.assetLastReceivedEvent,
      this.customStateDescription,
      this.dateRangeRuntimeDuration,
      this.lastKnownOperator,
      this.capabilities);

  factory Asset.fromJson(dynamic json) {
    try {
      Logger().d(json);
      return _$AssetFromJson(json);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetLastReceivedEvent {
  final String lastReceivedEvent;
  final String lastReceivedEventTimeLocal;
  final String lastReceivedEventUTC;
  final String timezoneAbbrev;
  final String serialNumber;
  final String segmentType;

  AssetLastReceivedEvent(
    this.lastReceivedEvent,
    this.lastReceivedEventTimeLocal,
    this.lastReceivedEventUTC,
    this.timezoneAbbrev,
    this.serialNumber,
    this.segmentType,
  );

  factory AssetLastReceivedEvent.fromJson(Map<String, dynamic> json) {
    try {
      Logger().d(json);
      return _$AssetLastReceivedEventFromJson(json);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$AssetLastReceivedEventToJson(this);
}

@JsonSerializable()
class AssetSummaryResponse {
  final List<Links> links;
  final AssetPagination pagination;
  final List<Asset> assets;
  AssetSummaryResponse({this.assets, this.links, this.pagination});

  factory AssetSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetSummaryResponseToJson(this);
}

@JsonSerializable()
class AssetResponse {
  final AssetSummaryResponse assetOperations;
  AssetResponse({this.assetOperations});
  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResponseToJson(this);
}
