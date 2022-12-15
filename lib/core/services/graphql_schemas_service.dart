import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/base_service.dart';

import 'package:insite/core/models/estimated_asset_setting.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/maintenance_checkList.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/add_intervals/add_intervals_view_model.dart';
import 'package:insite/views/plant/plant_asset_creation/asset_creation_model.dart';
import 'package:insite/views/subscription/sms-management/model/delete_sms_management_schedule.dart';
import 'package:logger/logger.dart';

import '../logger.dart';
import '../models/add_asset_registration.dart';
import '../models/add_notification_payload.dart';

class GraphqlSchemaService extends BaseService {
  GraphqlSchemaService._internal() {
    this.log = getLogger(this.runtimeType.toString());
  }
  static final GraphqlSchemaService _singleton =
      GraphqlSchemaService._internal();

  factory GraphqlSchemaService() => _singleton;
  String? productFamily;
  String? make;
  String? model;
  String? assetStatus;
  String? fuelLevelPercentLt;
  String? idleEficiencyGT;
  String? idleEfficiencyLTE;
  String? assetIDContains;
  String? snContains;
  String? location;
  String? deviceType;
  String? manufacturer;
  String? severity;
  String? faultTypeList;
  double? latitude;
  double? longitude;
  double? radiusKms;

  List<String> modelList = [];
  List<String> manufacturerList = [];
  List<String> assetstatusList = [];
  List<String> deviceTypeList = [];
  List<String> idleEfficiencyList = [];
  List<String> fuelLevelList = [];
  List<String> productfamilyList = [];
  List<String> locationList = [];
  List<int> reportFrequency = [];
  List<int> reportFormat = [];
  List<int> reportType = [];
  List<String> severityList = [];
  List<String> serviceStatusList = [];
  List<String> serviceTypeList = [];
  List<String> assetTypeList = [];
  String doubleQuote = "\"";

  getReportFilterindividualList(
      {List<FilterData?>? filtlerList,
      FilterType? type,
      List? individualList}) {
    var data = filtlerList!.where((element) => element?.type == type).toList();
    data.forEach((element) {
      if (assetstatusList.contains(element)) {
      } else {
        individualList!.add(int.parse(element!.id!));
      }
    });
  }

  getReportFilterData(
    List<FilterData?>? filtlerList,
  ) {
    getReportFilterindividualList(
        filtlerList: filtlerList,
        individualList: reportFrequency,
        type: FilterType.FREQUENCYTYPE);
    getReportFilterindividualList(
        filtlerList: filtlerList,
        individualList: reportFormat,
        type: FilterType.REPORT_FORMAT);
    getReportFilterindividualList(
        filtlerList: filtlerList,
        individualList: reportType,
        type: FilterType.REPORT_TYPE);
  }

  getIndividualList(
      {List<FilterData?>? filtlerList,
      FilterType? type,
      List<String>? individualList}) {
    var data = filtlerList!.where((element) => element?.type == type).toList();
    data.forEach((element) {
      // Logger().w(element?.toJson());
      if (individualList!.contains(element)) {
      } else {
        individualList.add(doubleQuote + element!.title! + doubleQuote);
      }
    });
  }

  clearAllList() {
    modelList.clear();
    manufacturerList.clear();
    assetstatusList.clear();
    deviceTypeList.clear();
    idleEfficiencyList.clear();
    fuelLevelList.clear();
    productfamilyList.clear();
    locationList.clear();
    reportFrequency.clear();
    reportFormat.clear();
    reportType.clear();
    severityList.clear();
    serviceStatusList.clear();
    serviceStatusList.clear();
    serviceTypeList.clear();
    assetTypeList.clear();
  }

  cleaValue() {
    productFamily = null;
    model = null;
    assetStatus = null;
    fuelLevelPercentLt = null;
    idleEficiencyGT = null;
    idleEfficiencyLTE = null;
    assetIDContains = null;
    snContains = null;
    location = null;
    deviceType = null;
    make = null;
    manufacturer = null;
    severity = null;
    faultTypeList = null;
    latitude = null;
    longitude = null;
    radiusKms = null;
  }

  Future gettingLocationFilter(List<FilterData?>? filtlerList) async {
    try {
      String doubleQuote = "\"";
      if (filtlerList != null && filtlerList.isNotEmpty) {
        getIndividualList(
            filtlerList: filtlerList,
            individualList: assetstatusList,
            type: FilterType.ASSET_STATUS);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: assetstatusList,
            type: FilterType.ALL_ASSETS);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: productfamilyList,
            type: FilterType.PRODUCT_FAMILY);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: modelList,
            type: FilterType.MODEL);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: manufacturerList,
            type: FilterType.MANUFACTURER);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: deviceTypeList,
            type: FilterType.DEVICE_TYPE);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: fuelLevelList,
            type: FilterType.FUEL_LEVEL);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: locationList,
            type: FilterType.LOCATION_SEARCH);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: idleEfficiencyList,
            type: FilterType.IDLING_LEVEL);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: severityList,
            type: FilterType.SEVERITY);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: serviceStatusList,
            type: FilterType.SERVICE_STATUS);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: serviceTypeList,
            type: FilterType.SERVICE_TYPE);
        getIndividualList(
            filtlerList: filtlerList,
            individualList: assetTypeList,
            type: FilterType.ASSET_TYPE);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future gettingFiltersValue(List<FilterData?>? filtlerList) async {
    try {
      if (filtlerList != null && filtlerList.isNotEmpty) {
        filtlerList.forEach((filterData) {
          if (filterData?.type == FilterType.ALL_ASSETS) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.ALL_ASSETS)
                .toList();
            assetStatus = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("assetStatus $assetStatus");
          } else if (filterData?.type == FilterType.PRODUCT_FAMILY) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.PRODUCT_FAMILY)
                .toList();
            productFamily = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("productFamily $productFamily");
          } else if (filterData?.type == FilterType.MODEL) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.MODEL)
                .toList();
            model = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("model $model");
          } else if (filterData?.type == FilterType.FUEL_LEVEL) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.FUEL_LEVEL)
                .toList();
            fuelLevelPercentLt = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("fuelLevelPercentLt $fuelLevelPercentLt");
          } else if (filterData?.type == FilterType.MAKE) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.MAKE)
                .toList();
            make = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("make $make");
          } else if (filterData?.type == FilterType.DEVICE_TYPE) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.DEVICE_TYPE)
                .toList();
            deviceType = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("deviceType $deviceType");
          } else if (filterData?.type == FilterType.IDLING_LEVEL) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.IDLING_LEVEL)
                .toList();
            idleEficiencyGT = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("idleEficiencyGT $idleEficiencyGT");
          } else if (filterData?.type == FilterType.LOCATION_SEARCH) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.LOCATION_SEARCH)
                .toList();
            location = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("locations $location");
          } else if (filterData?.type == FilterType.MANUFACTURER) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.MANUFACTURER)
                .toList();
            manufacturer = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("manucaturer $manufacturer");
          } else if (filterData?.type == FilterType.SEVERITY) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.SEVERITY)
                .toList();
            severity = Utils.getFilterData(data, filterData!.type!);
            Logger().wtf("severity $severity");
          } else if (filterData?.type == FilterType.CLUSTOR) {
            var data = filtlerList
                .where((element) => element?.type == FilterType.CLUSTOR)
                .toList();
            latitude = double.parse(data.last!.extras![0]!);
            longitude = double.parse(data.last!.extras![1]!);
            radiusKms = double.parse(data.last!.extras![2]!);
          }
        });
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  final String allAssets = """
query faultDataSummary{
 getDashboardAsset{
  countData{  
    count
    countOf
  }
}
 }
""";

