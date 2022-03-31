import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class GraphqlSchemaService extends BaseService {
  GraphqlSchemaService._internal() {
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
    String doubleQuote = "\"";
    var data = filtlerList!.where((element) => element?.type == type).toList();
    data.forEach((element) {
      if (assetstatusList.contains(element)) {
      } else {
        individualList!.add(doubleQuote + element!.title! + doubleQuote);
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
  }

  Future gettingLocationFilter(List<FilterData?>? filtlerList) async {
    String doubleQuote = "\"";

    if (filtlerList!.isNotEmpty) {
      getIndividualList(
          filtlerList: filtlerList,
          individualList: assetstatusList,
          type: FilterType.ASSET_STATUS);
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
    }
  }

  Future gettingFiltersValue(List<FilterData?>? filtlerList) async {
    filtlerList!.forEach((filterData) {
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
      }
    });
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
  String getfaultQueryString(String startDate, String endDate) {
    final String faultQueryString = """
  query faultDataSummary{
  faultdata(page: 1, limit: 100, startDateTime: "$startDate", endDateTime: "$endDate"){
    
    faults{
      details {
        faultCode
        faultReceivedUTC
        dataLinkType
        occurrences
        url
      }
    }}
}
  """;
    return faultQueryString;
  }

  String getAssetFaultQuery(String startDate, String endDate) {
    final String assetFaultQuery = """
  query assetDataSummary{
  assetData(page: 1, limit: 100, startDateTime:"$startDate", endDateTime: "$endDate"){
    pageLinks {
      rel
      href
      method
    }
    assetFaults{
      asset {
        uid
        basic {
          serialNumber
        }
        details {
          makeCode
          model
          productFamily
          assetIcon
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
      countData {
        countOf
        count
      }
    }
    page
    limit
    total
  }
}
  """;
    return assetFaultQuery;
  }

  fleetSummary(List<FilterData?>? applyFilter, pagenumber) async {
    await gettingFiltersValue(applyFilter);
    var data = """{
  fleetSummary(pageNumber:$pagenumber,
    pageSize:50,
    sort:"AssetSerialNumber",
    productfamily:${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"},
    model:${model == null ? "\"\"" : "${"\"" + model! + "\""}"},
    assetstatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"},
    fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"},
    idleEfficiencyGT:"",
    idleEfficiencyLTE:"",
    assetIDContains:"",
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
      notifications
      assetId
      customStateDescription
      modelYear
      dealerCustomerNumber
      dealerCode
      dealerName
      fuelLevelLastReported
      lastReportedLocationLatitude
      universalCustomerIdentifier
      universalCustomerName
      source
      hourMeter
      lifetimeFuelLiters
      lastLocationUpdateUTC
      lastPercentFuelRemainingTime
      percentDEFRemaining
      lastPercentDEFRemainingTime
      fuelReportedTime
      lastPercentFuelRemainingUTC
      esn
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
    await gettingFiltersValue(applyFilter);
    final String utilizationTotalCount = """
{
  utilizationTotal(
    productfamily: ${productFamily == null ? "\"\"" : "${"\"" + productFamily! + "\""}"}, 
  model:${model == null ? "\"\"" : "${"\"" + model! + "\""}"}, 
  manufacturer:${manufacturer == null ? "\"\"" : "${"\"" + manufacturer! + "\""}"}, 
  assetstatus:${assetStatus == null ? "\"\"" : "${"\"" + assetStatus! + "\""}"}, 
  fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}, 
  idleEfficiencyGT:${idleEficiencyGT == null ? "\"\"" : "${"\"" + idleEficiencyGT! + "\""}"}, 
  idleEfficiencyLTE: "", 
  idleEfficiencyRanges: "", 
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
idleEfficiencyGT:${idleEficiencyGT == null ? "\"\"" : "${"\"" + idleEficiencyGT! + "\""}"},
idleEfficiencyLTE: "",
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
faultCountData(startDateTime:"${startDate == null ? "" : startDate}", endDateTime: "${endDate == null ? "" : endDate}",productFamily:"${productFamily == null ? "" : prodFamily}"){
  countData {
    countOf
    assetCount
    faultCount
  }
}
}
  """;
    Logger().w(faultCountData);
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
  users: $usersId,
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
    await gettingFiltersValue(applyFilter);
    final String fleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageNumber: $pageNo, 
  pageSize: $pageSize , 
  sort: ${sort == null ? "\"\"" : "${"\"" + sort + "\""}"}, 
  startDate: "$startDate", 
  endDate: "$endDate", 
  idleEfficiencyGT: "", 
  fuelLevelPercentLT:${fuelLevelPercentLt == null ? "\"\"" : "${"\"" + fuelLevelPercentLt! + "\""}"}, 
  idleEfficiencyLTE: "", 
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

  String addUser(
      {String? firstName,
      String? lastName,
      String? emailId,
      String? phoneNo,
      AddressData? addressData,
      List<Role>? role,
      String? customerUid,
      int? jobType,
      Details? details}) {
    String doubleQuote = "\"";
    List<Map<String, dynamic>> roleData = [];
    role!.forEach((element) {
      roleData.add({
        "role_id": element.role_id,
        "application_name": element.application_name
      });
    });
    final String addUserData = """mutation {
  userManagementCreateUser(requestBody: {fname: ${doubleQuote + firstName! + doubleQuote}, lname: ${doubleQuote + lastName! + doubleQuote}, email: ${doubleQuote + emailId! + doubleQuote}, 
      JobType:$jobType,
    address: ${addressData!.toJson()}, 
      details:{
        user_type: "Standard"
      }, 
      roles: $roleData, 
      customerUid: "$customerUid", 
      isAssetSecurityEnabled: true
      }) {
    count
    invitation_id
  }
}""";
    print(addUserData);
    return addUserData;
  }

  String getAccountHierarchy() {
    String getAccountHierarchyData = """query {
accountHierarchy(targetcustomeruid:"",toplevelsonly:"true"){
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

  String getSubAccountHeirachryData(String data) {
    var schema = """query {
accountHierarchy(targetcustomeruid:"$data"){
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
      int? pageSize}) async {
    await clearAllList();
    if (filtlerList != null) {
      await gettingLocationFilter(filtlerList);
    }

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
      dailyreportedtimeTypes
      
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

  String singleAssetDetailLocation(String startDate, String endDate) {
    var data = """
query{
  singleAssetLocationDetails(
       pageNumber: 1,
    pageSize: 50,
    assetIdentifier: "9798351c-c1d9-11eb-82df-0ae8ba8d3970",
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

  String assetLocationData({String? no, String? pageSize, String? sort}) {
    var data = """
query{
  assetLocation(pageNumber:$no,pageSize:$pageSize,sort:"$sort"){
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
      {int? reportCategoryID,
      int? reportFormat,
      String? reportTitle,
      String? reportScheduledDate,
      String? reportStartDate,
      String? reportEndDate,
      String? emailSubject,
      List? emailRecipients,
      String? emailContent,
      String? svcMethod,
      bool? allAssets,
      dynamic svcbody,
      String? queryUrl,
      List? reportColumns,
      String? reportType}) {
    var addReportPayLoad = """ mutation{
  createNotificationReport(
      assetFilterCategoryID: 1,
    reportCategoryID: 0,
  reportFormat: $reportFormat,
    reportPeriod:1,
    reportTitle: "$reportTitle",
  reportScheduledDate: "$reportScheduledDate",
    reportStartDate:"$reportStartDate",
    emailSubject:"$emailSubject",
    emailRecipients:$emailRecipients,
    svcMethod: "$svcMethod",
    allAssets: false,
    filterOptions: [],
    filterTag: [],
    queryUrl: "$queryUrl",
    reportType: "$reportType",
    reportColumns:${Utils.getStringListData(reportColumns!)},
    svcbody:$svcbody,
    reportEndDate: "$reportEndDate"
    ){
    status,
    msg,
    reportUid
  }
}""";
    Logger().w(addReportPayLoad);
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
      reportSourcePageName,
        reportTitle,
      reportPeriod
    }
  }
}""";
    return getReportData;
  }

  String getEditReportsaveData({
    String? reportUid,
    String? emailSubject,
    List? emailRecipients,
    String? queryUrl,
    List? svcbody,
    String? emailContent,
    String? reportTitle,
    String? reportEndDate,
  }) {
    var editSaveData = """mutation{
  updateNotificationReport(reportUid:"$reportUid",
    reportPeriod:1,
    emailSubject:"$emailSubject",
    emailRecipients:$emailRecipients ,
    queryUrl:"$queryUrl",
    svcbody:$svcbody,
    emailContent:"$emailContent",
    assetFilterCategoryID:1,
    allAssets:false,
    filterTag:[],
    filterOptions:[],  
    reportTitle:"$reportTitle",
    reportEndDate:"$reportEndDate",
    
    
  ){
    status,
    reqId
  }
}""";
    return editSaveData;
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
}
