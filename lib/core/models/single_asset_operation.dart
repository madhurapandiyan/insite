import 'package:json_annotation/json_annotation.dart';

part 'single_asset_operation.g.dart';

@JsonSerializable()
class SingleAssetOperation {
  SingleAssetOperation({
    this.assetOperations,
  });

  AssetOperations assetOperations;

  factory SingleAssetOperation.fromJson(Map<String, dynamic> json) =>
      _$SingleAssetOperationFromJson(json);

  Map<String, dynamic> toJson() => _$SingleAssetOperationToJson(this);
}

@JsonSerializable()
class AssetOperations {
  AssetOperations({
    this.pagination,
    this.links,
    this.assets,
  });

  dynamic pagination;
  List<Link> links;
  List<Asset> assets;

  factory AssetOperations.fromJson(Map<String, dynamic> json) =>
      _$AssetOperationsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetOperationsToJson(this);
}

@JsonSerializable()
class Asset {
  Asset({
    this.assetUid,
    this.assetId,
    this.makeCode,
    this.model,
    this.serialNumber,
    this.assetIcon,
    this.productFamily,
    this.customStateDescription,
    this.distanceTravelledKilometers,
    this.dateRangeRuntimeDuration,
    this.lastKnownOperator,
    this.capabilities,
    this.assetLocalDates,
    this.assetLastReceivedEvent,
    this.firstEngineStartEvent,
    this.lastEngineStopEvent,
  });

  String assetUid;
  dynamic assetId;
  String makeCode;
  String model;
  String serialNumber;
  AssetIcon assetIcon;
  String productFamily;
  String customStateDescription;
  var distanceTravelledKilometers;
  var dateRangeRuntimeDuration;
  dynamic lastKnownOperator;
  Capabilities capabilities;
  List<AssetLocalDate> assetLocalDates;
  AssetLastReceivedEvent assetLastReceivedEvent;
  dynamic firstEngineStartEvent;
  dynamic lastEngineStopEvent;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetIcon {
  AssetIcon({
    this.key,
  });

  var key;

  factory AssetIcon.fromJson(Map<String, dynamic> json) =>
      _$AssetIconFromJson(json);

  Map<String, dynamic> toJson() => _$AssetIconToJson(this);
}

@JsonSerializable()
class AssetLastReceivedEvent {
  AssetLastReceivedEvent({
    this.lastReceivedEvent,
    this.lastReceivedEventTimeLocal,
    this.lastReceivedEventUtc,
    this.timezoneAbbrev,
    this.isPairedEvent,
    this.segmentType,
  });

  String lastReceivedEvent;
  DateTime lastReceivedEventTimeLocal;
  DateTime lastReceivedEventUtc;
  String timezoneAbbrev;
  bool isPairedEvent;
  String segmentType;

  factory AssetLastReceivedEvent.fromJson(Map<String, dynamic> json) =>
      _$AssetLastReceivedEventFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLastReceivedEventToJson(this);
}

@JsonSerializable()
class AssetLocalDate {
  AssetLocalDate({
    this.assetLocalDate,
    this.totalRuntimeDurationSeconds,
    this.totalRuntimeKeyDateDurationSeconds,
    this.segments,
  });

  DateTime assetLocalDate;
  var totalRuntimeDurationSeconds;
  var totalRuntimeKeyDateDurationSeconds;
  List<Segment> segments;

  factory AssetLocalDate.fromJson(Map<String, dynamic> json) =>
      _$AssetLocalDateFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocalDateToJson(this);
}

@JsonSerializable()
class Segment {
  Segment({
    this.startTimeUtc,
    this.endTimeUtc,
    this.startTimeLocal,
    this.endTimeLocal,
    this.startLocationLatitude,
    this.startLocationLongitude,
    this.startStateTimezoneAbbrev,
    this.endLocationLatitude,
    this.endLocationLongitude,
    this.endStateTimezoneAbbrev,
    this.durationSeconds,
    this.workDefinitionType,
    this.segmentType,
    this.isProjectedEnd,
    this.segmentOperator,
    this.updateUtc,
    this.startTimeKeyDateUtc,
    this.endTimeKeyDateUtc,
    this.startTimeKeyDateLocal,
    this.endTimeKeyDateLocal,
    this.durationKeyDateSeconds,
  });

  DateTime startTimeUtc;
  DateTime endTimeUtc;
  DateTime startTimeLocal;
  DateTime endTimeLocal;
  var startLocationLatitude;
  var startLocationLongitude;
  String startStateTimezoneAbbrev;
  var endLocationLatitude;
  var endLocationLongitude;
  String endStateTimezoneAbbrev;
  var durationSeconds;
  String workDefinitionType;
  String segmentType;
  bool isProjectedEnd;
  dynamic segmentOperator;
  DateTime updateUtc;
  DateTime startTimeKeyDateUtc;
  DateTime endTimeKeyDateUtc;
  DateTime startTimeKeyDateLocal;
  DateTime endTimeKeyDateLocal;
  var durationKeyDateSeconds;

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentToJson(this);
}

@JsonSerializable()
class Capabilities {
  Capabilities({
    this.hasActiveCoreSubscription,
  });

  String hasActiveCoreSubscription;

  factory Capabilities.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$CapabilitiesToJson(this);
}

@JsonSerializable()
class Link {
  Link({
    this.rel,
    this.href,
  });

  String rel;
  String href;

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