getModelFleetList(){
  var data="""{
  frameSubscription {
    plantDispatchSummary {
      modelFleetList {
        ModelCount
        ModelName
        __typename
      }
      __typename
    }
    __typename
  }
}
""";
return data;
}
  getSubscriptionDashboardResult() {
    var data = """query{
  frameSubscription{
    plantDispatchSummary {
      activeSubscription
      yetToBeActivated
      totalDevicesSupplied
      plantAssetCount
      subscriptionEnded
      assetActivationByDay
      assetActivationByWeek
      assetActivationByMonth
      modelFleetList {
        ModelCount
        ModelName
      }
    }
  }
}



""";
    return data;
  }

  getUserManagementRefine(String filter) {
    var data = """
query{
  userManagementRefine(FilterName:"$filter"){
    countData{
      id,
      name,
      count
    }
  }
}""";
    return data;
  }

  getReplacementHistoryCount({int? start, int? limit, bool? count}) {
    var data = """query{
  replacementHistory(start:$start,limit:$limit,sortColumn:"",sortMethod:"", count:$count) {
  count 
__typename
  }
  }""";
    return data;
  }

  getReplacementDetails({int? start, int? limit}) {
    var data = """query{
  replacementHistory(start:$start,limit:$limit) {
    oldDeviceId
    newDeviceId
    reason
    vin
    insertUTC
    emailID
    firstName
    lastName
    state
    description
    __typename
  }
  }
""";
    return data;
  }

 

  register() {
    var data = """ mutation deviceProvisionTransfer(\$id: Int!, \$gnacc: String!, \$request: AssetOperationInput!) {
  assetOperation(id: \$id, gnacc: \$gnacc, request: \$request) {
    code
    status
    requestID
    __typename
  }
}

""";
Logger().wtf("data:$data");
    return data;
  }

  getModelNameBySerialNumber(String? serialNumber) {
    var data = """  query {
 assetModelByMachineSerialNumber(machineSerialNumber:"$serialNumber") {
   startsWith
   startRange
   endRange
   groupClusterId
   modelName
 }
 
}""";
    return data;
  }

  getDeviceIdReplacement() {
    var data = """
query SubscriptionFleetList(\$status: String, \$model: String, \$start: Int, \$limit: Int, \$search: FleetSearch) {
  frameSubscription {
    subscriptionFleetList(status: \$status, model: \$model, start: \$start, limit: \$limit, search: \$search) {
      count
      provisioningInfo {
        vin
        gpsDeviceID
        model
        subscriptionStartDate
        __typename
      }
      __typename
    }
    __typename
  }
}

""";
    return data;
  }

  getSubscriptionFleetData(int? start, int? limit) {
    var data = """
query {
 fleetProvisionStatus(start:$start,limit:$limit) {
  count, 
  fleetProvisionStatusInfo {  
    gpsDeviceID,     
    vin,    
    model,     
    oemName,     
    subscriptionStartDate,      
    actualStartDate,     
    subscriptionEndDate,      
    productFamily,      
    customerName,      
    customerCode,      
    dealerName,     
    dealerCode,     
    commissioningDate,     
    secondaryIndustry,      
    primaryIndustry,      
    networkProvider,     
    status,      
    description,     
    __typename    
  }
  }
 }
""";
    return data;
  }

  getDeviceCodeAndName(
      {int? start, int? limit, String? type, String? name, String? code}) {
    var data = """
query {
assetOrHierarchyByTypeAndId( start:$start,limit:$limit,type:$type,name:"$name",code:"$code") {
  
  name
  userName
  email
  code
} 
 

 
}
""";
    return data;
  }

  getDetailResultData(String? status, int? start, int? limit, String? name) {
    var data = """ 
    query {
        frameSubscription {
        subscriptionFleetList(status: "$status", model: "", start: $start, limit: $limit, search: {gpsDeviceID: "$name"}) {
      
      provisioningInfo {
        vin
        gpsDeviceID
        model
       
        subscriptionStartDate
      
      }
     }
    }
    }

""";

    return data;
  }

  deleteSms(int? userId, List<DeleteSmsReport> reportId) {
    var data = """mutation  {
   deleteSMS(UserID: $userId, request: ${Utils.getDeleteSmsData(reportId)}) {
     fieldCount
     affectedRows
     insertId
     serverStatus
     warningCount
     message
     protocol41
     changedRows
   }
 }""";
    return data;
  }

  getSmsReportSummary(int? start, int? limit) {
    var data = """query {
   getSMSSummaryReport(start: $start, limit: $limit) {
     result
{
gpsDeviceId
          id
             language
             name
            number
             serialNumber
             startDate
         }
        count
   }
 
 }""";
    return data;
  }

  getTransferHistoryCount({int? start, int? limit}) {
    var data = """
query{
  deviceTransferCount(start:$start,limit:$limit){
    count,
    
    
  }
}""";
    return data;
  }

  getTranferHistory(int? start, int? limit) {
    var data = """query{
  deviceTransfer(start:$start,limit:$limit){
    destinationCustomerType,
    destinationName1,
    destinationName2,
    gpsDeviceID,
    insertUTC,
    oemName,
    sourceCustomerType,
    sourceName1,
    sourceName2,
    status,
    fk_AssetId,
    vin
    __typename
    
  }
}""";
    return data;
  }

  getDeviceTransferDetails({String? searchKey, String? searchValue}) {
    var data = """
query{
singleFleetDetails(searchKey:"$searchKey",
    searchValue: "$searchValue",
    oem: "VEhD") {
  vin
  gpsDeviceID
  model
  oemName
  subscriptionStartDate
  actualStartDate
  subscriptionEndDate
  productFamily
  customerName
  customerCode
  dealerName
  dealerCode
  commissioningDate
  secondaryIndustry
  primaryIndustry
  networkProvider
  status
  description
}
}
 
""";
    return data;
  }

  getDealerToDealerTransfer({String? searchValue}) {
    var data = """query  {
  dealerToDealerTransfer(oem:"THC", searchValue: "$searchValue") {
    vin
    gpsDeviceID
    commissioningDate
    customerDetails {
      name
      code
      email
      __typename
    }
    dealerDetails {
      name
      code
      email
      __typename
    }
    secondaryIndustry
    primaryIndustry
    __typename
  }
}
""";
    return data;
  }

  getDeviceIdTransfer(
      {int? limit,
      String? oem,
      String? searchkey,
      String? searchValue,
      int? start,
      String? userId}) {
    String data = """
query{
  hierarchyFleetSearch(limit: $limit,
oem: "$oem",
searchKey: "$searchkey",
searchValue: "$searchValue",
start: $start,
userUID: "$userId") {
    vin
    gpsDeviceID
    __typename
  }
}
 
""";
    return data;
  }

  String getAssetCount(
      {String? grouping,
      String? productFamily,
      String? threshold,
      String? endDate,
      String? startDate,
      String? idleEfficiencyRanges}) {
    final String assetStatusCount = """
query{
  getDashboardAsset(
    grouping: "${grouping == null ? "" : "$grouping"}",
    productfamily:"${productFamily == null ? "" : productFamily}",
    thresholds:"${threshold == null ? "" : threshold}",
    endDate:"${endDate == null ? "" : endDate}",
    idleEfficiencyRanges:"${idleEfficiencyRanges == null ? "" : idleEfficiencyRanges}",
    startDate:"${startDate == null ? "" : startDate}"
  ) {
    countData {
      countOf
      count
    }
  }
}
""";
    return assetStatusCount;
  }

  final String fuelLevelCount = """
query faultDataSummary{
 getDashboardAsset(grouping: "fuellevel", thresholds: "25-50-75-100"){
  countData{  
    count
    countOf
  }
}
  
}
  """;
  Future<String?> getfaultQueryString({
    String? startDate,
    String? endDate,
    List<FilterData?>? applyFilter,
    int? pageNo,
    int? limit,
  }) async {
    await clearAllList();
    await cleaValue();
    await gettingFiltersValue(applyFilter);
    await gettingLocationFilter(applyFilter);
    final String faultQueryString = """
{
  faultdata(
    page:$pageNo,
    limit:$limit
startDateTime:"$startDate"
endDateTime:"$endDate",
severityList:${severity == null ? "\"\"" : "${"\"" + severity! + "\""}"}
faultTypeList: ${faultTypeList == null ? "\"\"" : "${"\"" + faultTypeList! + "\""}"}
productFamilyList:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}
manufacturerList:${manufacturerList.isEmpty ? [] : manufacturerList}
modelList:${model == null ? "\"\"" : "${"\"" + model! + "\""}"}
deviceTypeList: ${deviceTypeList.isEmpty ? [] : deviceTypeList}
assetStatusList:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}

fuelLevelPercentLTE: ${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}
  ) {
    faults {
      asset {
        uid
        basic {
          assetId
          serialNumber
        }
        details {
          makeCode
          model
          productFamily
          assetIcon
          devices {
            deviceType
            firmwareVersion
          }
          dealerCode
          dealerCustomerName
          dealerName
          universalCustomerName
        }
        dynamic {
          status
          locationLatitude
          locationLongitude
          location
          hourMeter
          odometer
          locationReportedTimeUTC
        }
      }
      faultUid
      basic {
        faultIdentifiers
        description
        severityLabel
        severity
        faultType
        source
        faultOccuredUTC
        sourceIdentifierCode
        isResponseReceived
        esn
        externalFaultId
        faultClosureUTC
        isFaultActive
        priority
      }
      details {
        faultCode
        faultReceivedUTC
        dataLinkType
        occurrences
        url
      }
    }
    page
    limit
    total
    pageLinks {
      rel
      href
      method
    }
  }
}

  """;

    return faultQueryString;
  }

  getAssetFaultQuery({
    String? startDate,
    String? endDate,
    int? pageNo,
    int? limit,
    List<FilterData?>? filtlerList,
  }) async {
    await cleaValue();
    await clearAllList();
    await gettingLocationFilter(filtlerList);
    final String assetFaultQuery = """
query{
assetData(
  severityList: ${severityList.isEmpty ? [] : severityList}
faultTypeList: []
productFamilyList: ${productfamilyList.isEmpty ? [] : productfamilyList}
manufacturerList:${manufacturerList.isEmpty ? [] : manufacturerList}
modelList:${modelList.isEmpty ? [] : modelList}
deviceTypeList: ${deviceTypeList.isEmpty ? [] : deviceTypeList}
assetStatusList: ${assetstatusList.isEmpty ? [] : assetstatusList}
fuelLevelPercentLT: ""
fuelLevelPercentLTE: ${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}
startDateTime: "$startDate"
endDateTime: "$endDate"
page: $pageNo
limit:$limit
assetUid: []
){
 
  assetFaults{
    asset{
      uid,
      basic{
        assetId,
        serialNumber
      }
     details{
          makeCode
model
productFamily
assetIcon
devices{
  deviceType,
  firmwareVersion
}
dealerCode
dealerCustomerName
dealerName
universalCustomerName
        }
      dynamic{
          status
locationLatitude
locationLongitude
location
hourMeter
odometer
locationReportedTimeUTC
        }
    },
    countData{
      countOf,
      count
    }
  },
   page,
  limit,
  total,
  status,
  reqId,
  mst,
  pageLinks{
    method
  }
}
}""";
    return assetFaultQuery;
  }

  fleetSummary(List<FilterData?>? applyFilter, pagenumber, startDate, endDate,
      int pageSize) async {
    await cleaValue();
    await clearAllList();
    await gettingFiltersValue(applyFilter);

    var data = """{
  fleetSummary(pageNumber:$pagenumber,
    pageSize:$pageSize,
    startDateLocal:${startDate == null ? "\"\"" : "${"\"" + startDate + "\""}"}
    endDateLocal: ${endDate == null ? "\"\"" : "${"\"" + endDate + "\""}"}
    sort:"AssetSerialNumber",
    productfamily:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"},
    model:${model == null ? "\"\"" : "${"\"" + model! + "\""}"},
    assetstatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"},
    fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"},
    idleEfficiencyGT:${idleEficiencyGT == null ? null : int.parse(Utils.getIdlingFilterData(idleEficiencyGT)!.first!)},
    idleEfficiencyLTE:${idleEficiencyGT == null ? null : int.parse(Utils.getIdlingFilterData(idleEficiencyGT)!.last!)},
    assetIDContains:"",
    latitude:$latitude,
    longitude:$longitude,
    radiuskm:$radiusKms
    snContains:"",
  manufacturer:${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"},
    location:"") {
    fleetRecords {
      assetIdentifier
      assetSerialNumber
      manufacturer
      makeCode
      model
      assetIcon
      productFamily
      status
      lastReportedLocation
      lastPercentDEFRemainingUTC
      lastReportedUTC
      lastReportedTime
      assetId
      modelYear
      dealerCustomerNumber
      dealerCode
      dealerName
      fuelLevelLastReported
      lastReportedLocationLatitude
      universalCustomerIdentifier
      universalCustomerName
      hourMeter
      lifetimeFuelLiters
      lastLocationUpdateUTC
      lastPercentFuelRemainingTime
      percentDEFRemaining
      lastPercentDEFRemainingTime
      fuelReportedTime
      lastPercentFuelRemainingUTC
      odometer
      geofences{
        fenceIdentifier,
        name,
        areaSqM
      }
      devices {
        deviceType
        isGpsRollOverAffected
        mainboardSoftwareVersion
      }
    }
        pagination{
      totalAsset,
      totalCount,
      assetsWithoutActiveCoreSubscription,
      pageNumber,
       pageSize
    },
    links{
      prev,
      next,
      self
    }
  }
}
""";

    return data;
  }

  final String dashBoardUtilizationSummary = """
  query dashboardUtilizationSummary{
  getDashboardUtilizationSummary{
    totalDay {
      idleHours
      runtimeHours
      workingHours
    }
    totalWeek {
      idleHours
      runtimeHours
      workingHours
    }
    totalMonth {
      idleHours
      runtimeHours
      workingHours
    }
    averageDay {
      idleHours
      runtimeHours
      workingHours
    }
    averageWeek {
      idleHours
      runtimeHours
      workingHours
    }
    averageMonth {
      idleHours
      runtimeHours
      workingHours
    }
  }
    
  
} 
  """;
  utilizationToatlCount(
      String startDate, String endDate, List<FilterData?>? applyFilter) async {
    await cleaValue();
    await gettingFiltersValue(applyFilter);
    final String utilizationTotalCount = """
{
  utilizationTotal(
    productfamily: ${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}, 
  model:${model == null ? "\"\"" : "${"\"" + model! + "\""}"}, 
  manufacturer:${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"}, 
  assetstatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}, 
  fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + Utils.fuelFilterQuery(fuelLevelPercentLt) + "\""}"}, 

  idleEfficiencyRanges: ${idleEficiencyGT == null ? "\"\"" : "${"\"" + idleEficiencyGT! + "\""}"}, 
  startDate: "$startDate", 
  EndDate: "$endDate") {
    countData {
      countOf
      count
      referenceColumns
    }
  }
}
""";
    return utilizationTotalCount;
  }

  getAssetOperationData({
    String? startDate,
    List<FilterData?>? appliedFilter,
    String? endDate,
    int? pageSize,
    int? pageNo,
    String? assetId,
  }) async {
    await gettingFiltersValue(appliedFilter);
    final String assetOperationData = """
 query asetOperations{
  assetOperationsDailyTotals(
   pageNumber: $pageNo,
pageSize: $pageSize,
sort: "-assetid",
startDate:"$startDate",
endDate: "$endDate",
productfamily: ${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"},
model: ${model == null ? "\"\"" : "${"\"" + model! + "\""}"},
manufacturer: ${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"},
assetstatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"},
idleEfficiencyGT:"${Utils.getIdlingFilterData(idleEficiencyGT)?.first ?? ""}",
idleEfficiencyLTE: "${Utils.getIdlingFilterData(idleEficiencyGT)?.last ?? ""}",
fuelLevelPercentLT: ${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"},
    ){
    assetOperations{
      links {
        rel
        href
      }
      pagination {
        totalAssets
        assetsWithoutActiveCoreSubscription
        pageNumber
        pageSize
      }
      assets {
        assetUid
        assetId
        assetIcon {
        key
      }
        makeCode
        model
        serialNumber
        productFamily
        customStateDescription
        distanceTravelledKilometers
        dateRangeRuntimeDuration
        lastKnownOperator
        esn
        assetLastReceivedEvent {
          lastReceivedEvent
          lastReceivedEventTimeLocal
          lastReceivedEventUTC
          timezoneAbbrev
          segmentType
        }
        assetLocalDates {
          assetLocalDate
          totalRuntimeDurationSeconds
        }
      }
    }
  }
}
""";
    return assetOperationData;
  }

  String getFaultCountData(
      {String? startDate, String? endDate, String? prodFamily}) {
    final String faultCountData = """
  query getFaultCountData{
faultCountData(startDateTime:"${startDate == null ? "" : startDate}", endDateTime: "${endDate == null ? "" : endDate}",productFamily:"${prodFamily == null ? "" : prodFamily}"){
  countData {
    countOf
    assetCount
    faultCount
  }
}
}
  """;
    return faultCountData;
  }

  String userManagementUserList(
      {String? searchKey,
      int? userType,
      int? jobType,
      String? email,
      int? pageNo}) {
    return """{
  userManagementUserList(pageNumber: $pageNo, sort: "", searchKey: "$searchKey", userType: $userType, jobType: $jobType, EmailID: "${email == null ? "" : email}") {
    users {
      invitationUID
      first_name
      last_name
      user_type
      loginId
      job_type
      job_title
      userUid
      lastLoginDate
      createdOn
      createdBy
      emailVerified
      application_access {
        userUID
        role_name
        applicationIconUrl
        applicationName
      }
    }
    total {
      items
      pages
    }
    links {
      next
      last
    }
  }
}
""";
  }

  String deleteUser(List<String> usersId, String customerId) {
    var deleteString = """mutation userManagementDeleteUser{
  userManagementDeleteUser(deleteUser: {
  users: ${Utils.getStringListData(usersId)},
     customerUid:"$customerId"
  }){
     isDeleted
   }
 }""";
    print(deleteString);
    return deleteString;
  }

  String checkUserMailId(String emailId) {
    var checkUserMail = """query{
userEmail(EmailID:"$emailId"){
  users{
    userUid
}
}
}""";
    return checkUserMail;
  }

  getFleetUtilization(
      {String? startDate,
      String? endDate,
      int? pageSize,
      int? pageNo,
      List<FilterData?>? applyFilter,
      String? sort}) async {
    await cleaValue();
    await gettingFiltersValue(applyFilter);
    final String fleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageNumber: $pageNo, 
  pageSize: $pageSize , 
  sort: ${sort == null ? "\"\"" : "${"\"" + sort + "\""}"}, 
  startDate: "$startDate", 
  endDate: "$endDate", 
  idleEfficiencyGT: "${Utils.getIdlingFilterData(idleEficiencyGT)?.first ?? ""}", 
  fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}, 
  idleEfficiencyLTE: "${Utils.getIdlingFilterData(idleEficiencyGT)?.last ?? ""}", 
  productfamily:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}, 
  model:${model == null ? "\"\"" : "${"\"" + model! + "\""}"}, 
  manufacturer: ${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"}, 
  assetstatus: ${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}){
    assetResults {
      assetIdentifierSQLUID
      assetIcon
      assetIdentifier
      assetSerialNumber
      date
      assetId
      distanceTravelledKilometers
      idleEfficiency
      idleFuelConsumedLiters
      idleFuelConsumptionRate
      idleHours
      kmsPerRuntimeFuelConsumedLiter
      lastIdleFuelConsumptionLitersMeter
      lastIdleHourMeter
      lastOdometerMeter
      lastReportedTime
      lastReportedTimeZoneAbbrev
      lastRuntimeFuelConsumptionLitersMeter
      lastRuntimeHourMeter
      makeCode
      message
      model
      manufacturer
      currentHourMeter
      runtimeFuelConsumedLiters
      runtimeFuelConsumptionRate
      runtimeHours
      supportsIdle
      targetIdle
      targetIdlePerformance
      targetRuntime
      targetRuntimePerformance
      workDefinitionType
      workingEfficiency
      workingFuelConsumedLiters
      workingFuelConsumptionRate
      workingHours
      lastReportedLocationLatitude
      lastReportedLocationLongitude
      lastReportedLocation
      esn
    }
      
    
    totals {
      distanceTravelledKilometersSum
      runtimeHoursSum
      idleHoursSum
      workingHoursSum
      targetRuntime
      targetIdle
      runtimeFuelConsumedLitersSum
      idleFuelConsumedLitersSum
      workingFuelConsumedLitersSum
      runtimePerformance
      idlePerformance
      idlePercent
      workingPercent
      runtimeBurnRate
      idleBurnRate
      workingBurnRate
      kmsPerRuntimeFuelConsumedLiter
      runtimeHoursAverage
      runtimeFuelConsumedLitersAverage
      idleHoursAverage
      idleFuelConsumedLitersAverage
      workingHoursAverage
      workingFuelConsumedLitersAverage
      distanceTravelledKilometersAverage
    }
    code
    message
  }
}
  """;

    return fleetUtilization;
  }

  String addUser() {
    final String addUserData =
        """mutation userManagementCreateUser(\$requestBody: createUserBody!, \$userUId: String){
   userManagementCreateUser(requestBody: \$requestBody, userUId: \$userUId){
    invitation_id,
    count,
    isInvitationSent,
    isUpdated
  }
}
""";
    print(addUserData);
    return addUserData;
  }

  editUser() {
    var data = """
