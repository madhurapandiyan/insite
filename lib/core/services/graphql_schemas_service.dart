import 'package:insite/core/base/base_service.dart';

class GraphqlSchemaService extends BaseService {
  final String assetCount = """
query faultDataSummary{
 getDashboardAsset{
  countData{  
    count
    countOf
  }
}
  
}

  """;

  final String faultQueryString = """
  query faultDataSummary{
  faultdata(page: 1, limit: 100, startDateTime: "2021-12-13T00:00:00Z", endDateTime: "2021-12-15T23:59:59Z"){
    
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

  final String assetFaultQuery = """
  query assetDataSummary{
  assetData(page: 1, limit: 100, startDateTime: "2021-12-13T00:00:00Z", endDateTime: "2021-12-15T23:59:59Z"){
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

  final String assetOperationData = """
 query asetOperations{
  assetOperationsDailyTotals(sort: "-assetid", startDate: "12/20/2021", endDate: "12/20/2021", pageSize: 50, pageNumber: 1){
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
  final String getFaultCountData = """
  query getFaultCountData{
faultCountData(startDateTime: "2021-12-21T14:02:21.995Z", endDateTime: "2021-12-21T14:02:23.023Z"){
  countData {
    countOf
    assetCount
    faultCount
  }
}
}
  """;

  final String getFleetUtilization = """
  query getFleetUtilization{
	getfleetUtilization(pageSize:1,pageNumber:100, startDate: "2021-12-21T15:04:50.709Z", endDate: "2021-12-21T15:04:52.097Z"){
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

  final String getFleetLocationData = """
  query fleetLocationDetails{
  fleetLocationDetails(pageNumber: 1, pageSize: 1000, assetIdentifier: "", sort: "assetid", startDateLocal: "2021-11-29"){
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
}
