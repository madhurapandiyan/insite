enum ScreenType {
  ACCOUNT,
  HOME,
  DASHBOARD,
  FLEET,
  UTILIZATION,
  ASSET_OPERATION,
  ASSET_DETAIL,
  ASSET_SETTINGS,
  ASSET_SETTINGS_FILTER,
  LOCATION,
  HEALTH,
  MAINTENANCE,
  ADMINISTRATION,
  USER_MANAGEMENT,
  PLANT,
  SUBSCRIPTION,
  NOTIFICATION,
  SEARCH,
  MANAGE_NOTIFICATION,
  ADD_NOTIFICATION,
  EDIT_NOTIFICATION
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

enum ProductFamilyType { ALL, BACKHOE_LOADER, EXCAVATOR }

enum AdminAssetsButtonType {
  ADDNEWUSER,
  MANAGEUSER,
  ADDNEWGROUPS,
  MANAGEGROUPS,
  ADDNEWGEOFENCES,
  MANAGEGEOFENCES,
  ADDNEWREPORT,
  MANAGEREPORTS,
  VIEWDASHBOARD,
  VIEWREGISTRATION,
  VIEWFLEETSTATUS,
  VIEWSMSMANAGEMENT,
  VIEWREPLACEMENT,
  VIEWTRANSFERHISTORY,
  SINGLEASSETREG,
  SINGLEASSETTRANSFER,
  MULTIPLEASSETREG,
  MULTIPLEASSESTTRANSFER,
  VIEWHIERACHY,
  SMSSCHEDULEFORSINGLEASSET,
  SMSSCHEDULEFORMUTLIPLEASSET,
  REPORTSUMMARYFORSMS,
  DEVICEREPLACEMENT,
  REPLACEMENTSTATUS,
  ADDNEWNOTIFICATION,
  MANAGENOTIFICATION
}

enum PLANTSUBSCRIPTIONFILTERTYPE { DATE, STATUS, MODEL, TYPE }

enum PLANTSUBSCRIPTIONDETAILTYPE {
  DEVICE,
  DEALER,
  CUSTOMER,
  PLANT,
  ASSET,
  TOBEACTIVATED
}
