import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/cumulative.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/fuel_burn_rate_trend.dart';
import 'package:insite/core/models/idle_percent_trend.dart';
import 'package:insite/core/models/total_fuel_burned.dart';
import 'package:insite/core/models/total_hours.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class UtilizationGraphsService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  UtilizationGraphsService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<RunTimeCumulative> getRunTimeCumulative(
      String startDate, String endDate) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          RunTimeCumulative response = await MyApi()
              .getClient()
              .runtimeCumulativeVL(
                  startDate, endDate, accountSelected.CustomerUID);
          if (response != null) {
            return response;
          }
          return null;
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          RunTimeCumulative response = await MyApi()
              .getClient()
              .runtimeCumulative(startDate, endDate,
                  accountSelected.CustomerUID, Urls.vfleetPrefix);
          if (response != null) {
            return response;
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<FuelBurnedCumulative> getFuelBurnedCumulative(
      String startDate, String endDate) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          FuelBurnedCumulative response = await MyApi()
              .getClient()
              .fuelBurnedCumulativeVL(
                  startDate, endDate, accountSelected.CustomerUID);
          if (response != null) {
            return response;
          }
          return null;
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          FuelBurnedCumulative response = await MyApi()
              .getClient()
              .fuelBurnedCumulative(startDate, endDate,
                  accountSelected.CustomerUID, Urls.vfleetPrefix);
          if (response != null) {
            return response;
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<TotalHours> getTotalHours(
    String interval,
    String startDate,
    String endDate,
    int pageNumber,
    int pageSize,
    bool includepagination,
  ) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          TotalHours response = await MyApi().getClient().getTotalHoursVL(
                interval,
                startDate,
                endDate,
                pageNumber,
                pageSize,
                includepagination,
                accountSelected.CustomerUID,
              );
          if (response != null) {
            return response;
          }
          return null;
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          TotalHours response = await MyApi().getClient().getTotalHours(
              interval,
              startDate,
              endDate,
              pageNumber,
              pageSize,
              includepagination,
              accountSelected.CustomerUID,
              Urls.vfleetPrefix);
          if (response != null) {
            return response;
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<TotalFuelBurned> getTotalFuelBurned(
    String interval,
    String startDate,
    String endDate,
    int pageNumber,
    int pageSize,
    bool includepagination,
  ) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          TotalFuelBurned response =
              await MyApi().getClient().getTotalFuelBurnedVL(
                    interval,
                    startDate,
                    endDate,
                    pageNumber,
                    pageSize,
                    includepagination,
                    accountSelected.CustomerUID,
                  );
          if (response != null) {
            return response;
          }
          return null;
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          TotalFuelBurned response = await MyApi()
              .getClient()
              .getTotalFuelBurned(
                  interval,
                  startDate,
                  endDate,
                  pageNumber,
                  pageSize,
                  includepagination,
                  accountSelected.CustomerUID,
                  Urls.vfleetPrefix);
          if (response != null) {
            return response;
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<IdlePercentTrend> getIdlePercentTrend(
    String interval,
    String startDate,
    String endDate,
    int pageNumber,
    int pageSize,
    bool includepagination,
  ) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          IdlePercentTrend response =
              await MyApi().getClient().getIdlePercentTrendVL(
                    interval,
                    startDate,
                    endDate,
                    pageNumber,
                    pageSize,
                    includepagination,
                    accountSelected.CustomerUID,
                  );
          if (response != null) {
            return response;
          }
          return null;
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          IdlePercentTrend response = await MyApi()
              .getClient()
              .getIdlePercentTrend(
                  interval,
                  startDate,
                  endDate,
                  pageNumber,
                  pageSize,
                  includepagination,
                  accountSelected.CustomerUID,
                  Urls.vfleetPrefix);
          if (response != null) {
            return response;
          }
          return null;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<FuelBurnRateTrend> getFuelBurnRateTrend(
    String interval,
    String startDate,
    String endDate,
    int pageNumber,
    int pageSize,
    bool includepagination,
  ) async {
    try {
      if (isVisionLink) {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          FuelBurnRateTrend response =
              await MyApi().getClient().getFuelBurnRateTrendVL(
                    interval,
                    startDate,
                    endDate,
                    pageNumber,
                    pageSize,
                    includepagination,
                    accountSelected.CustomerUID,
                  );
          if (response != null) {
            return response;
          } else {
            return null;
          }
        }
      } else {
        if (startDate != null &&
            startDate.isNotEmpty &&
            endDate != null &&
            endDate.isNotEmpty) {
          FuelBurnRateTrend response = await MyApi()
              .getClient()
              .getFuelBurnRateTrend(
                  interval,
                  startDate,
                  endDate,
                  pageNumber,
                  pageSize,
                  includepagination,
                  accountSelected.CustomerUID,
                  Urls.vfleetPrefix);
          if (response != null) {
            return response;
          } else {
            return null;
          }
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
