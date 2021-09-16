import 'package:insite/core/models/filter_data.dart';
import 'package:logger/logger.dart';
import 'enums.dart';

class FilterUtils {
  static String getFilterURL(
      startDate,
      endDate,
      pageNumber,
      pageSize,
      customerId,
      sort,
      List<FilterData> appliedFilters,
      ScreenType screenType) {
    try {
      StringBuffer value = StringBuffer();
      if (screenType == ScreenType.HEALTH) {
        if (pageNumber != null) {
          value.write(constructQuery("page", pageNumber.toString(), true));
        }
        if (pageSize != null) {
          if (pageNumber == null) {
            value.write(constructQuery("limit", pageSize.toString(), true));
          } else {
            value.write(constructQuery("limit", pageSize.toString(), false));
          }
        }
      } else {
        if (pageNumber != null) {
          value
              .write(constructQuery("pageNumber", pageNumber.toString(), true));
        }
        if (pageSize != null) {
          if (pageNumber == null) {
            value.write(constructQuery("pageSize", pageSize.toString(), true));
          } else {
            value.write(constructQuery("pageSize", pageSize.toString(), false));
          }
        }
      }
      if (sort != null) {
        if (screenType != ScreenType.FLEET &&
            screenType != ScreenType.LOCATION) {
          if (screenType == ScreenType.ASSET_OPERATION) {
            value.write(constructQuery("startdate", startDate, false));
            value.write(constructQuery("enddate", endDate, false));
          } else if (screenType == ScreenType.HEALTH) {
            value.write(constructQuery("startDateTime", startDate, false));
            value.write(constructQuery("endDateTime", endDate, false));
          } else {
            value.write(constructQuery("startDate", startDate, false));
            value.write(constructQuery("endDate", endDate, false));
          }
        }
        if (screenType == ScreenType.HEALTH) {
          value.write(constructQuery("langDesc", sort, false));
        } else {
          value.write(constructQuery("sort", sort, false));
        }
      }
      if (screenType == ScreenType.FLEET || screenType == ScreenType.LOCATION) {
        if (customerId != null) {
          value.write(constructQuery("customerIdentifier", customerId, false));
        }
      } else {
        if (customerId != null) {
          value.write(constructQuery("customerUID", customerId, false));
        }
      }
      if (appliedFilters.isNotEmpty) {
        // manufacturer
        List<FilterData> makeList = appliedFilters
            .where((element) => element.type == FilterType.MAKE)
            .toList();
        Logger().i("filter makeList " + makeList.length.toString());
        if (makeList.isNotEmpty) {
          for (FilterData data in makeList) {
            value.write(constructQuery("manufacturer", data.title, false));
          }
        }
        // productfamily
        List<FilterData> productFamilyList = appliedFilters
            .where((element) => element.type == FilterType.PRODUCT_FAMILY)
            .toList();
        Logger().i(
            "filter productFamilyList " + productFamilyList.length.toString());
        if (productFamilyList.isNotEmpty) {
          for (FilterData data in productFamilyList) {
            value.write(constructQuery("productfamily", data.title, false));
          }
        }
        // model
        List<FilterData> productModelList = appliedFilters
            .where((element) => element.type == FilterType.MODEL)
            .toList();
        Logger()
            .i("filter productModelList " + productModelList.length.toString());
        if (productModelList.isNotEmpty) {
          for (FilterData data in productModelList) {
            value.write(constructQuery("model", data.title, false));
          }
        }
        // subscription
        List<FilterData> productSubscriptionList = appliedFilters
            .where((element) => element.type == FilterType.SUBSCRIPTION_DATE)
            .toList();
        Logger().i("filter productSubscriptionList " +
            productSubscriptionList.length.toString());
        if (productSubscriptionList.isNotEmpty) {
          for (FilterData data in productModelList) {
            value.write(constructQuery("subscription", data.title, false));
          }
        }
        // assetstatus
        List<FilterData> productAssetstatusList = appliedFilters
            .where((element) => element.type == FilterType.ALL_ASSETS)
            .toList();
        Logger().i("filter productAssetstatusList " +
            productAssetstatusList.length.toString());
        if (productAssetstatusList.isNotEmpty) {
          for (FilterData data in productAssetstatusList) {
            value.write(constructQuery("assetstatus", data.title, false));
          }
        }
        // deviceType
        List<FilterData> productDeviceTypeList = appliedFilters
            .where((element) => element.type == FilterType.DEVICE_TYPE)
            .toList();
        Logger().i("filter productDeviceTypeList " +
            productDeviceTypeList.length.toString());
        if (productDeviceTypeList.isNotEmpty) {
          for (FilterData data in productDeviceTypeList) {
            value.write(constructQuery("deviceType", data.title, false));
          }
        }
        // fuelLevel
        List<FilterData> fuleLevelList = appliedFilters
            .where((element) => element.type == FilterType.FUEL_LEVEL)
            .toList();
        Logger().i("filter fuleLevelList " + fuleLevelList.length.toString());
        if (fuleLevelList.isNotEmpty) {
          for (FilterData data in fuleLevelList) {
            if (data.title == "100") {
              value.write(
                  constructQuery("fuelLevelPercentLTE", data.title, false));
            } else {
              value.write(
                  constructQuery("fuelLevelPercentLT", data.title, false));
            }
          }
        }

        // idlingLevel
        if (screenType != ScreenType.HEALTH) {
          List<FilterData> idlingLevelList = appliedFilters
              .where((element) => element.type == FilterType.IDLING_LEVEL)
              .toList();
          Logger()
              .i("filter idlingLevelList " + idlingLevelList.length.toString());
          if (idlingLevelList.isNotEmpty) {
            for (FilterData data in idlingLevelList) {
              if (data.extras.isNotEmpty) {
                Logger().d("idling level extras 0 ", data.extras[0]);
                Logger().d("idling level extras 1", data.extras[1]);
                if (data.extras[1].isEmpty) {
                  if (screenType == ScreenType.ASSET_OPERATION) {
                    value.write(constructQuery(
                        "IdleEfficiency.GT", data.extras[0], false));
                  } else {
                    value.write(constructQuery(
                        "idleEfficiencyGT", data.extras[0], false));
                  }
                } else {
                  if (screenType == ScreenType.ASSET_OPERATION) {
                    value.write(constructQuery(
                        "IdleEfficiency.GT", data.extras[0], false));
                    value.write(constructQuery(
                        "IdleEfficiency.LTE", data.extras[1], false));
                  } else {
                    value.write(constructQuery(
                        "idleEfficiencyGT", data.extras[0], false));
                    value.write(constructQuery(
                        "idleEfficiencyLTE", data.extras[1], false));
                  }
                }
              }
            }
            if (screenType == ScreenType.FLEET ||
                screenType == ScreenType.LOCATION) {
              value.write(constructQuery("startDateLocal", startDate, false));
              value.write(constructQuery("endDateLocal", endDate, false));
            }
          }
        }

        if (screenType == ScreenType.HEALTH) {
          // severity
          List<FilterData> severityList = appliedFilters
              .where((element) => element.type == FilterType.SEVERITY)
              .toList();
          Logger().i("filter severityList " + severityList.length.toString());
          if (severityList.isNotEmpty) {
            for (FilterData data in severityList) {
              value.write(constructQuery("severity", data.title, false));
            }
          }
        }

        // location clustor
        List<FilterData> locationClustorList = appliedFilters
            .where((element) => element.type == FilterType.CLUSTOR)
            .toList();
        Logger().i("filter locationClustorList " +
            locationClustorList.length.toString());
        if (locationClustorList.isNotEmpty) {
          for (FilterData data in locationClustorList) {
            if (data.extras.isNotEmpty) {
              Logger().d("location clustor extras 0 ", data.extras[0]);
              Logger().d("location clustor extras 1", data.extras[1]);
              Logger().d("location clustor extras 2", data.extras[2]);
              value.write(constructQuery("latitude", data.extras[0], false));
              value.write(constructQuery("longitude", data.extras[1], false));
              value.write(constructQuery("radiuskm", data.extras[2], false));
            }
          }
        }
        if (locationClustorList.isEmpty) {
          // location search
          List<FilterData> locationSearchList = appliedFilters
              .where((element) => element.type == FilterType.LOCATION_SEARCH)
              .toList();
          Logger().i("filter locationSearchList " +
              locationSearchList.length.toString());
          if (locationSearchList.isNotEmpty) {
            for (FilterData data in locationSearchList) {
              if (data.extras.isNotEmpty) {
                Logger().d("location search extras 0 ", data.extras[0]);
                Logger().d("location search extras 1", data.extras[1]);
                Logger().d("location search extras 2", data.extras[2]);
                value.write(constructQuery("latitude", data.extras[0], false));
                value.write(constructQuery("longitude", data.extras[1], false));
                value.write(constructQuery("radiuskm", data.extras[2], false));
              }
            }
          }
        }
      }
      return value.toString();
    } catch (e) {
      StringBuffer value = StringBuffer();
      value.write(constructQuery("pageNumber", pageNumber.toString(), true));
      value.write(constructQuery("pageSize", pageSize.toString(), false));
      if (screenType != ScreenType.FLEET && screenType != ScreenType.LOCATION) {
        if (screenType == ScreenType.ASSET_OPERATION) {
          if (sort != null) {
            value.write(constructQuery("startdate", startDate, false));
          }
          if (sort != null) {
            value.write(constructQuery("enddate", endDate, false));
          }
        } else {
          if (sort != null) {
            value.write(constructQuery("startDate", startDate, false));
          }
          if (sort != null) {
            value.write(constructQuery("endDate", endDate, false));
          }
        }
      }
      if (sort != null) {
        value.write(constructQuery("sort", sort, false));
      }
      if (screenType == ScreenType.FLEET || screenType == ScreenType.LOCATION) {
        if (customerId != null) {
          value.write(constructQuery("customerIdentifier", customerId, false));
        }
      } else {
        if (customerId != null) {
          value.write(constructQuery("customerUID", customerId, false));
        }
      }
      return value.toString();
    }
  }