mutation userManagementCreateUser(\$requestBody: createUserBody!, \$userUId: String)
{userManagementCreateUser(requestBody: \$requestBody, userUId: \$userUId){
  count
  invitation_id
  isUpdated
  }}""";
    return data;
  }

  String getAccountHierarchy({int? limit, int? start, String? searchKey}) {
    String getAccountHierarchyData = """query {
accountHierarchy(targetcustomeruid:"",toplevelsonly:"true",limit: $limit,
searchKey: "${searchKey == null ? "" : searchKey}",
start: $start){
  userUid,
  customers{
    customerUid,
    customerType,
     customerCode,
    displayName
    name,
    children{
      customerUid
    }
  }
}
}""";

    return getAccountHierarchyData;
  }

  String getSubAccountHeirachryData(
      {int? limit, int? start, String? searchKey, String? data}) {
    var schema = """query {
accountHierarchy(targetcustomeruid:"$data",limit: $limit,
searchKey: "${searchKey == null ? "" : searchKey}",
start: $start){
userUid,
  customers{
   customerUid,
    name,
    customerType,
    customerCode,
    displayName,
    
    children{
                name,
          customerType,
          customerCode,
          displayName,
          customerUid
      children{
        customerUid,
         name,
          customerType,
          customerCode,
          displayName,
          children{
          name,
          customerType,
          customerCode,
          displayName,
          customerUid
        }
      }
    }
  }
}
}""";
    return schema;
  }

  getFleetLocationData(
      {String? startDate,
      String? endDate,
      List<FilterData?>? filtlerList,
      int? pageNo,
      double? lati,
      double? longi,
      double? radius,
      int? pageSize}) async {
    await cleaValue();
    await clearAllList();
    await gettingFiltersValue(filtlerList);
    await gettingLocationFilter(filtlerList);

    final String fleetLocationData = """
  query fleetLocationDetails{
  fleetLocationDetails
 (
  pageNumber:$pageNo
pageSize:$pageSize
sort:"assetid"
assetIdentifier: ""
startDateLocal:"$startDate"
endDateLocal: "$endDate"
latitude:$lati
longitude:$longi
radiuskm:$radius
search:{
  manufacturer: ${manufacturerList.isEmpty ? [] : manufacturerList}
model: ${modelList.isEmpty ? [] : modelList}
assetstatus: ${assetstatusList.isEmpty ? [] : assetstatusList}
deviceType: ${deviceTypeList.isEmpty ? [] : deviceTypeList}
idleEfficiency: ${idleEfficiencyList.isEmpty ? [] : idleEfficiencyList}
fuelLevel: ${fuelLevelList.isEmpty ? [] : fuelLevelList}
productfamily: ${productfamilyList.isEmpty ? [] : productfamilyList}
location: ${locationList.isEmpty ? [] : locationList}
}
productfamily: ""
)
{
    pagination {
      totalCount
      pageNumber
      pageSize
    }
    links {
      self
      next
      prev
    }
    mapRecords {
      assetIdentifier
      assetSerialNumber
      serialNumber
      manufacturer
      makeCode
      model
      assetIcon
      status
      assetStatus
      hourMeter
      hourmeter
      latitude
      longitude
      lastReportedLocationLatitude
      lastReportedLocationLongitude
      lastReportedLocation
      lastReportedUTC
      fuelLevelLastReported
      notifications
      lastLocationUpdateUTC
      assetEventHistoryID
      locationEventUTC
      locationEventLocalTime
      locationEventLocalTimeZoneAbbrev
      odometer
    }
    countData {
      countOf
      count
    }
  }
  
}
  """;
    return fleetLocationData;
  }

  getFleetLocationDataProductFamilyFilterData(
      {String? startDate,
      String? endDate,
      List<FilterData?>? filtlerList,
      int? pageNo,
      List<String>? prodFamilyFilter,
      int? pageSize}) async {
    await cleaValue();
    await clearAllList();
    final String fleetLocationData = """
  query fleetLocationDetails{
  fleetLocationDetails
 (
  pageNumber:$pageNo
pageSize:$pageSize
sort:"assetid"
assetIdentifier: ""
startDateLocal:"$startDate"
endDateLocal: "$endDate"
search:{
  manufacturer: ${manufacturerList.isEmpty ? [] : manufacturerList}
model: ${modelList.isEmpty ? [] : modelList}
assetstatus: ${assetstatusList.isEmpty ? [] : assetstatusList}
deviceType: ${deviceTypeList.isEmpty ? [] : deviceTypeList}
idleEfficiency: ${idleEfficiencyList.isEmpty ? [] : idleEfficiencyList}
fuelLevel: ${fuelLevelList.isEmpty ? [] : fuelLevelList}
productfamily: ${prodFamilyFilter!.isEmpty ? [] : prodFamilyFilter}
location: ${locationList.isEmpty ? [] : locationList}
}
productfamily: ""
)
{
    pagination {
      totalCount
      pageNumber
      pageSize
    }
    links {
      self
      next
      prev
    }
    mapRecords {
      assetIdentifier
      assetSerialNumber
      serialNumber
      manufacturer
      makeCode
      model
      assetIcon
      status
      assetStatus
      hourMeter
      hourmeter
      latitude
      longitude
      lastReportedLocationLatitude
      lastReportedLocationLongitude
      lastReportedLocation
      lastReportedUTC
      fuelLevelLastReported
      notifications
      lastLocationUpdateUTC
      assetEventHistoryID
      locationEventUTC
      locationEventLocalTime
      locationEventLocalTimeZoneAbbrev
      odometer
    }
    countData {
      countOf
      count
    }
  }
  
}
  """;
    Logger().w(fleetLocationData);
    return fleetLocationData;
  }

  String getSingleAssetDetail(String uid) {
    var data = """query{
getSingleAssetDetails(assetUID:"$uid"){
  assetUid,
  assetSerialNumber,
  assetId,
  lifetimeFuel,
  lifetimeDEFLiters,
  makeCode,
  manufacturer,
  model,
  assetIcon,
  productFamily,
  status,
  hourMeter,
  odometer,
  lastReportedLocationLatitude,
  lastReportedLocationLongitude,
  lastReportedLocation,
  lastReportedTimeUtc,
  lastLocationUpdateUtc,
  percentDEFRemaining,
  lastPercentDEFRemainingUTC,
  fuelLevelLastReported,
  lastPercentFuelRemainingUtc,
  lastLifetimeFuelLitersUTC,
  fuelReportedTimeUtc,
  customStateDescription,
  devices{
    deviceUid,
    deviceType,
    deviceSerialNumber,
    deviceState,
    deviceState,
    isGpsRollOverAffected,
    activeServicePlans{
      serviceUid,
      type
    }
  },
  dealerName,
  dealerCustomerNumber,
  accountName,
  universalCustomerIdentifier,
  universalCustomerName,
  geofences{
    fenceUid,
    name,
    areaSqM
  },
  groups{
    groupUid,
    name
  }
  
}
}""";
    return data;
  }

  String getAssetGraphDetail(
      {String? assetId, String? date, String? productFamily}) {
    var data = """{
  getDashboardUtilizationSummary(assetUID: "${assetId == null ? "" : assetId}",date: "${date == null ? "" : date}",productfamily:"${productFamily == null ? "" : productFamily}") {
    totalDay {
      idleHours
      runtimeHours
      workingHours
    }
    totalWeek {
      idleHours
      runtimeHours
      workingHours
    }
    totalMonth {
      idleHours
      runtimeHours
      workingHours
    }
    averageDay {
      idleHours
      runtimeHours
      workingHours
    }
    averageWeek {
      idleHours
      runtimeHours
      workingHours
    }
    averageMonth {
      idleHours
      runtimeHours
      workingHours
    }
  }
}
""";
    return data;
  }

  String getNotes(String assetUid) {
    var data = """
