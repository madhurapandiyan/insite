// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_checkList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceCheckListModel _$MaintenanceCheckListModelFromJson(
        Map<String, dynamic> json) =>
    MaintenanceCheckListModel(
      maintenanceCheckList: (json['maintenanceCheckList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      maintenanceServiceList: (json['maintenanceServiceList'] as List<dynamic>?)
          ?.map(
              (e) => MaintenanceServiceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      dueInOverdueBy: json['dueInOverdueBy'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
    );

Map<String, dynamic> _$MaintenanceCheckListModelToJson(
    MaintenanceCheckListModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('serviceStatus', instance.serviceStatus);
  writeNotNull('dueInOverdueBy', instance.dueInOverdueBy);
  writeNotNull('maintenanceCheckList',
      instance.maintenanceCheckList?.map((e) => e.toJson()).toList());
  writeNotNull('maintenanceServiceList',
      instance.maintenanceServiceList?.map((e) => e.toJson()).toList());
  return val;
}

MaintenanceCheckListModelPop _$MaintenanceCheckListModelPopFromJson(
        Map<String, dynamic> json) =>
    MaintenanceCheckListModelPop(
      maintenanceCheckList: (json['maintenanceCheckList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListDataPop.fromJson(e as Map<String, dynamic>))
          .toList(),
      maintenanceServiceList: (json['maintenanceServiceList'] as List<dynamic>?)
          ?.map(
              (e) => MaintenanceServiceList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      dueInOverdueBy: json['dueInOverdueBy'] as String?,
      serviceStatus: json['serviceStatus'] as String?,
    );

Map<String, dynamic> _$MaintenanceCheckListModelPopToJson(
    MaintenanceCheckListModelPop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('serviceStatus', instance.serviceStatus);
  writeNotNull('dueInOverdueBy', instance.dueInOverdueBy);
  writeNotNull('maintenanceCheckList',
      instance.maintenanceCheckList?.map((e) => e.toJson()).toList());
  writeNotNull('maintenanceServiceList',
      instance.maintenanceServiceList?.map((e) => e.toJson()).toList());
  return val;
}

MaitenanceCheckListData _$MaitenanceCheckListDataFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListData(
      checkListID: json['checkListID'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkListDescription: json['checkListDescription'] as String?,
    );

Map<String, dynamic> _$MaitenanceCheckListDataToJson(
    MaitenanceCheckListData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('checkListName', instance.checkListName);
  writeNotNull('checkListID', instance.checkListID);
  writeNotNull('isChecked', instance.isChecked);
  writeNotNull('partList', instance.partList?.map((e) => e.toJson()).toList());
  writeNotNull('checkListDescription', instance.checkListDescription);
  return val;
}

MaitenanceCheckListDataPop _$MaitenanceCheckListDataPopFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListDataPop(
      checkListID: json['checkListID'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListDataPop.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkListDescription: json['checkListDescription'] as String?,
    );

Map<String, dynamic> _$MaitenanceCheckListDataPopToJson(
    MaitenanceCheckListDataPop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('checkListName', instance.checkListName);
  writeNotNull('checkListID', instance.checkListID);
  writeNotNull('isChecked', instance.isChecked);
  writeNotNull('partList', instance.partList?.map((e) => e.toJson()).toList());
  writeNotNull('checkListDescription', instance.checkListDescription);
  return val;
}

MaintenanceServiceList _$MaintenanceServiceListFromJson(
        Map<String, dynamic> json) =>
    MaintenanceServiceList(
      serviceId: json['serviceId'] as int?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$MaintenanceServiceListToJson(
    MaintenanceServiceList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('serviceName', instance.serviceName);
  writeNotNull('serviceId', instance.serviceId);
  return val;
}

PartListData _$PartListDataFromJson(Map<String, dynamic> json) => PartListData(
      description: json['description'] as String?,
      partName: json['partName'] as String?,
      partId: json['partId'] as int?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as num?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataToJson(PartListData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('partName', instance.partName);
  writeNotNull('partNo', instance.partNo);
  writeNotNull('description', instance.description);
  writeNotNull('units', instance.units);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('partId', instance.partId);
  return val;
}

PartListDataPop _$PartListDataPopFromJson(Map<String, dynamic> json) =>
    PartListDataPop(
      description: json['description'] as String?,
      name: json['name'] as String?,
      partId: json['partId'] as int?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as num?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataPopToJson(PartListDataPop instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('partNo', instance.partNo);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('partId', instance.partId);
  writeNotNull('description', instance.description);
  writeNotNull('units', instance.units);
  return val;
}

MaintenanceIntervals _$MaintenanceIntervalsFromJson(
        Map<String, dynamic> json) =>
    MaintenanceIntervals(
      intervalList: (json['intervalList'] as List<dynamic>?)
          ?.map((e) => IntervalList.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      totalCount: json['totalCount'] as int?,
    );

Map<String, dynamic> _$MaintenanceIntervalsToJson(
    MaintenanceIntervals instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('totalCount', instance.totalCount);
  writeNotNull(
      'intervalList', instance.intervalList?.map((e) => e.toJson()).toList());
  return val;
}

IntervalList _$IntervalListFromJson(Map<String, dynamic> json) => IntervalList(
      checkList: (json['checkList'] as List<dynamic>?)
          ?.map((e) =>
              MaitenanceCheckListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      editable: json['editable'] as bool?,
      firstOccurrences: json['firstOccurrences'] as int?,
      intervalDescription: json['intervalDescription'] as String?,
      intervalID: json['intervalID'] as int?,
      intervalName: json['intervalName'] as String?,
    );

Map<String, dynamic> _$IntervalListToJson(IntervalList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('intervalID', instance.intervalID);
  writeNotNull('intervalName', instance.intervalName);
  writeNotNull('firstOccurrences', instance.firstOccurrences);
  writeNotNull('intervalDescription', instance.intervalDescription);
  writeNotNull('editable', instance.editable);
  writeNotNull(
      'checkList', instance.checkList?.map((e) => e.toJson()).toList());
  return val;
}

AddMaintenanceIntervalPayload _$AddMaintenanceIntervalPayloadFromJson(
        Map<String, dynamic> json) =>
    AddMaintenanceIntervalPayload(
      assetId: json['assetId'] as String?,
      checklist: (json['checklist'] as List<dynamic>?)
          ?.map((e) => MaitenanceCheckListDataPayLoad.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      currentHourMeter: (json['currentHourMeter'] as num?)?.toDouble(),
      description: json['description'] as String?,
      initialOccurence: json['initialOccurence'] as int?,
      intervalName: json['intervalName'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      serialNumber: json['serialNumber'] as String?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$AddMaintenanceIntervalPayloadToJson(
    AddMaintenanceIntervalPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('intervalName', instance.intervalName);
  writeNotNull('initialOccurence', instance.initialOccurence);
  writeNotNull('description', instance.description);
  writeNotNull(
      'checklist', instance.checklist?.map((e) => e.toJson()).toList());
  writeNotNull('assetId', instance.assetId);
  writeNotNull('serialNumber', instance.serialNumber);
  writeNotNull('make', instance.make);
  writeNotNull('model', instance.model);
  writeNotNull('currentHourMeter', instance.currentHourMeter);
  writeNotNull('units', instance.units);
  return val;
}

PartListDataPayLoad _$PartListDataPayLoadFromJson(Map<String, dynamic> json) =>
    PartListDataPayLoad(
      partName: json['partName'] as String?,
      partNo: json['partNo'] as String?,
      quantity: json['quantity'] as int?,
      units: json['units'] as String?,
    );

Map<String, dynamic> _$PartListDataPayLoadToJson(PartListDataPayLoad instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('partName', instance.partName);
  writeNotNull('partNo', instance.partNo);
  writeNotNull('units', instance.units);
  writeNotNull('quantity', instance.quantity);
  return val;
}

MaitenanceCheckListDataPayLoad _$MaitenanceCheckListDataPayLoadFromJson(
        Map<String, dynamic> json) =>
    MaitenanceCheckListDataPayLoad(
      checkListID: json['checkListID'] as int?,
      checkListName: json['checkListName'] as String?,
      isChecked: json['isChecked'] as bool?,
      partList: (json['partList'] as List<dynamic>?)
          ?.map((e) => PartListDataPayLoad.fromJson(e as Map<String, dynamic>))
          .toList(),
      checkListDescription: json['checkListDescription'] as String?,
    );

Map<String, dynamic> _$MaitenanceCheckListDataPayLoadToJson(
    MaitenanceCheckListDataPayLoad instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('checkListName', instance.checkListName);
  writeNotNull('checkListID', instance.checkListID);
  writeNotNull('isChecked', instance.isChecked);
  writeNotNull('partList', instance.partList?.map((e) => e.toJson()).toList());
  writeNotNull('checkListDescription', instance.checkListDescription);
  return val;
}
