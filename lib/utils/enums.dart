enum ScreenType {
  ACCOUNT,
  HOME,
  DASHBOARD,
  FLEET,
  UTILIZATION,
  ASSET_OPERATION,
  ASSET_DETAIL,
  LOCATION,
  HEALTH,
  MAINTENANCE,
  ADMINISTRATION,
  PLANT,
  SUBSCRIPTION,
  NOTIFICATION,
  SEARCH
}

enum UtilizationGraphType {
  IDLEORWORKING,
  RUNTIMEHOURS,
  DISTANCETRAVELLED,
  CUMULATIVE,
  TOTALHOURS,
  TOTALFUELBURNED,
  IDLETREND,
  FUELBURNRATETREND
}

enum CumulativeChartType { RUNTIME, FUELBURNED }

enum IdlingLevelRange { DAY, WEEK, MONTH }

enum ErrorAction { LOGOUT, LOGIN }

enum DateRangeType {
  today,
  yesterday,
  currentWeek,
  previousWeek,
  lastSevenDays,
  lastThirtyDays,
  currentMonth,
  previousMonth,
  custom
}

enum CustomDatePick { customFromDate, customToDate, customNoDate }

enum SingleAssetUtilizationGraphType {
  IDLETIMEIDLEPERCENTAGE,
  RUNTIMEPERFORMANCEPERCENT,
  RUNTIMEHOURS,
  DISTANCETRAVELED
}

enum AccountType { ACCOUNT, CUSTOMER }