query{
  getMetadataNotes(assetUID:"$assetUid"){
    userAssetNoteUID,
    assetUID,
    userName,
     assetUserNote,
    lastModifiedUTC,
    enableDeleteButton
  }
}""";
    return data;
  }

  String singleAssetUtilizationDetail(
      {String? assetId, String? startDate, String? endDate}) {
    String data = """
{
  getAssetDetailsSec(
        assetUid: "$assetId",
    endDate: "$endDate",
    includeNonReportedDays: "true",
    includeOutsideLastReportedDay: "true",
    sort: "-LastReportedUtilizationTime",
    startDate: "$startDate",
  ) {
    lastReportedTime
    assetIcon
    assetIdentifier
    assetId
    assetSerialNumber
    makeCode
    model
    lastRuntimeHourMeter
    lastOdometerMeter
    lastIdleHourMeter
    Code
    Message
    capabilities {
      hasActiveFuelSubscription
    },
    utilization{
      message,
      date,
      idleHours,
      supportsIdle,
      runtimeHours,
      workDefinitionType,
      workingHours,
      distanceTravelledKilometers,
      idleEfficiency,
      workingEfficiency,
      idleEfficiencyCalloutTypes,
      workingEfficiencyCalloutTypes,
      targetIdlePerformanceCalloutTypes,
      targetIdlePerformance,
      targetIdle,
      targetRuntime,
      targetRuntimePerformance,
      runtimeHoursCalloutTypes,
      idleHoursCalloutTypes,
      workingHoursCalloutTypes,
      lastRuntimeHourMeter,
      lastOdometerMeter,
      lastIdleHourMeter,
      lastRuntimeFuelConsumptionLitersMeter,
      lastIdleFuelConsumptionLitersMeter,
      runtimeFuelConsumedLiters,
      workingFuelConsumptionRate,
      idleFuelConsumptionRate,
      idleFuelConsumptionRateCalloutTypes,
      workingFuelConsumptionRateCalloutTypes,
      kmsPerRuntimeFuelConsumedLiter,
      runtimeFuelConsumedLitersCalloutTypes,
      idleFuelConsumedLitersCalloutTypes,
      workingFuelConsumedLitersCalloutTypes,
      lastReportedTime,
      lastReportedTimeZoneAbbrev,
      dailyreportedtimeTypes,
      runtimeFuelConsumptionRate

      
    }
  }
}
""";
    return data;
  }

  String getSingleAssetUtilizationGraphAggregate(
      {String? assetId, String? startDate, String? endDate}) {
    var data = """
{
  getAssetDetailsAggregate(assetUid: "$assetId", endDate: "$endDate", startDate: "$startDate", sort: "LastReportedUtilizationTime") {
    daily {
      aggregateType
      startDate
      endDate
      data {
        capabilities {
          hasActiveFuelSubscription
        }
        message
        date
        idleHours
        supportsIdle
        runtimeHours
        workDefinitionType
        workingHours
        distanceTravelledKilometers
        idleEfficiency
        workingEfficiency
        idleEfficiencyCalloutTypes
        workingEfficiencyCalloutTypes
        targetIdlePerformanceCalloutTypes
        targetIdlePerformance
        targetIdle
        targetRuntime
        targetRuntimePerformance
        runtimeHoursCalloutTypes
        idleHoursCalloutTypes
        workingHoursCalloutTypes
        lastRuntimeHourMeter
        lastOdometerMeter
        lastIdleHourMeter
        lastRuntimeFuelConsumptionLitersMeter
        lastIdleFuelConsumptionLitersMeter
        runtimeFuelConsumedLiters
        workingFuelConsumedLiters
        idleFuelConsumedLiters
        runtimeFuelConsumptionRate
        workingFuelConsumptionRate
        idleFuelConsumptionRate
        idleFuelConsumptionRateCalloutTypes
        workingFuelConsumptionRateCalloutTypes
        kmsPerRuntimeFuelConsumedLiter
        runtimeFuelConsumedLitersCalloutTypes
        idleFuelConsumedLitersCalloutTypes
        workingFuelConsumedLitersCalloutTypes
        lastReportedTime
        lastReportedTimeZoneAbbrev
        dailyreportedtimeTypes
      }
    }
    weekly {
      aggregateType
      startDate
      endDate
      data {
        capabilities {
          hasActiveFuelSubscription
        }
        message
        date
        idleHours
        supportsIdle
        runtimeHours
        workDefinitionType
        workingHours
        distanceTravelledKilometers
        idleEfficiency
        workingEfficiency
        idleEfficiencyCalloutTypes
        workingEfficiencyCalloutTypes
        targetIdlePerformanceCalloutTypes
        targetIdlePerformance
        targetIdle
        targetRuntime
        targetRuntimePerformance
        runtimeHoursCalloutTypes
        idleHoursCalloutTypes
        workingHoursCalloutTypes
        lastRuntimeHourMeter
        lastOdometerMeter
        lastIdleHourMeter
        lastRuntimeFuelConsumptionLitersMeter
        lastIdleFuelConsumptionLitersMeter
        runtimeFuelConsumedLiters
        workingFuelConsumedLiters
        idleFuelConsumedLiters
        runtimeFuelConsumptionRate
        workingFuelConsumptionRate
        idleFuelConsumptionRate
        idleFuelConsumptionRateCalloutTypes
        workingFuelConsumptionRateCalloutTypes
        kmsPerRuntimeFuelConsumedLiter
        runtimeFuelConsumedLitersCalloutTypes
        idleFuelConsumedLitersCalloutTypes
        workingFuelConsumedLitersCalloutTypes
        runtimeFuelConsumptionLitersMeterCalloutTypes
        idleFuelConsumptionLitersMeterCalloutTypes
        runtimeHoursMeterCalloutTypes
        idleHoursMeterCalloutTypes
        lastReportedTime
        lastReportedTimeZoneAbbrev
        dailyreportedtimeTypes
      }
    }
    monthly {
      aggregateType
      startDate
      endDate
      data {
        capabilities {
          hasActiveFuelSubscription
        }
        message
        date
        idleHours
        supportsIdle
        runtimeHours
        workDefinitionType
        workingHours
        distanceTravelledKilometers
        idleEfficiency
        workingEfficiency
        idleEfficiencyCalloutTypes
        workingEfficiencyCalloutTypes
        targetIdlePerformanceCalloutTypes
        targetIdlePerformance
        targetIdle
        targetRuntime
        targetRuntimePerformance
        runtimeHoursCalloutTypes
        idleHoursCalloutTypes
        workingHoursCalloutTypes
        lastRuntimeHourMeter
        lastOdometerMeter
        lastIdleHourMeter
        lastRuntimeFuelConsumptionLitersMeter
        lastIdleFuelConsumptionLitersMeter
        runtimeFuelConsumedLiters
        workingFuelConsumedLiters
        idleFuelConsumedLiters
        runtimeFuelConsumptionRate
        workingFuelConsumptionRate
        idleFuelConsumptionRate
        idleFuelConsumptionRateCalloutTypes
        workingFuelConsumptionRateCalloutTypes
        kmsPerRuntimeFuelConsumedLiter
        runtimeFuelConsumedLitersCalloutTypes
        idleFuelConsumedLitersCalloutTypes
        workingFuelConsumedLitersCalloutTypes
        runtimeFuelConsumptionLitersMeterCalloutTypes
        idleFuelConsumptionLitersMeterCalloutTypes
        runtimeHoursMeterCalloutTypes
        idleHoursMeterCalloutTypes
        lastReportedTime
        lastReportedTimeZoneAbbrev
        dailyreportedtimeTypes
      }
    }
    code
    message
  }
}
""";
    return data;
  }

  String getFilterData(String grouping) {
    var data = """
query{
fleetFiltersGrouping(
  grouping:"$grouping",
){
  countData{
     countOf,
    count,
    referenceColumns
  }
}
}
""";
    return data;
  }

  String searchLocation(String value) {
    var data = """
{
  searchLocation(searchQuery: "$value", maxResult: "10") {
    Locations {
      Address {
        StreetAddress
        City
        State
        StateName
        Zip
        County
        Country
        CountryFullName
        SPLC
      }
      Coords {
        Lat
        Lon
      }
      Region
      POITypeID
      PersistentPOIID
      SiteID
      ResultType
      ShortString
    }
  }
}
""";
    return data;
  }

  String getSingleAssetOperation(
      String? startDate, String? endDate, String? assetId) {
    var data = """
{
  assetOperations(sort: "-assetid", startDate: "$startDate", endDate: "$endDate", pageSize: 50, pageNumber: 1, assetUid: "$assetId", productfamily: "") {
    assetOperations {
      pagination {
        totalAssets
        assetsWithoutActiveCoreSubscription
        pageNumber
        pageSize
      }
      links {
        rel
        href
      }
      assets {
        assetUid
        assetId
        makeCode
        model
        serialNumber
        assetIcon {
          key
        }
        productFamily
        customStateDescription
        distanceTravelledKilometers
        dateRangeRuntimeDuration
        lastKnownOperator
        capabilities {
          hasActiveCoreSubscription
        }
        assetLocalDates {
          assetLocalDate
          totalRuntimeDurationSeconds
          segments {
            startTimeUtc
            endTimeUtc
          }
        }
        assetLastReceivedEvent {
          lastReceivedEvent
          lastReceivedEventTimeLocal
          lastReceivedEventUTC
          timezoneAbbrev
          segmentType
        }
        esn
      }
    }
  }
}
""";
    return data;
  }

  String singleAssetDetailLocation(
      String startDate, String endDate, String? assetUid) {
    var data = """
query{
  singleAssetLocationDetails(
       pageNumber: 1,
    pageSize: 50,
    assetIdentifier: "$assetUid",
    startTimeLocal: "$startDate",
    endTimeLocal: "$endDate"
  ){
    pagination{
      totalCount,
      pageNumber,
      pageSize
    }
    links{
      self,
      next,
      prev
    }
    assetLocation{
      assetIdentifier
assetSerialNumber
serialNumber
manufacturer
makeCode
model
assetIcon
status
assetStatus
hourMeter
hourmeter
latitude
longitude
lastReportedLocationLatitude
lastReportedLocationLongitude
lastReportedLocation
lastReportedUTC
fuelLevelLastReported
notifications
lastLocationUpdateUTC
assetEventHistoryID
locationEventUTC
locationEventLocalTime
locationEventLocalTimeZoneAbbrev
address{
  city,
  state,
  county,
  country,
  zip
}
odometer
    }
  }
}""";
    return data;
  }

  String assetLocationData(
      {String? no, String? pageSize, String? sort, String? query}) {
    var data = """
