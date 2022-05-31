import 'package:json_annotation/json_annotation.dart';
part 'maintenance_asset_india_stack.g.dart';

@JsonSerializable()
class MaintenanceAssetList {
  String? status;
  List<AssetMaintenanceList>? assetMaintenanceList;
  int? count;

  MaintenanceAssetList({this.status, this.assetMaintenanceList, this.count});

  factory MaintenanceAssetList.fromJson(Map<String, dynamic> json) {
    return _$MaintenanceAssetListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MaintenanceAssetListToJson(this);
}

@JsonSerializable()
class AssetMaintenanceList {
  int? count;
  int? customerAssetID;
  String? assetId;
  String? assetName;
  String? serialNumber;
  String? make;
  String? model;
  int? currentHourMeter;
  String? servicedescription;
  String? serviceStatusName;
  String? serviceName;
  List<MaintenanceTotals>? maintenanceTotals;

  AssetMaintenanceList(
      {this.count,
      this.customerAssetID,
      this.assetId,
      this.assetName,
      this.serialNumber,
      this.make,
      this.model,
      this.currentHourMeter,
      this.servicedescription,
      this.serviceStatusName,
      this.serviceName,
      this.maintenanceTotals});

  factory AssetMaintenanceList.fromJson(Map<String, dynamic> json) {
    return _$AssetMaintenanceListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssetMaintenanceListToJson(this);
}

@JsonSerializable()
class MaintenanceTotals {
  int? count;
  String? name;
  String? alias;

  MaintenanceTotals({this.count, this.name, this.alias});

  factory MaintenanceTotals.fromJson(Map<String, dynamic> json) {
    return _$MaintenanceTotalsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MaintenanceTotalsToJson(this);
}
