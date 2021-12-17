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
}