query{
  assetLocation(pageNumber:$no,pageSize:$pageSize,sort:"$sort", snContains:"$query"){
    pagination{
      totalCount,
      pageNumber,
      pageSize
    },
    links{
       self,
      next,
      prev
    },
     countData{
      countOf,
      count
    },
    mapRecords{
      assetIdentifier
assetId
assetSerialNumber
manufacturer
makeCode
model
assetIcon
status
hourMeter
lastReportedLocationLatitude
lastReportedLocationLongitude
lastReportedLocation
lastReportedUTC
fuelLevelLastReported
notifications
geofences
lastLocationUpdateUTC
    }
  }
}""";
    return data;
  }

  String notificationAssetList({String? no, String? pageSize}) {
    var data = """
{
  notificationAssetList(pageNumber: $no, pageSize: $pageSize, productfamily: "", model: "", manufacturer: "", deviceType: "") {
    assetDetailsRecords {
      assetSerialNumber,
      assetIdentifier,
       makeCode,
      assetId,
      model,
      assetIcon
    },
    pagination{
      totalCount,
      pageNumber,
      pageSize
    },
    links{
      self,
    }
  }
}
""";
    return data;
  }

  String manageNotificationList(
      {int? pageNumber, int? count, String? searchKey}) {
    String manageNotificationData = """
     query notificationsData{
  getConfiguredAlertsData(pageNumber: $pageNumber, count: $count, searchKey:$searchKey, notificationType: null) {
    configuredAlerts {
      alertConfigID
      alertConfigUID
      notificationTitle
      allAssetsInd
      notificationTypeGroupID
      notificationTypeID
      createdDate
      updatedDate
      notificationType
      numberOfAssets
      numberOfAssetGroups
      numberOfGeofences
      alertCategoryID
      alertGroupID
      operands {
        operandID
        operandName
        operatorID
        condition
        value
        unit
      }
      siteOperands {
        operandID,
        operandName,
        geoFenceID,
        geoFenceUID,
        name
      }
      allAssetsInd
    }
    links {
      prev
      next
      last
    }
    total {
      items
      pages
    }
    responseStatus
    
  }
}
""";
    return manageNotificationData;
  }

  getManageReportListData(
      {int? page,
      String? searchtext,
      int? limit,
      List<FilterData?>? appliedFilters}) async {
    await clearAllList();
    await getReportFilterData(appliedFilters);

    var reportListData = """{
  gridReport(searchText: "$searchtext", limit: $limit, page: $page,sort: "",reportFormat:$reportFormat,reportFrequency:$reportFrequency,reportTypeID:$reportType) {
    total
    page
    limit
    pageLinks {
      rel
      href
      method
    }
    status
    reqId
    metadata
    scheduledReports {
      reportUid
      reportFormat
      reportPeriod
      reportTitle
      reportType
      reportTypeName
      reportCreationDate
      emailSubject
      emailContent
      emailRecipients {
        email
        isVLUser
      }
      queryUrl
      reportColumns
      link {
        rel
        href
        method
      }
      assets {
        serialNumber
      }
      reportSourcePageName
      scheduleEndDate
      createdBy
      reportGenerationCategory
      svcMethod
      svcBody
      assetFilterCategoryID
      allAssets
    }
    msg
  }
}
""";

    return reportListData;
  }

  String getContactSearchData(String key) {
    Logger().e(key);
    var contactData = """{
  emailReport(key:"$key"){
    users{
      email,
      name,
      isVLUser,
      
    }
  }
}""";
    return contactData;
  }

  String addReportPayLoad(
      // {int? reportCategoryID,
      // int? reportFormat,
      // String? reportTitle,
      // String? reportScheduledDate,
      // String? reportStartDate,
      // String? reportEndDate,
      // String? emailSubject,
      // List? emailRecipients,
      // String? emailContent,
      // String? svcMethod,
      // bool? allAssets,
      // dynamic svcbody,
      // String? queryUrl,
      // dynamic svcBodyJson,
      // dynamic reportColumns,
      // String? assetsDropDownValue,
      // String? reportType}
      ) {
    var addReportPayLoad = """
mutation (\$assetFilterCategoryID: Int, \$assetFilterUIDs: [String], \$reportCategoryID: Int, \$reportFormat: Int, \$reportPeriod: Int, \$reportTitle: String, \$reportScheduledDate: String, \$reportStartDate: String, \$reportEndDate: String, \$emailSubject: String, \$emailRecipients: [String], \$emailContent: String, \$svcMethod: String, \$allAssets: Boolean, \$filterOptions: [filterOptionsObj], \$filterTag: [filterTag], \$queryUrl: String, \$reportType: String, \$reportColumns: [String], \$svcbody: [String], \$svcbodyJson: svcbodyResponse, \$productfamily: String, \$model: String, \$assetstatus: String, \$fuelLevelPercentLT: String, \$idleEfficiencyGT: String, \$idleEfficiencyLTE: String, \$assetIDContains: String, \$snContains: String, \$Latitude: String, \$Longitude: String, \$radiuskm: String, \$manufacturer: String) {
  createNotificationReport(assetFilterCategoryID: \$assetFilterCategoryID, assetFilterUIDs: \$assetFilterUIDs, reportCategoryID: \$reportCategoryID, reportFormat: \$reportFormat, reportPeriod: \$reportPeriod, reportTitle: \$reportTitle, reportScheduledDate: \$reportScheduledDate, reportStartDate: \$reportStartDate, reportEndDate: \$reportEndDate, emailContent: \$emailContent, emailSubject: \$emailSubject, emailRecipients: \$emailRecipients, svcMethod: \$svcMethod, allAssets: \$allAssets, filterOptions: \$filterOptions, filterTag: \$filterTag, queryUrl: \$queryUrl, reportType: \$reportType, reportColumns: \$reportColumns, svcbody: \$svcbody, svcbodyJson: \$svcbodyJson, assetstatus: \$assetstatus, fuelLevelPercentLT: \$fuelLevelPercentLT, idleEfficiencyGT: \$idleEfficiencyGT, idleEfficiencyLTE: \$idleEfficiencyLTE, assetIDContains: \$assetIDContains, snContains: \$snContains, Latitude: \$Latitude, Longitude: \$Longitude, radiuskm: \$radiuskm, manufacturer: \$manufacturer, productfamily: \$productfamily, model: \$model) {
    reportUid
    link {
      rel
      href
      method
    }
    status
    reqId
    msg
    body {
      status
      title
    }
  }
}
""";

    return addReportPayLoad;
  }

  String deleteReport(List<String> reportUid) {
    var deleteReport = """mutation{
  deleteReports(reportUid:${Utils.getStringListData(reportUid)}){
     status,
    reqId,
    msg
  }
}""";
    return deleteReport;
  }

  String getEditReportData(String reportUid) {
    var getReportData = """query{
  notificationSingleReport(reportUid:"$reportUid"){
    msg,
    status,
    scheduledReport{
      reportUid,
      reportType,
      reportFormat,
      reportType,
      reportCreationDate,
      emailSubject,
      emailContent,
      emailRecipients{
        email,
        isVLUser
      },
      createdBy,
      svcBody,
      svcMethod,
      reportGenerationCategory,
      queryUrl,
      reportColumns,
       scheduleEndDate,
         allAssets,
      link{
        rel,
        href,
         method
      },
      reportTitle,
      reportPeriod,
      assetFilterCategoryID,
      assetFilterUIDs
    }
  }
}""";
    return getReportData;
  }

  String? getEditReportsaveData(
      // {String? reportUid,
      // String? emailSubject,
      // List? emailRecipients,
      // String? queryUrl,
      // dynamic svcbody,
      // String? emailContent,
      // String? reportTitle,
      // String? reportEndDate,
      // String? assetsDropDownValue,
      // dynamic svcbodyJson}
      ) {
    var editSaveData =
        """mutation (\$reportUid: String, \$assetFilterUIDs: [String], \$reportPeriod: Int, \$reportTitle: String, \$emailSubject: String, \$emailContent: String, \$emailRecipients: [String], \$queryUrl: String, \$reportEndDate: String, \$assetFilterCategoryID: Int, \$allAssets: Boolean, \$filterTag: [filterTag], \$filterOptions: [filterOptionsObj], \$svcbody: [String], \$svcbodyJson: svcbodyResponse){
  updateNotificationReport(reportUid: \$reportUid, assetFilterUIDs: \$assetFilterUIDs, reportPeriod: \$reportPeriod, reportTitle: \$reportTitle, emailSubject: \$emailSubject, emailContent: \$emailContent, emailRecipients: \$emailRecipients, queryUrl: \$queryUrl, reportEndDate: \$reportEndDate, assetFilterCategoryID: \$assetFilterCategoryID, allAssets: \$allAssets, filterTag: \$filterTag, filterOptions: \$filterOptions, svcbody: \$svcbody, svcbodyJson: \$svcbodyJson){
    status,
    reqId
  }
}""";
    return editSaveData;
//     Logger().w(reportUid);
//     var editSaveData;
//     if (assetsDropDownValue == "Asset Operation" ||
//         assetsDropDownValue == "Fleet Summary" ||
//         assetsDropDownValue == "Multi-Asset Utilization") {
//     } else if (assetsDropDownValue == "Utilization Details" ||
//         assetsDropDownValue == "Fault Code Asset Details" ||
//         assetsDropDownValue == "Backhoe Loader Operation" ||
//         assetsDropDownValue == "Excavator Usage" ||
//         assetsDropDownValue == "Multi-Asset Excavator Usage Report" ||
//         assetsDropDownValue == "Multi-Asset Excavator Usage") {
//       editSaveData = """mutation{
//   updateNotificationReport(reportUid:"$reportUid",
//     reportPeriod:1,
//     emailSubject:"$emailSubject",
//     emailRecipients:$emailRecipients ,
//     queryUrl:"$queryUrl",
//     emailContent:"$emailContent",
//     assetFilterCategoryID:1,
//     allAssets:false,
//     filterTag:[],
//     filterOptions:[],
//     reportTitle:"$reportTitle",
//     reportEndDate:"$reportEndDate",
//   ){
//     status,
//     reqId
//   }
// }""";
//       Logger().wtf(editSaveData);
//       return editSaveData;
//     } else if (assetsDropDownValue == "Fault Summary Faults List") {
//       editSaveData = """mutation{
//   updateNotificationReport(reportUid:"$reportUid",
//     reportPeriod:1,
//     emailSubject:"$emailSubject",
//     emailRecipients:$emailRecipients ,
//     queryUrl:"$queryUrl",
//     emailContent:"$emailContent",
//     assetFilterCategoryID:1,
//     allAssets:false,
//     filterTag:[],
//     filterOptions:[],
//     svcbodyJson:$svcbodyJson
//     reportTitle:"$reportTitle",
//     reportEndDate:"$reportEndDate",
//   ){
//     status,
//     reqId
//   }
// }""";
//       return editSaveData;
//     }
//     return null;
  }

  var reportFilterCountData = """query{
  reportCount{
    countData{
      id,
      groupName,
      name,
      count
    }
     }
  }""";
  String addGeofencePayload({
    String? geofenceType,
    String? geometryWKT,
    String? geofenceName,
    String? description,
    String? actionUTC,
    String? endDate,
    int? fillColor,
  }) {
    var data = """
mutation {
  createGeofencesData(
    geofenceType: "$geofenceType", 
    geometryWKT: "$geometryWKT", 
    geofenceName: "$geofenceName", 
   actionUTC: "$actionUTC", 
    endDate: ${endDate == null ? null : "\"" + "$endDate" + "\""},
     description: "$description",  
    fillColor: $fillColor, 
    isTransparent: false
    ) {
    geofenceUID
  }
}
""";
    return data;
  }

  String updateGeofencePayload({
    String? geofenceType,
    String? geometryWKT,
    String? geofenceName,
    String? description,
    String? actionUTC,
    String? endDate,
    int? fillColor,
  }) {
    var data = """
mutation {
  updateGeofencesData(
    geofenceType: "$geofenceType", 
    geometryWKT: "$geometryWKT", 
    geofenceName: "$geofenceName", 
   actionUTC: "$actionUTC", 
    endDate: ${endDate == null ? null : "\"" + "$endDate" + "\""},
     description: "$description",  
    fillColor: 658170, 
    isTransparent: false
    )
}
""";
    return data;
  }

  String geofenceSingleResponce(String uid) {
    var data = """
query{
  geofenceSingleResponse(
    geofenceUids:"$uid"
  ){
    geofenceName
description
geofenceType
geometryWKT
fillColor
isTransparent
customerUID
areaSqMeters
geofenceUID
startDate
endDate
  }
}""";
    return data;
  }

  String getGeofenceData(List<int>? id, String? sort) {
    var data = """
query{
  geofencesTypeId(geofenceTypeIds:$id,sort:$sort){
geofences{
  isFavorite
geofenceName
description
geofenceType
geometryWKT
fillColor
isTransparent
customerUID
areaSqMeters
geofenceUID
startDate
endDate
}
  }
}""";
    return data;
  }

  String markFav(String uid) {
    var data = """
mutation{
  markFavorite(geofenceUID:"$uid")
}""";
    return data;
  }

  String markUnfav(String uid) {
    var data = """
mutation{
 markUnFavorite(geofenceUID:"$uid")
}""";
    return data;
  }

  String deleteGeofence(String uid, String utc) {
    var data = """
mutation{
  geofenceDelete(
    geofenceuid:"$uid",
  actionutc:"$utc")
}""";
    return data;
  }

  String createNotification(
      // {
      //   int? alertCategoryID,
      // String? currentDate,
      // String? alertTitle,
      // int? alertGroupId,
      // int? notificationTypeGroupID,
      // int? notificationTypeId,
      // int? numberOfOccurences,
      // String? notificationDeliveryChannel,
      // List<Operand>? operand,
      // List<Schedule>? schedule,
      // List<String>? assetId,
      // List<String>? geofenceId,
      // dynamic siteOperand,
      // NotificationSubscribers? notificationSubscribers
      // }
      ) {
    var data = """
mutation createNotification(\$alertCategoryID: Int, \$notificationSubscribers: notificationSubscribersObj, \$allAssets: Boolean, \$currentDate: String, \$schedule: [scheduleObj], \$alertTitle: String, \$alertGroupId: Int, \$notificationTypeGroupID: Int, \$assetUIDs: [String], \$operands: [createNotificationOperandsObj], \$notificationTypeId: Int, \$numberOfOccurences: Int, \$notificationDeliveryChannel: String, \$geofenceUIDs: [String], \$assetGroupUIDs: [String], \$siteOperands: [siteOperandsObj], \$switchOperand: createNotificationSwitchOperandObj, \$zones: [zoneObj]){
 createNotification(alertCategoryID: \$alertCategoryID, allAssets: \$allAssets, currentDate: \$currentDate, schedule: \$schedule, alertTitle: \$alertTitle, alertGroupId: \$alertGroupId, notificationTypeGroupID: \$notificationTypeGroupID, assetUIDs: \$assetUIDs, operands: \$operands, notificationTypeId: \$notificationTypeId, numberOfOccurences: \$numberOfOccurences, notificationDeliveryChannel: \$notificationDeliveryChannel, notificationSubscribers: \$notificationSubscribers, geofenceUIDs: \$geofenceUIDs, assetGroupUIDs: \$assetGroupUIDs, siteOperands: \$siteOperands, switchOperand: \$switchOperand, zones: \$zones){
    alertConfig{
      alertUID
    }
    responseStatus
  }
}""";
    return data;
  }

   String updateNotification(
      {int? alertCategoryID,
      String? currentDate,
      String? alertTitle,
      int? alertGroupId,
      int? notificationTypeGroupID,
      int? notificationTypeId,
      int? numberOfOccurences,
      String? notificationDeliveryChannel,
      List<Operand>? operand,
      List<Schedule>? schedule,
      List<String>? assetUIDs,
      List<String>? geofenceUIDs,
      List<String>? assetGroupUIDs,
      NotificationSubscribers? notificationSubscribers,
      String? alertId}) {
    var data = """
mutation{
  updateNotification(
    alertCategoryID: $alertCategoryID
    assetUIDs: ${assetUIDs != null ? Utils.getStringListData(assetUIDs) : null}
    notificationSubscribers:${Utils.getNotificationSubscribers(notificationSubscribers!)}
    allAssets: false
    currentDate: "$currentDate"
    schedule: ${Utils.getNotificationSchedule(schedule!)}
    alertTitle: "$alertTitle"
    alertGroupId: $alertGroupId
    notificationTypeGroupID: $notificationTypeGroupID
    operands:${Utils.getOperand(operand)}
    notificationTypeId: $notificationTypeId
    numberOfOccurences: $numberOfOccurences
    notificationDeliveryChannel:"$notificationDeliveryChannel"
    geofenceUIDs:${geofenceUIDs != null ? Utils.getStringListData(geofenceUIDs) : null}
    assetGroupUIDs: ${assetGroupUIDs != null ? Utils.getStringListData(assetGroupUIDs) : null}
    siteOperands: null
    switchOperand: null
    zones: null
    notificationUid:"$alertId"
      ){
        isUpdated
      }
  }""";
    return data;
  }
  String checkNotificationTitle(String title) {
    var data = """
query{
  getAlertTitleExistsData(
    alertTitle:"$title",
    alertConfigUID:""
  ){
    alertTitleExists,
    responseStatus
  }
}""";
    return data;
  }

  String getNotificationTypes() {
    var data = """
query{
  getNotificationTypeGroupsData{
    notificationTypeGroups{
      notificationTypeGroupID,
      notificationTypeGroupName,
      notificationTypes{
        notificationTypeID,
        notificationTypeName,
        appName,
        appURL,
        operands{
          operandName,
          operandID,
          maxValue,
          minValue,
          maxOccurrence,
          minOccurrence,
          operators{
            operatorID,
            code,
            name
          }
        }
      }
    }
   
  }
}""";
    return data;
  }

  String getNotificationAssetList(
      {String? productfamily,
      String? model,
      String? manufacturer,
      int? pageNo,
      int? pageSize,
      String? deviceType,
      String? customerIdentifier}) {
    var data = """
query{
  notificationAssetList(
pageNumber:${pageNo == null ? 1 : pageNo}
pageSize:${pageSize == null ? 9999 : pageSize}
minimalFields:false
productfamily: ${productfamily == null ? "\"\"" : "${"\"" + productfamily + "\""}"}
model: ${model == null ? "\"\"" : "${"\"" + model + "\""}"}
manufacturer: ${manufacturer == null ? "\"\"" : "${"\"" + manufacturer + "\""}"}
deviceType: ${deviceType == null ? "\"\"" : "${"\"" + deviceType + "\""}"}
customerIdentifier:${customerIdentifier == null ? "\"\"" : "${"\"" + customerIdentifier + "\""}"}
){
assetDetailsRecords{
      assetIdentifier,
      assetSerialNumber,
      makeCode,
      assetId,
      model,
      assetIcon
    }
  }
}""";
    return data;
  }

  String getNotificationData(
      {int? pageNo,
      int? count,
      String? searchKey,
      List<String>? notificationType}) {
    var data = """
query{
  getConfiguredAlertsData(
        pageNumber: $pageNo,
    count: $count,
    searchKey: ${searchKey == null ? "\"\"" : "${"\"" + searchKey + "\""}"},
    notificationType: ${Utils.getStringListData(notificationType ?? [])}
  ){
    links{
      prev,
      next,
      last
    }
    total{
      items,
      pages
    }
    responseStatus,
    configuredAlerts{
      alertConfigID
alertConfigUID
notificationTitle
allAssetsInd
notificationTypeGroupID
notificationTypeID
createdDate
updatedDate
notificationType
numberOfAssets
numberOfAssetGroups
numberOfGeofences
alertCategoryID
alertGroupID
operands{
  operandID,
  operandName,
  operatorID,
  condition,
  value,
  unit
}
siteOperands{
  operandID,
  operandName,
  geoFenceID,
  geoFenceUID,
  name
}
    }
  }
}""";
    return data;
  }