  static String getFilterURLForCount(startDate, endDate, customerId, sort,
      List<FilterData> appliedFilters, ScreenType screenType) {
    try {
      StringBuffer value = StringBuffer();
      if (sort != null) {
        value.write(constructQuery("startDate", startDate, true));
      }
      if (sort != null) {
        value.write(constructQuery("endDate", endDate, false));
      }
      if (customerId != null) {
        value.write(constructQuery("customerUID", customerId, false));
      }
      if (appliedFilters.isNotEmpty) {
        // manufacturer
        List<FilterData> makeList = appliedFilters
            .where((element) => element.type == FilterType.MAKE)
            .toList();
        Logger().i("filter makeList " + makeList.length.toString());
        if (makeList.isNotEmpty) {
          for (FilterData data in makeList) {
            value.write(constructQuery("manufacturer", data.title, false));
          }
        }
        // productfamily
        List<FilterData> productFamilyList = appliedFilters
            .where((element) => element.type == FilterType.PRODUCT_FAMILY)
            .toList();
        Logger().i(
            "filter productFamilyList " + productFamilyList.length.toString());
        if (productFamilyList.isNotEmpty) {
          for (FilterData data in productFamilyList) {
            value.write(constructQuery("productfamily", data.title, false));
          }
        }
        // model
        List<FilterData> productModelList = appliedFilters
            .where((element) => element.type == FilterType.MODEL)
            .toList();
        Logger()
            .i("filter productModelList " + productModelList.length.toString());
        if (productModelList.isNotEmpty) {
          for (FilterData data in productModelList) {
            value.write(constructQuery("model", data.title, false));
          }
        }
        // subscription
        List<FilterData> productSubscriptionList = appliedFilters
            .where((element) => element.type == FilterType.SUBSCRIPTION_DATE)
            .toList();
        Logger().i("filter productSubscriptionList " +
            productSubscriptionList.length.toString());
        if (productSubscriptionList.isNotEmpty) {
          for (FilterData data in productModelList) {
            value.write(constructQuery("subscription", data.title, false));
          }
        }
        // assetstatus
        List<FilterData> productAssetstatusList = appliedFilters
            .where((element) => element.type == FilterType.ALL_ASSETS)
            .toList();
        Logger().i("filter productAssetstatusList " +
            productAssetstatusList.length.toString());
        if (productAssetstatusList.isNotEmpty) {
          for (FilterData data in productAssetstatusList) {
            value.write(constructQuery("assetstatus", data.title, false));
          }
        }
        // deviceType
        List<FilterData> productDeviceTypeList = appliedFilters
            .where((element) => element.type == FilterType.DEVICE_TYPE)
            .toList();
        Logger().i("filter productDeviceTypeList " +
            productDeviceTypeList.length.toString());
        if (productDeviceTypeList.isNotEmpty) {
          for (FilterData data in productAssetstatusList) {
            value.write(constructQuery("deviceType", data.title, false));
          }
        }
        // fuelLevel
        List<FilterData> fuleLevelList = appliedFilters
            .where((element) => element.type == FilterType.FUEL_LEVEL)
            .toList();
        Logger().i("filter fuleLevelList " + fuleLevelList.length.toString());
        if (fuleLevelList.isNotEmpty) {
          for (FilterData data in fuleLevelList) {
            if (data.title == "100") {
              value.write(
                  constructQuery("fuelLevelPercentLTE", data.title, false));
            } else {
              value.write(
                  constructQuery("fuelLevelPercentLT", data.title, false));
            }
          }
        }

        // idlingLevel
        List<FilterData> idlingLevelList = appliedFilters
            .where((element) => element.type == FilterType.IDLING_LEVEL)
            .toList();
        Logger()
            .i("filter idlingLevelList " + idlingLevelList.length.toString());
        if (idlingLevelList.isNotEmpty) {
          for (FilterData data in idlingLevelList) {
            if (data.extras.isNotEmpty) {
              Logger().d("idling level extras 0 ", data.extras[0]);
              Logger().d("idling level extras 1", data.extras[1]);
              if (data.extras[1].isEmpty) {
                // idleEfficiencyRanges
                value.write(constructQuery(
                    "idleEfficiencyRanges", data.extras[0], false));
                // value.write(
                //     constructQuery("IdleEfficiency.GT", data.extras[0], false));
              } else {
                value.write(constructQuery("idleEfficiencyRanges",
                    "${data.extras[0]},${data.extras[1]}", false));
                // value.write(
                //     constructQuery("IdleEfficiency.GT", data.extras[0], false));
                // value.write(constructQuery(
                //     "IdleEfficiency.LTE", data.extras[1], false));
              }
            }
          }
        }
        // location clustor
        List<FilterData> locationClustorList = appliedFilters
            .where((element) => element.type == FilterType.CLUSTOR)
            .toList();
        Logger().i("filter locationClustorList " +
            locationClustorList.length.toString());
        if (locationClustorList.isNotEmpty) {
          for (FilterData data in locationClustorList) {
            if (data.extras.isNotEmpty) {
              Logger().d("location clustor extras 0 ", data.extras[0]);
              Logger().d("location clustor extras 1", data.extras[1]);
              Logger().d("location clustor extras 2", data.extras[2]);
              value.write(constructQuery("latitude", data.extras[0], false));
              value.write(constructQuery("longitude", data.extras[1], false));
              value.write(constructQuery("radiuskm", data.extras[2], false));
            }
          }
        }
        if (locationClustorList.isEmpty) {
          // location search
          List<FilterData> locationSearchList = appliedFilters
              .where((element) => element.type == FilterType.LOCATION_SEARCH)
              .toList();
          Logger().i("filter locationSearchList " +
              locationSearchList.length.toString());
          if (locationSearchList.isNotEmpty) {
            for (FilterData data in locationSearchList) {
              if (data.extras.isNotEmpty) {
                Logger().d("location search extras 0 ", data.extras[0]);
                Logger().d("location search extras 1", data.extras[1]);
                Logger().d("location search extras 2", data.extras[2]);
                value.write(constructQuery("latitude", data.extras[0], false));
                value.write(constructQuery("longitude", data.extras[1], false));
                value.write(constructQuery("radiuskm", data.extras[2], false));
              }
            }
          }
        }
      }
      List<int> assetOperationlist = [
        1,
        6,
        5,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31
      ];
      List<int> utilizationlist = [
        1,
        6,
        5,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        37
      ];
      if (screenType == ScreenType.UTILIZATION) {
        for (int id in utilizationlist) {
          value.write(constructQuery("subscriptionId", id.toString(), false));
        }
      } else {
        for (int id in assetOperationlist) {
          value.write(constructQuery("subscriptionId", id.toString(), false));
        }
      }
      return value.toString();
    } catch (e) {
      Logger().e(e);
      StringBuffer value = StringBuffer();
      if (sort != null) {
        value.write(constructQuery("startDate", startDate, false));
      }
      if (sort != null) {
        value.write(constructQuery("endDate", endDate, false));
      }
      if (customerId != null) {
        value.write(constructQuery("customerUID", customerId, false));
      }
      List<int> list = [1, 6, 5, 23, 24, 25, 26, 27, 28, 29, 30, 31];
      for (int id in list) {
        value.write(constructQuery("subscriptionId", id.toString(), false));
      }
      return value.toString();
    }
  }

  static String constructQuery(key, value, isFirst) {
    if (isFirst) {
      return "?" + key + "=" + value;
    } else {
      return "&" + key + "=" + value;
    }
  }

  static String justConstructQuery(key, value) {
    return "&" + key + "=" + value;
  }

  static String constructQueryFromMap(Map<String, String> map) {
    StringBuffer urlString = StringBuffer();
    map.forEach((key, value) {
      urlString.write(justConstructQuery(key, value));
    });
    return urlString.toString();
  }
}
