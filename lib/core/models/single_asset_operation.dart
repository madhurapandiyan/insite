import 'package:insite/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
part 'single_asset_operation.g.dart';

@JsonSerializable()
class SingleAssetOperation {
  SingleAssetOperation({
    this.assetOperations,
  });

  AssetOperations assetOperations;

  factory SingleAssetOperation.fromJson(Map<String, dynamic> json) {
    try {
      return _$SingleAssetOperationFromJson(json);
    } catch (e) {
      Logger().e("SingleAssetOperation exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$SingleAssetOperationToJson(this);
}

@JsonSerializable()
class AssetOperations {
  AssetOperations({
    this.pagination,
    this.links,
    this.assets,
  });

  Pagination pagination;
  List<Link> links;
  List<Asset> assets;

  factory AssetOperations.fromJson(Map<String, dynamic> json) {
    try {
      return _$AssetOperationsFromJson(json);
    } catch (e) {
      Logger().e("AssetOperations exception");
      Logger().e(e);
      return null;
    }
  }

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
  String assetId;
  String makeCode;
  String model;
  String serialNumber;
  AssetIcon assetIcon;
  String productFamily;
  String customStateDescription;
  double distanceTravelledKilometers;
  double dateRangeRuntimeDuration;
  LastKnownOperator lastKnownOperator;
  Capabilities capabilities;
  List<AssetLocalDate> assetLocalDates;
  AssetLastReceivedEvent assetLastReceivedEvent;
  dynamic firstEngineStartEvent;
  dynamic lastEngineStopEvent;

  factory Asset.fromJson(Map<String, dynamic> json) {
    try {
      return _$AssetFromJson(json);
    } catch (e) {
      Logger().e("Asset exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetIcon {
  AssetIcon({
    this.key,
  });

  int key;

  factory AssetIcon.fromJson(Map<String, dynamic> json) {
    try {
      return _$AssetIconFromJson(json);
    } catch (e) {
      Logger().e("AssetIcon exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$AssetIconToJson(this);
    } catch (e) {
      Logger().e("AssetIcon exception");
      Logger().e(e);
      return null;
    }
  }
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

  factory AssetLastReceivedEvent.fromJson(Map<String, dynamic> json) {
    try {
      return _$AssetLastReceivedEventFromJson(json);
    } catch (e) {
      Logger().e("AssetLastReceivedEvent exception");
      Logger().e(e);
      return null;
    }
  }

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
  int totalRuntimeDurationSeconds;
  int totalRuntimeKeyDateDurationSeconds;
  List<Segment> segments;

  factory AssetLocalDate.fromJson(Map<String, dynamic> json) {
    try {
      return _$AssetLocalDateFromJson(json);
    } catch (e) {
      Logger().e("AssetLocalDate exception");
      Logger().e(e);
      return null;
    }
  }

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
  double startLocationLatitude;
  double startLocationLongitude;
  String startStateTimezoneAbbrev;
  double endLocationLatitude;
  double endLocationLongitude;
  String endStateTimezoneAbbrev;
  int durationSeconds;
  String workDefinitionType;
  String segmentType;
  bool isProjectedEnd;
  dynamic segmentOperator;
  DateTime updateUtc;
  DateTime startTimeKeyDateUtc;
  DateTime endTimeKeyDateUtc;
  DateTime startTimeKeyDateLocal;
  DateTime endTimeKeyDateLocal;
  int durationKeyDateSeconds;

  factory Segment.fromJson(Map<String, dynamic> json) {
    try {
      return _$SegmentFromJson(json);
    } catch (e) {
      Logger().e("Segment exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$SegmentToJson(this);
}

@JsonSerializable()
class Capabilities {
  Capabilities({
    this.hasActiveCoreSubscription,
  });

  String hasActiveCoreSubscription;

  factory Capabilities.fromJson(Map<String, dynamic> json) {
    try {
      return _$CapabilitiesFromJson(json);
    } catch (e) {
      Logger().e("Capabilities exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$CapabilitiesToJson(this);
}

@JsonSerializable()
class LastKnownOperator {
  LastKnownOperator({this.name, this.id});

  String name;
  String id;

  factory LastKnownOperator.fromJson(Map<String, dynamic> json) {
    try {
      return _$LastKnownOperatorFromJson(json);
    } catch (e) {
      Logger().e("Capabilities exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$LastKnownOperatorToJson(this);
}

@JsonSerializable()
class Link {
  Link({
    this.rel,
    this.href,
  });

  String rel;
  String href;

  factory Link.fromJson(Map<String, dynamic> json) {
    try {
      return _$LinkFromJson(json);
    } catch (e) {
      Logger().e("Link exception");
      Logger().e(e);
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
