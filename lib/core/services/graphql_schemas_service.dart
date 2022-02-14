import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:logger/logger.dart';

class GraphqlSchemaService extends BaseService {
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

  final String assetStatusCount = """
query faultDataSummary{
 getDashboardAsset(grouping: "assetstatus"){
  countData{  
    count
    countOf
  }
}
  
}

  """;

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
<<<<<<< HEAD
  faultdata(page: 1, limit: 100, startDateTime: "2022-02-07T00:00:00Z", endDateTime: "2022-02-09T23:59:59Z"){
    limit
    total
		faults{
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
          dealerCode
          dealerCustomerName
          dealerName
          universalCustomerName
          devices {
            deviceType
            firmwareVersion
          }
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
=======
  faultdata(page: 1, limit: 100, startDateTime: "$startDate", endDateTime: "$endDate"){
    
    faults{
>>>>>>> 281c42d24b118937dccf349290d1666514798e50
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

  final String fleetSummary = """query fleetSummary{
  fleetSummary{
    links {
      prev
      next
      self
    }   
    pagination {
      totalAsset
      totalCount
      assetsWithoutActiveCoreSubscription
      pageNumber
      pageSize
    }
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
      lastReportedLocationLongitude
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
    }
    
  }
  
}


  """;

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
  final String utilizationTotalCount = """

  query utilizationTotalCount{
 utilizationTotal{
  countData {
    countOf
    count
  }
}
  
}
  """;

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

  String getFaultCountData(String startDate, String endDate) {
    final String faultCountData = """
  query getFaultCountData{
faultCountData(startDateTime:"$startDate", endDateTime: "$endDate"){
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

  String getFleetUtilization(String startDate, String endDate) {
    final String fleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageSize:1,pageNumber:100, startDate: "$startDate", endDate: "$endDate"){
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
}