String editSingleNotification(String? id, String? pageNo) {
    var data = """
query{
  getNotificationAlertConfigData(
    alertConfigUID:"$id",
    page:"$pageNo"
  ){
    alertConfig{
      alertConfigID
alertConfigUID
notificationTitle
allAssetsInd
notificationTypeGroupID
numberOfAssetGroups
numberOfGeofences
notificationTypeID
createdDate
updatedDate
notificationType
numberOfAssets
alertCategoryID
alertGroupID
notificationConfigID
occurrenceCount
geofences
assets {
  assetID
  assetUID
  assetName
}
assetGroups
operands {
  operandID
  operandName
  operatorID
  condition
  value
}
switchOperand {
  operandID
  operatorID
}
siteOperands {
  operandID
  operandName
  geoFenceID
  geoFenceUID
  name
}
scheduleDetails {
  alertConfigScheduleDtlID
  scheduleDayNum
  scheduleStartTime
  scheduleEndTime
}
deliveryConfig {
  deliveryConfigID
  deliveryModeInd
  recipientStr
  isVLUser
}
zones {
  zoneUID
  isInclusion
}
    }
  }
}""";
    return data;
  }

  String deleteNotification(String uids) {
    var data = """
mutation{
  deleteNotificationAlertConfig(
    alertConfigUID:${doubleQuote + uids + doubleQuote}
  ){
    isDeleted,
    
  }
}""";
    return data;
  }

  String seeAllNotification(
      {int? pageNo,
      int? notificationStatus,
      String? startDate,
      String? endDate,
      int? notificationUserStatus,
      //String? assetUIDs,
      List<String>? notificationType,
      String? productFamily}) {
    var data = """
query{
  seeAllNotificationList(
    pageNumber:$pageNo,
    notificationStatus:${notificationStatus ?? 0},
    notificationUserStatus:$notificationUserStatus,
    fromDate:"${startDate != null ? startDate : ""}",
    toDate:"${endDate != null ? endDate : ""}",
    
  
     notificationType:${Utils.getStringListData(notificationType ?? [])}
     productFamily:"${productFamily != null ? productFamily : ""}"
  ){
    links{
      next,
      last
    }
    total{
      items,
      pages
    },
    notifications{
      notificationUID
notificationTitle
occurUTC
assetUID
serialNumber
assetName
makeCode
model
location
iconKey
latitude
longitude
notificationType
notificationSubType
notificationConfigJSON
resolvedStatus
readStatus
    },
    status
  }
}""";
    return data;
  }

  createGroup() {
    var data = """
mutation createGroups(\$assetUID: [String], \$description: String, \$groupName: String){
  createGroups(assetUID: \$assetUID, description: \$description, groupName: \$groupName){
 groupUID
  }
}
""";
    return data;
  }

  groupsGrid() {
    var data = """
query (\$pageNumber: Int, \$sort: String, \$searchKey: String, \$searchValue: String){
  groupsGrid(pageNumber: \$pageNumber, sort: \$sort, searchKey: \$searchKey, searchValue: \$searchValue){
        total{
      items,
      pages
    },
    groups{
      groupUid,
      groupName,
      description,
      isFavourite,
      createdOnUTC,
      createdByUserName,
      assetUID
    }
  }
}""";
    return data;
  }

  getGroupDeleteData(String? groupId) {
    var data = """mutation{
    deleteGroup(GroupUID:"$groupId"){
        isDeleted
    }
}""";
    return data;
  }

  getAssetSettingData(int pageNo, int pageSize, String deviceType,
      String searchWord, String filterName) {
    Logger().w(searchWord.isEmpty);
    Logger().w(filterName.isEmpty);
    var data = """
query{
  assetSettingsGrid(
    startDate: ""
endDate:""
pageNumber:$pageNo
pageSize: $pageSize
filterName: ${filterName.isEmpty ? doubleQuote + doubleQuote : doubleQuote + filterName + doubleQuote},
filterValue: ${searchWord.isEmpty ? doubleQuote + doubleQuote : doubleQuote + searchWord + doubleQuote}
sortColumn: ""
deviceType: ${deviceType == "ALL" ? "\"\"" : "${"\"" + deviceType + "\""}"}
  ){
    assetSettings{
      assetUid
assetId
assetSerialNumber
assetModel
assetMakeCode
assetIconKey
deviceSerialNumber
devicetype
targetStatus
dailyReportingTime
hoursMeter
movingOrStoppedThreshold
movingThresholdsDuration
movingThresholdsRadius
odometer
smhOdometerConfig
speedThreshold
speedThresholdDuration
speedThresholdEnabled
configuredSwitches
totalSwitches
fuelType
workDefinition
pendingDeviceConfigInfo{
  reportingSchedule{
    lastUpdatedOn
  }
  meters{
    lastUpdatedOn
  }
  switches{
    lastUpdatedOn
  }
  movingThresholds{
    lastUpdatedOn
  }
  speedingThresholds{
    lastUpdatedOn
  }
}
    },
    pageInfo{
      totalRecords,
      totalPages,
      currentPageNumber,
      currentPageSize
    },
    errors
  }
}""";
    return data;
  }

  getAssetListData(String assetUids) {
    var data = """
mutation {
  assetListSettings(
    assetUIDs:"$assetUids"
  ) {
    assetUID
    assetName
    legacyAssetID
    serialNumber
    makeCode
    model
    assetTypeName
    equipmentVIN
    iconKey
    modelYear
    statusInd
  }
}
""";
    return data;
  }

  assetIcon(
      {String? actionUTC,
      String? assetType,
      String? assetUID,
      String? equipmentVIN,
      int? iconKey,
      int? legacyAssetID,
      String? model,
      int? modelYear,
      String? assetName}) {
    var data = """
mutation{
  assetIcon(
    assetName:""
legacyAssetID:$legacyAssetID
model:"$model"
assetType: "$assetType"
iconKey: $iconKey
equipmentVIN: "$equipmentVIN"
modelYear: $modelYear
owningCustomerUID: ""
assetUID: "$assetUID"
objectType:""
category:""
projectStatus: ""
sortField: ""
source:""
userEnteredRuntimeHours: ""
classification: ""
planningGroup: ""
actionUTC: "$actionUTC"
receivedUTC: ""
  )
}""";
    return data;
  }

  assetSettingsType(bool allAssets, List<String> assetUids) {
    var data = """
mutation{
  assetSettingDeviceTypes(
    allAssets:$allAssets,
    assetUID:$assetUids
  ){
    deviceTypes{
      id,
      name,
      assetCount
    }
  }
}""";
    return data;
  }

  getFaultCodeTypesData(
      {String? lang, int? pageNo, String? codeType, String? faultDescription}) {
    var data = """
{
  getFaultCodeData(lang: ${lang == null ? "\"\"" : "${"\"" + lang + "\""}"}, page: $pageNo, faultCodeType: ${codeType == null ? "\"\"" : "${"\"" + codeType + "\""}"}, faultDescription: ${faultDescription == null ? "\"\"" : "${"\"" + faultDescription + "\""}"}) {
    descriptions {
      faultCodeIdentifier
      faultDescription
      faultCodeType
    }
    page
    limit
    total
    pageLinks {
      rel
      href
      method
    }
    status
    reqId
    msg
  }
}
""";
    return data;
  }

  String getAssetTargetSettingsData(
      String? startDate, String? endDate, List<String>? assetID) {
    Logger().w(startDate);
    var data = """mutation{
     assetTargetSettings(startDate:"$startDate",endDate:"$endDate",assetID:${Utils.getStringListData(assetID!)}){
    assetTargetSettings{
      startDate,
      endDate,
      runtime{
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday
      },
      idle{
          sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday
      },
      assetUid
      
      
       
    }
  }
    }""";
    return data;
  }

  String getAddEStimatedRuntimeData(String? assetId, String? startDate,
      String? endDate, Idle? idle, Runtime? runtime) {
    int runtimeMon = int.parse(runtime!.monday!.toString());
    int runtimeTue = int.parse(runtime.tuesday!.toString());
    int runtimeWed = int.parse(runtime.wednesday!.toString());
    int runtimeThu = int.parse(runtime.thursday!.toString());
    int runtimeFri = int.parse(runtime.friday!.toString());
    int runtimeSat = int.parse(runtime.saturday!.toString());
    int runtimeSun = int.parse(runtime.sunday!.toString());
    int idleMon = int.parse(idle!.monday.toString());
    int idleTue = int.parse(idle.tuesday.toString());
    int idleWed = int.parse(idle.wednesday.toString());
    int idleThu = int.parse(idle.thursday.toString());
    int idleFri = int.parse(idle.friday.toString());
    int idleSat = int.parse(idle.saturday.toString());
    int idleSun = int.parse(idle.sunday.toString());
    var data = """mutation{
      updateAssetTargetSettings(assetTargetSettings:{
       assetUid:"$assetId"
       startDate:"$startDate",
       endDate:"$endDate",
       runtime:{
         sunday:$runtimeSun,
        
    monday:$runtimeMon,
    tuesday:$runtimeTue,
    wednesday:$runtimeWed,
    thursday:$runtimeThu,
    friday:$runtimeFri,
    saturday:$runtimeSat
        
       },
       idle:{
        sunday:$idleSun
        
    monday:$idleMon,
    tuesday:$idleTue
    wednesday:$idleWed,
    thursday:$idleThu,
    friday:$idleFri,
    saturday:$idleSat
       }
      }){
    assetUIDs
  }
    }""";

    return data;
  }

  static String globalSearch(String? snContains, String? assetIdContains) {
    var data = """query{
getSearchSuggestions(snContains:"$snContains",assetIdContains:"$assetIdContains"){
    topMatches{
      assetUid,
      serialNumber
    }
    totalCount
  }
   }""";
    return data;
  }

  String getSingleAssetData(
      {String? startDateTime,
      String? endDateTime,
      int? page,
      int? limit,
      String? assetUid}) {
    var data = """query{
  singleAsset(
  startDateTime:"$startDateTime",
    endDateTime:"$endDateTime",
    page:$page,
    limit:$limit,
    
 assetUid:["$assetUid"]
    
    
  ){
    limit
    page,
    total,
    page
    assetData{
      assetUID
    faults{
      source,
      faultIdentifiers,
      occurrences,
      description,
      severityLabel,
      faultClosureUTC,
      severity,
      hours,
      faultCode,
      lastReportedLocationLatitude,
      lastReportedLocationLongitude,
      lastReportedTimeUTC,
      lastReportedLocation

    }
    }
    }
    }""";
    return data;
  }

  getMaintenanceListData(
      {String? startDate,
      String? endDate,
      List<FilterData?>? appliedFilter,
      int? limit,
      int? pageNo,
      bool? histroy,
      String? assetId}) async {
    await clearAllList();
    await cleaValue();
    await gettingFiltersValue(appliedFilter);
    await gettingLocationFilter(appliedFilter);
    // Logger().v(assetId);

    var data = """
{
  
  maintenanceList(
    fromDate: ${startDate == null ? "\"\"" : "${"\"" + startDate + "\""}"}, 
    limit: ${limit ?? null}, 
    pageNumber: ${pageNo ?? null},
    toDate:${endDate == null ? "\"\"" : "${"\"" + endDate + "\""}"}, 
    serviceStatus:  ${serviceStatusList.isEmpty ? [] : serviceStatusList}, 
    serviceType:${serviceTypeList.isEmpty ? [] : serviceTypeList}, 
    assetType:${assetTypeList.isEmpty ? [] : assetTypeList}, 
    assetId: ${assetId == null ? "\"\"" : "${"\"" + assetId + "\""}"},
    make:  ${model == null ? "\"\"" : "${"\"" + model! + "\""}"},
    manufacturer:  ${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"}, 
    productFamily:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}, 
    assetStatus:  ${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}, 
    fuelLevel:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"},
    deviceType:  ${deviceType == null ? "\"\"" : "${"\"" + deviceType! + "\""}"}, 
    history: ${histroy ?? null}) {
    maintenanceList {
      serviceNumber
      assetId
      assetName
      assetIcon
      serialNumber
      make
      model
      modelYear
      productFamily
      currentHourMeter
      lastLocationReportedDate
      longitude
      latitude
      streetAddress
      city
      state
      county
      country
      zip
      odometer
      lastReportedDate
      percentFuelRemaining
      fuelLastReportedTime
      serviceName
      serviceInterval
      status
      dueAt
      dueDate
      serviceType
      serviceStatus
      assetType
      telematicsDeviceId
      deviceType
      source
      serviceDate
      serviceMeter
      performedBy
      serviceNotes
      dueInOverdueBy
      completedService
      customerName
      address
      dealerName
      workOrder
    }
    status
    count
  }
}
""";
    return data;
  }

  getMaintennaceAssetListData(
      {String? fromDate,
      String? toDate,
      int? limit,
      int? pageNo,
      List<FilterData?>? appliedFilter}) async {
    await clearAllList();
    await cleaValue();
    await gettingFiltersValue(appliedFilter);
    await gettingLocationFilter(appliedFilter);
    var data = """
query{
  maintenanceAssetList(
fromDate:${fromDate == null ? "\"\"" : "${"\"" + fromDate + "\""}"}
limit: ${limit ?? null}
pageNumber: ${pageNo ?? null}
toDate: ${toDate == null ? "\"\"" : "${"\"" + toDate + "\""}"}
serviceStatus:${serviceStatusList.isEmpty ? [] : serviceStatusList}
serviceType:${serviceTypeList.isEmpty ? [] : serviceTypeList}, 
assetType:${assetTypeList.isEmpty ? [] : assetTypeList}, 
assetId:""
make:[]
manufacturer:${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"}
productFamily:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}
assetStatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}
fuelLevel:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}
deviceType: ${deviceTypeList.isEmpty ? [] : deviceTypeList}
  ){
    status,
    count,
    assetMaintenanceList{
      count,
CustomerAssetID,
assetId,
serialNumber,
assetIcon,
make,
model,
currentHourMeter,
servicedescription,
serviceStatusName,
serviceName,
deviceSerialNumber,
maintenanceTotals{
  count,
  name,
  alias
}
    }
  }
}""";
    return data;
  }

  getMaitenanceCheckList({String? assetId, int? serviceNo}) {
    var data = """
query{
  maintenanceCheckList(
    serviceNumber:$serviceNo,
    assetId:$assetId
  ){
    status,
    serviceStatus,
    dueInOverdueBy,
    maintenanceCheckList{
      checkListName,
      checkListId,
      isChecked,
      partList{
        name,
        partNo,
        quantity,
        partId,
        description,
        units
      }
    },
    maintenanceServiceList{
      serviceName,
      serviceId
    }
  }
}""";
    return data;
  }

  String getFaultSingleData(
      {String? startDate,
      String? endDate,
      int? pageSize,
      int? limit,
      String? faultsId,
      String? langeDesc}) {
    var data = """query{
   faultsinglesData(
       startDateTime:"$startDate"
       endDateTime:"$endDate",
       pageSize:$pageSize,
       limit:$limit,
       langDesc:"$langeDesc",
       faultsId:"$faultsId"

   ){
      status,
      msg,
      faults{
          description,
          source,
          faultOccuredUTC,
          severityLabel
          }
          }

      } """;
    return data;
  }

  onCompletion(
      {String? assetId,
      String? performedBy,
      String? serviceDate,
      String? serviceMeter,
      String? serviceNotes,
      int? serviceNo,
      String? workOrder}) {
    var data = """
mutation {
  maintenancepostData(
    assetId:  ${assetId == null ? "\"\"" : "${"\"" + assetId + "\""}"}, 
    isComplete: true, 
    maintenanceCheckList: [], 
    performedBy:  ${performedBy == null ? "\"\"" : "${"\"" + performedBy + "\""}"}, 
    serviceDate:  ${serviceDate == null ? "\"\"" : "${"\"" + serviceDate + "\""}"}, 
    serviceMeter:  ${serviceMeter == null ? "\"\"" : "${"\"" + serviceMeter + "\""}"}, 
    serviceNotes:  ${serviceNotes == null ? "\"\"" : "${"\"" + serviceNotes + "\""}"}, 
    serviceNumber: ${serviceNo ?? null}, 
    workOrder:  ${workOrder == null ? "\"\"" : "${"\"" + workOrder + "\""}"})
    {
    status
    message
  }
}
""";
    return data;
  }

  getMaintenanceRefineData(
      {String? fromDate, String? toDate, int? limit, int? pageNo}) {
    var data = """
query{
  maintenanceRefine(
    fromDate: ${fromDate == null ? "\"\"" : "${"\"" + fromDate + "\""}"}
limit: ${limit ?? null}
pageNumber: ${pageNo ?? null}
toDate: ${toDate == null ? "\"\"" : "${"\"" + toDate + "\""}"}
  ){
    status,
    maintenanceRefine{
      status,
      typeName,
      typeAlias,
      typeValues{
        name,
        alias,
        count
      }
    }
  }
}""";
    return data;
  }

  String getPlantDashboardandCalendarData() {
    var data = """query{
    frameSubscription{
        plantDispatchSummary{
         plantAssetCount,
         subscriptionEnded,
         yetToBeActivated,
          totalDevicesSupplied,
          activeSubscription,
          assetActivationByDay,
          assetActivationByMonth,
          assetActivationByWeek

        }
        }
        }""";
    return data;
  }

  maintenanceDashboardCount({
    String? fromDate,
    String? endDate,
    String? prodFamily,
    String? assetId,
    String? nextWeekEndDate,
    String? todayEndDate,
  }) {
    var data = """query{
maintenanceDashboard(
    assetId:${assetId == null ? "\"\"" : "${"\"" + assetId + "\""}"},
      todayEndDate:${todayEndDate == null ? "\"\"" : "${"\"" + todayEndDate + "\""}"},
  nextWeekEndDate:${nextWeekEndDate == null ? "\"\"" : "${"\"" + nextWeekEndDate + "\""}"},
  fromDate:${fromDate == null ? "\"\"" : "${"\"" + fromDate + "\""}"},
  toDate:${endDate == null ? "\"\"" : "${"\"" + endDate + "\""}"},
  productFamily:${prodFamily == null ? "\"" + "\"" : "\"" + prodFamily + "\""}){
  status,
  dashboardData{
    count,
    alias,
    displayName,
    subCount{
      displayName,
      alias,
      count
    }
  }
}
}""";
    return data;
  }

  String getHierarchyData() {
    var data = """query{
    frameSubscription{
       plantHierarchyDetails{
           totalAssetCount,
           totalCustomerCount,
           totalDealerCount,
           totalPlantCount
       }
       }
       }""";
    return data;
  }

  maintenanceInterval({int? pageNo, String? searchWord, String? assetId}) {
    var data = """
query{
maintenanceIntervals(
  pageNumber:$pageNo,
  search:${searchWord == null ? "\"\"" : "${"\"" + searchWord + "\""}"},
  assetId:${assetId == null ? "\"\"" : "${"\"" + assetId + "\""}"}
){
  status,
  totalCount,
  intervalList{
    intervalName,
    intervalID,
    editable,
    firstOccurrences,
    editable,
    intervalDescription,
    checkList{
      checkListName,
      checkListDescription,
      checkListID,
      partList{
        description,
        units,
        partId,
        partName,
        quantity,
        partNo
      }
    }
  }
}
}""";
    return data;
  }

  String getPlantDashboardAndHierarchyListData(
      {int? limit,
      int? start,
      String? status,
      String? calendar,
      String? model}) {
    {
      var data = """query{
    frameSubscription{
        subscriptionFleetList(
             limit:${limit != null ? limit : null},
            start:${start != null ? start : null},
            status:"${status != null ? status : ""}",
             calendar:"${calendar != null ? calendar : ""}",
             model:"${model != null ? model : ""}"
            
        ){
            count,
            provisioningInfo{
              gpsDeviceID,
              model,
              vin
              productFamily,
              customerCode,
              dealerName,
              dealerCode,
              customerName,
              status,
              description,
              networkProvider,
              subscriptionStartDate,
              actualStartDate,
              subscriptionEndDate
              
      }
            }
            }
        }""";
      return data;
    }

    // String getPlantDashboardAndHierarchyCalendarListData(
    //     {int? limit, int? start, String? status}) {
    //   var data = """query{
    //   frameSubscription{
    //       subscriptionFleetList(
    //           limit:$limit,
    //           start:$start,
    //           calendar:"$status"

    //       ){
    //           count,
    //           provisioningInfo{
    //             gpsDeviceID,

    //             model,
    //             vin
    //             productFamily,
    //             customerCode,
    //             dealerName,
    //             dealerCode,
    //             customerName,
    //             status,
    //             description,
    //             networkProvider

    //     }

    //           }
    //           }
    //       }""";
    //   return data;
    // }
  }

  // String getPlantDashboardAndHierarchyCalendarListData(
  //     {int? limit, int? start, String? status}) {
  //   var data = """query{
  //   frameSubscription{
  //       subscriptionFleetList(
  //           limit:$limit,
  //           start:$start,
  //           calendar:"$status"

  //       ){
  //           count,
  //           provisioningInfo{
  //             gpsDeviceID,

  //             model,
  //             vin
  //             productFamily,
  //             customerCode,
  //             dealerName,
  //             dealerCode,
  //             customerName,
  //             status,
  //             description,
  //             networkProvider

  //     }

  //           }
  //           }
  //       }""";
  //   return data;
  // }

  addMaintenanceIntervals() {
    var data =
        """mutation createMaintenanceIntervals(\$intervalName: String, \$initialOccurence: Int, \$description: String, \$checklist: [createMaintenanceIntervals], \$assetId: String, \$serialNumber: String, \$make: String, \$model: String, \$currentHourMeter: Float, \$units: String) {
  createMaintenanceIntervals(intervalName: \$intervalName, initialOccurence: \$initialOccurence, description: \$description, checklist: \$checklist, assetId: \$assetId, serialNumber: \$serialNumber, make: \$make, model: \$model, currentHourMeter: \$currentHourMeter, units: \$units){
    status,
    message
  }
}
""";
    return data;
  }

  String getHierarchyListData(int? start, int? limit, dynamic type) {
    var data = """query{
   assetOrHierarchyByTypeAndId(
       start:$start,
       limit:$limit,
       type:$type
      
   ){
   name,
   userName,
   code,
   email
   }
   }""";
    return data;
  }

