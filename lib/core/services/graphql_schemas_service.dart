import 'package:insite/core/base/base_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:intl/intl.dart';

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
  faultdata(page: 1, limit: 100, startDateTime: $startDate, endDateTime: $endDate){
    
    faults{
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

  String getAssetFaultQuery(String startDate, String endDate) {
    final String assetFaultQuery = """
  query assetDataSummary{
  assetData(page: 1, limit: 100, startDateTime:$startDate, endDateTime: $endDate){
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
  assetOperationsDailyTotals(sort: "-assetid", startDate: $startDate, endDate: $endDate, pageSize: 50, pageNumber: 1){
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
faultCountData(startDateTime:$startDate, endDateTime: $endDate){
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

  String userManagementUserList() {
    return """query{
userManagementUserList{
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
    
  }
}
  
}""";
  }

  String getFleetUtilization(String startDate, String endDate) {
    final String fleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageSize:1,pageNumber:100, startDate: $startDate, endDate: $endDate){
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

  String getFleetLocationData(String startDate, String endDate) {
    final String fleetLocationData = """
  query fleetLocationDetails{
  fleetLocationDetails(pageNumber: 1, pageSize: 1000, assetIdentifier: "", sort: "assetid", startDateLocal: $startDate){
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
