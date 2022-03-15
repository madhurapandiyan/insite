import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:logger/logger.dart';

class GraphqlSchemaService extends BaseService {
  String? productFamily;
  String? model;
  String? assetStatus;
  String? fuelLevelPercentLt;
  String? idleEficiencyGT;
  String? idleEfficiencyLTE;
  String? assetIDContains;
  String? snContains;
  String? location;

  Future gettingFiltersValue(List<FilterData?>? filtlerList) async {
    productFamily = null;
    assetStatus = null;
    model = null;
    fuelLevelPercentLt = null;
    filtlerList!.forEach((filterData) {
      if (filterData?.type == FilterType.ALL_ASSETS) {
        var data = filtlerList
            .where((element) => element?.type == FilterType.ALL_ASSETS)
            .toList();
        assetStatus = Utils.getFilterData(data, filterData!.type!);
      } else if (filterData?.type == FilterType.PRODUCT_FAMILY) {
        var data = filtlerList
            .where((element) => element?.type == FilterType.PRODUCT_FAMILY)
            .toList();
        productFamily = Utils.getFilterData(data, filterData!.type!);
      } else if (filterData?.type == FilterType.MODEL) {
        var data = filtlerList
            .where((element) => element?.type == FilterType.MODEL)
            .toList();
        model = Utils.getFilterData(data, filterData!.type!);
      } else if (filterData?.type == FilterType.FUEL_LEVEL) {
        var data = filtlerList
            .where((element) => element?.type == FilterType.FUEL_LEVEL)
            .toList();
        fuelLevelPercentLt = Utils.getFilterData(data, filterData!.type!);
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
      geofences
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
  String utilizationToatlCount(String startDate, String endDate) {
    final String utilizationTotalCount = """

  query {
 utilizationTotal(
    startDate: "$startDate",
  EndDate:"$endDate"
  
){
  countData {
    countOf
    count
  }
}
}
  """;
    return utilizationTotalCount;
  }

  String getAssetOperationData(String startDate, String endDate) {
    final String assetOperationData = """
 query asetOperations{
  assetOperationsDailyTotals(sort: "-assetid", startDate:"$startDate", endDate:"$endDate", pageSize: 50, pageNumber: 1){
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

  String userManagementUserList(String? searchKey) {
    return """query{
userManagementUserList(searchKey:"$searchKey"){
  total{
    pages
    items
  },
  users{
    first_name
    last_name
    user_type
    loginId
    job_type
    job_title
    userUid
    lastLoginDate
  }
}
  
}""";
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

  String getFleetUtilization(
      String startDate, String endDate, int pageSize, int pageNo) {
    final String fleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageSize:$pageSize,pageNumber:$pageNo, startDate: "$startDate", endDate: "$endDate"){
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

  String getFleetLocationData(String startDate, String endDate) {
    final String fleetLocationData = """
  query fleetLocationDetails{
  fleetLocationDetails(pageNumber: 1, pageSize: 1000, assetIdentifier: "", sort: "assetid", startDateLocal: "$startDate"){
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
        assetUid: "9798351c-c1d9-11eb-82df-0ae8ba8d3970",
    endDate: "2022-03-07",
    includeNonReportedDays: "true",
    includeOutsideLastReportedDay: "true",
    sort: "-LastReportedUtilizationTime",
    startDate: "2022-03-07",
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
{
  fleetFiltersGrouping(grouping: "$grouping") {
    countData {
      countOf
      count
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
      String startDate, String endDate, String assetId) {
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

  String singleAssetDetailLocation() {
    var data = """
query{
  singleAssetLocationDetails(
       pageNumber: 1,
    pageSize: 50,
    assetIdentifier: "9798351c-c1d9-11eb-82df-0ae8ba8d3970",
    startTimeLocal: "02/10/2022 00:00:00",
    endTimeLocal: "03/11/2022 23:59:59"
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
}