//   updateMaintenanceIntervals(MaintenanceIntervalData? mainInterval) {
//     var data = """
// mutation{
//   updateMaintenanceIntervals(
//     intervalList:${Utils.updateMaintenanceIntervals(mainInterval)}
//     checkList:${Utils.updateMaintenanceCheckList(mainInterval!.checkList) ?? []}){
//     status,
//      message
//   }
// }""";
//     return data;
//   }


 getSingleNotiFaultDescription(alertConfigId) {
    var query = """{
      getSingleFaultConfig(alertConfigId: ${alertConfigId == null ? "\"\"" : "${"\"" + alertConfigId + "\""}"}) {
        faults {
          faultDescription
          faultCodeType
          faultCodeIdentifier
        }
        responseStatus
      }
    }
  """;
    return query;
  }


  updateMaintenanceIntervals() {
    var data = """
mutation updateMaintenanceIntervals(\$intervalList: [intervalListObj], \$checkList: [checkListObj]) {
  updateMaintenanceIntervals(intervalList: \$intervalList, checkList: \$checkList) {
    status
    message
  }
}


 """;
    return data;
  }

  String getAssetcreationModelName(String? value) {
    var data = """query{
    assetModelByMachineSerialNumber(machineSerialNumber:"$value"){
        endRange,
        modelName,
        groupClusterId,
        startRange,
        startsWith
        }
    }""";
    return data;
  }

  deletingMaintenanceIntervals(
      {List<int>? interval,
      List<int>? check,
      List<int>? parts,
      String? assetId}) {
    var data = """
mutation{
 maintenanceIntervalsDelete(
  IntervaListIds:$interval,
  checkListIds:$check,
  partIds:$parts,
  assetId:${assetId == null ? "\"\"" : "${"\"" + assetId + "\""}"}
){
  status,
  message
}
}""";
    return data;
  }

  creatingPlantasset(
      List<AssetCreationModel> assetCreationListData, String userId) {
    List<Map<String, String>> getAssetPayLoad = [];

    for (var element in assetCreationListData) {
      if (element.assetSerialNo == "" &&
          element.deviceId == "" &&
          element.model == "" &&
          element.hourMeter == "") {
      } else {
        Map<String, String> asset = {
          "machineSerialNumber": "\"" + element.assetSerialNo! + "\"",
          "model": "\"" + element.model! + "\"",
          "deviceId": "\"" + element.deviceId! + "\"",
          "hmrValue": "\"" + element.hourMeter! + "\""
        };
        getAssetPayLoad.add(asset);
      }
    }

    var data = """mutation{
createAsset(
      request: {
      source: "THC",
      userID: ${int.parse(userId)},
      asset: $getAssetPayLoad
    }

){
    code,
    status,
    message,
    requestID,
    vin
}
}""";
    return data;
  }

  searchLocationSerialNumberData(
      {int? pageNumber, int? pageSize, String? query}) {
    var data = """query{
   assetLocation(pageNumber:$pageNumber,pageSize:$pageSize,snContains:"$query"){
       mapRecords{
           lastReportedLocationLatitude,
           lastReportedLocationLongitude,
           assetIcon,
           assetId,
           assetSerialNumber,
           model,
           makeCode,
           assetIdentifier,
           manufacturer
       }
   }
    
}""";
    return data;
  }

  searchLocationData(int? maxResult, String? query) {
    var data = """query{
 geofenceSearchLoaction(maxResults:$maxResult,query:"$query"){
     err,
     locations{
         coords{
             lat,
             lon
         },
         shortString
     }
 }
}""";
    return data;
  }

  notificationDashboardCount() {
    var data =
        """query (\$assetUIDs: String, \$productFamily: String, \$notificationStatus: Int, \$notificationUserStatus: Int) {
  seeAllNotificationCount(assetUIDs: \$assetUIDs, productFamily: \$productFamily, notificationStatus: \$notificationStatus, notificationUserStatus: \$notificationUserStatus) {
    notifications {
      count
      notificationSubType
      notificationType
    }
    status
  }
}
""";
    return data;
  }

  deleteNotes() {
    var data = """
mutation deleteMetaDataNotes(\$userAssetNoteUid: String!){
  deleteMetaDataNotes(userAssetNoteUid:\$userAssetNoteUid)
}""";
    return data;
  }

  singleAssetTransferIndustryData() {
    var data = """query{
    primarySecondaryIndustries{
        primaryIndustry,
        secondaryIndustries
        }
        }""";
    return data;
  }

  getSingleAssetFaulSummaryData(
      {String? assetUid, String? startDate, String? endDate}) {
    var data = """query{
    faultSummaryData(assetUid:"$assetUid",
    startDateTime:"$startDate",
    endDateTime:"$endDate"){
        summaryData{
            
            countData{
                assetCount,
                countOf,
                faultCount
            }
        }
    }
}""";
    return data;
  }

  resentInvitation() {
    var data = """query  Resend(\$resendID: String){
  resend(resendID: \$resendID){
    invitation_id,
    count,
    isInvitationSent,
    isUpdated
  }
}""";
    return data;
  }

  updateGroup() {
    var data = """
mutation updateGroups(\$groupUid: String, \$groupName: String, \$description: String, \$customerUID: String, \$associatedAssetUID: [String], \$dissociatedAssetUID: [String]){
  updateGroups(groupUid: \$groupUid, groupName: \$groupName, description: \$description, customerUID: \$customerUID, associatedAssetUID: \$associatedAssetUID, dissociatedAssetUID: \$dissociatedAssetUID){
    isUpdated
  }
}""";
    return data;
  }
}
