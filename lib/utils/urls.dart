import 'package:logger/logger.dart';

class Urls {
  static String unifiedFleetBaseUrl =
      "https://cloud.api.trimble.com/CTSPulseIndiastg";
  static String unifiedServiceBaseUrl =
      "https://unifiedservice.myvisionlink.com";

  static String administratorBaseUrl = "https://administrator.myvisionlink.com";
  static String idTokenBaseUrl = "https://id.trimble.com";
  static String idTokenBaseUrlStaging = "https://stage.id.trimblecloud.com";

  static String idTokenKey =
      "Basic MTMwNTEwYmQtOGE5MC00Mjc4LWI5N2EtZDgxMWRmNDRlZjEwOmJmM2UzYmI4MGE3ODQ2Yjg5ZTFhMWU1Mzc5NDUxMmEw";
  static String idTokenKeyStaging =
      "Basic N2JlNzU5YjEtYWZjNS00YTRhLThhODYtYmRhNWUwNDVhNTA4OjY3NjdkYTcxZDliMzQ1YzM4ODZhZWExMmE4ZjNmNmZl";

  static String unifiedFleetloginUrlTataHitachi =
      "https://identity.trimble.com/i/oauth2/authorize?scope=openid&response_type=token&redirect_uri=" +
          "https://unifiedfleet.myvisionlink.com" +
          "&client_id=" +
          "2JkDsLlgBWwDEdRHkUiaO9TRWMYa" +
          "&state=https://unifiedfleet.myvisionlink.com/tatahitachi/&nonce=1&t=DCCCF741-6BC4-436D-A4D5-68C6D3403573";

  static String unifiedFleetloginUrl =
      "https://identity.trimble.com/i/oauth2/authorize?scope=openid&response_type=token&redirect_uri=" +
          "https://unifiedfleet.myvisionlink.com" +
          "&client_id=" +
          "2JkDsLlgBWwDEdRHkUiaO9TRWMYa" +
          "&state=https://unifiedfleet.myvisionlink.com/&nonce=1";

  static String unifiedServiceloginUrl =
      "https://identity.trimble.com/i/oauth2/authorize?scope=openid&response_type=token&redirect_uri=" +
          "https://unifiedservice.myvisionlink.com" +
          "&client_id=" +
          "bdt0z_P8GGeiQERDwrksFxRHBvQa" +
          "&state=https://unifiedservice.myvisionlink.com/&nonce=1";

  static String administratorloginUrl =
      "https://identity.trimble.com/i/oauth2/authorize?scope=openid&response_type=token&redirect_uri=" +
          "https://administrator.myvisionlink.com" +
          "&client_id=" +
          "h3siCLfKlDG1Tzf0OTGBCgeldj0a" +
          "&state=https://administrator.myvisionlink.com/&nonce=1";

  static String administratorloginUrlVl =
      "https://id.trimble.com/oauth/authorize?" +
          "scope=openid%20Prod-VisionLinkAdministrator" +
          "&response_type=code" +
          "&redirect_uri=https%3A%2F%2Fadministrator.myvisionlink.com" +
          "&client_id=af2b03d0-7b27-41eb-8a3a-95b89d20f78d" +
          "&state=https%3A%2F%2Fadministrator.myvisionlink.com%2F" +
          "&code_challenge=filkDAKM7ulLU4kUw9OqF492fdl2rGn3CCPPcI6HO5I&nonce=1" +
          "&code_challenge_method=S256";

  //sample
  static getV4LoginUrlVL(state, codeChallenge) {
    Logger().i("visionLink");
    String url = "https://id.trimble.com/oauth/authorize?" +
        "scope=openid $visionLinkApplicationName" +
        "&response_type=code" +
        "&redirect_uri=$administratorBaseUrl"
            "&client_id=$visionLinkClientId&state=$state" +
        "&code_challenge=$codeChallenge&nonce=1" +
        "&code_challenge_method=S256";
    return url;
  }

  static String unifiedFleetV4LoginUrl =
      "https://id.trimble.com/oauth/authorize?response_type=code" +
          "&client_id=$indiaStackClientId&state=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y" +
          "&redirect_uri=$tataHitachiRedirectUri&scope=openid InsiteFleet-2.0" +
          "&code_challenge=sbJmXLvS3LhVV88tdkRx1HDXhLazEfUH3jhDsMyMRSw&code_challenge_method=S256" +
          "&nonce=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y&navigationRedirectUri=/";

  static getV4LoginUrl(state, codeChallenge) {
    // Logger().e(state);
    //Logger().v(codeChallenge);
    Logger().i("indiaStack");
    String url = "https://id.trimble.com/oauth/authorize?response_type=code" +
        "&client_id=$indiaStackClientId&state=$state" +
        "&redirect_uri=$tataHitachiRedirectUri&scope=openid $tataHitachiApplicationName" +
        "&code_challenge=$codeChallenge&code_challenge_method=S256" +
        "&nonce=$state&navigationRedirectUri=/";
    print(url);
    return url;
  }

  static getV4AdminLoginUrl(state, codeChallenge) {
    String url = "https://id.trimble.com/oauth/authorize?response_type=code" +
        "&client_id=$indiaStackAdminmoduleAppClientId&state=$state" +
        "&redirect_uri=$localRedirectUri&scope=openid InsiteFleet-2.0" +
        "&code_challenge=$codeChallenge&code_challenge_method=S256" +
        "&nonce=$state&navigationRedirectUri=/";
    return url;
  }

  static String mobileRedirectUri = "insite://mobile";

  // static String tataHitachiRedirectUri =
  // "https://d1pavvpktln7z7.cloudfront.net/auth";
  // static String indiaStackClientId = "fe148324-cca6-4342-9a28-d5de23a95005";
  // static String tataHitachiApplicationName = "InsiteFleet-2.0";

  static String tataHitachiRedirectUri = "insite://mobile";
  static String tataHitachiLogoutUrl = "insite.logout://mobile";
  static String indiaStackClientId = "0fc72a71-e4e5-4ac1-9c7b-e966050154c9";
  static String tataHitachiApplicationName = "Frame-Administrator-IND";

//   static String indiaStackClientId = "8945245d-5970-4015-86d3-404976b9af5f";
//   static String tataHitachiApplicationName = "Frame-Administrator-IND";
// static String tataHitachiRedirectUri =
//       "https://insite-in-frame.frame-oesolutions.com/auth";

  // static String tataHitachiRedirectUri =
  //     "https://dj8lqow8wzdep.cloudfront.net/auth";
  // static String indiaStackClientId = "0fc72a71-e4e5-4ac1-9c7b-e966050154c9";
  // static String tataHitachiApplicationName = "Frame-Administrator-IND";
  static String visionLinkClientId = "af2b03d0-7b27-41eb-8a3a-95b89d20f78d";
  static String visionLinkApplicationName = "Prod-VisionLinkAdministrator";

  //   static String tataHitachiRedirectUri =
  //     "https://d20xyexn0ovnlx.cloudfront.net/auth";
  // static String indiaStackClientId = "f17ba8f6-a35a-4d78-8f24-bcc183b4e35a";
  // static String tataHitachiApplicationName = "OSG-IN-FRAME-APP-PROD";

  static String indiaStackAdminmoduleAppClientId =
      "a2f1b5a5-5b42-4488-9c19-555944c54578";
  static String localRedirectUri = "http://localhost:4200/auth";

  static String tenantDomain = "Trimble.com";

  static getV4LogoutUrl(String? token, redirecturi) {
    print(token);
    print(redirecturi);
    String url = Urls.idTokenBaseUrl +
        "/oauth/logout?id_token_hint=$token&post_logout_redirect_uri=$redirecturi";
    return url;
  }

  static logoutUrlVl(String? token) {
    String url = Urls.idTokenBaseUrl +
        "/oauth/logout?id_token_hint=$token&post_logout_redirect_uri=$administratorBaseUrl&state=$administratorBaseUrl/";
    return url;
  }

  static String logoutUrl =
      "https://identity.trimble.com/i/commonauth?commonAuthLogout=true" +
          "&type=samlsso&sessionDataKey=E294FEF4A64BF7E14940E2964F78E351" +
          "&commonAuthCallerPath=https://unifiedfleet.myvisionlink.com/tatahitachi/";
  static String logoutUrlUnifiedFleet =
      "https://identity.trimble.com/i/commonauth?commonAuthLogout=true" +
          "&type=samlsso&sessionDataKey=E294FEF4A64BF7E14940E2964F78E351" +
          "&commonAuthCallerPath=https://unifiedfleet.myvisionlink.com/";
  static String logoutUrlUnifiedService =
      "https://identity.trimble.com/i/commonauth?commonAuthLogout=true" +
          "&type=samlsso&sessionDataKey=E294FEF4A64BF7E14940E2964F78E351" +
          "&commonAuthCallerPath=https://unifiedservice.myvisionlink.com/";
  static String logoutURLV4 =
      "https://id.trimble.com/oauth/logout?id_token_hint=actual_token&post_logout_redirect_uri=insite://mobile";

  // visionlink api urls
  static String fleetSummaryVL =
      "https://unifiedfleet.myvisionlink.com/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2";
  static String assetSummaryVL =
      "/t/trimble.com/vss-assetutilization/1.1/AssetOperationDailyTotals";
  static String utlizationSummaryVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization";
  static String utlizationDetailsVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/v1";
  static String utlizationDetailsSummaryVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/Summary/v1";
  static String utilizationAggregateVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Details/Aggregate/v1";
  static String utilizationSummaryV1VL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization/Summary/v1";
  static String assetoperationsegmentsVL =
      "/t/trimble.com/vss-assetutilization/1.1/assetoperationsegments";
  static String locationSummaryVL =
      "/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1";
  static String locationHistoryVL =
      "/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/";
  static String assetCountSummaryVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1";
  static String assetCountSubscriptionSummaryVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/Subscription/v1";
  static String faultViewSummaryVL =
      "/t/trimble.com/vss-service/1.0/health/Faults/Search";
  static String assetViewSummaryVL =
      "/t/trimble.com/vss-service/1.0/health/Assets/FaultTotals";
  static String faultCodeSearchVL =
      "/t/trimble.com/vss-service-lookup/1.0/Faults/Descriptions/Search";

  static String faultCodeSearch = "/frame-fault/1.0/Faults/Descriptions/Search";

  static String assetHealthSummaryVL =
      "/t/trimble.com/vss-service/1.0/health/Assets";
  static String assetViewDetailSummaryV1VL =
      "/t/trimble.com/vss-service/1.0/health/FaultDetails/v1";
  static String faultCountSummaryVL =
      "/t/trimble.com/vss-service/1.0/health/FaultCount/v1";
  static String searchVL =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Search/v1";
  static String adminManagerUserSumaryVL =
      "/t/trimble.com/vss-identityapi/2.0/Users";
  static String applicationsUrlVL =
      "/t/trimble.com/vss-applicationapi/v1/applications";
  static String addUserSummaryVL = "/t/trimble.com/vss-identityapi/2.0/Users";
  static String applicationsUrl =
      "/t/trimble.com/vss-applicationapi/v1/applications";
  static String adminManagerUserSumary = "$identity/2.0/Users";
  static String adminRolesVL =
      "/t/trimble.com/vss-useraccessmanager/1.0/Applications";
  static String assetSettingsVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetsettings";
  static String assetSettingsFuelBurnrateVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetfuelburnratesettings";
  static String assetSettingsTarget =
      "/t/trimble.com/vss-assetsettings/1.0/assettargetsettings";
  static String withMaterialData =
      "/t/trimble.com/vss-unifiedproductivity/1.0/composite/sitewithconfigs/asgeofence";
  static String getMaterialData =
      "/t/trimble.com/vss-unifiedproductivity/1.0/productivity/materials";
  static String postPayLoad = "/t/trimble.com/vss-geofenceservice/1.0";
  static String getGeofenceInputsUrl =
      "/t/trimble.com/vss-unifiedproductivity/1.0/composite/sitewithtargets/";

  static String estimatedCycleVolumePayLoad =
      "/t/trimble.com/vss-assetsettings/1.0/assetproductivitysettings";
  static String estimatedMileageVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetmileagesettings";
  static String getEstimatedAsetSettingTargetDataVL =
      "/t/trimble.com/vss-assetsettings/1.0/assettargetsettings";
  static String getEstimatedCycleVoumePayLoadListDataVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetproductivitysettings";
  static String getAssetIconVL =
      "/t/trimble.com/vss-storeassetservice/1.0/AssetIcon";
  static String getAssetFuelBurnRateListDataVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetfuelburnratesettings";
  static String getAssetMileageListDataVL =
      "/t/trimble.com/vss-assetsettings/1.0/assetmileagesettings";
  static String deviceTypeVL =
      "t/trimble.com/vss-assetsettings/1.0/devicetypes";
  static String userCount = "$identity/2.0/Users/Count";
  static String getGroupListDataVL =
      "/t/trimble.com/vss-unifiedfleetmap/1.0/api/v1/assetlist";
  static String getGeoFenceData =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1";
  static String getManageGroupData = "/t/trimble.com/vss-groupservice/1.0";
  static String manageReportData =
      "/t/trimble.com/vss-reportmanager/v1/ScheduledReports";
  static String contactSearchListData =
      "/t/trimble.com/vss-contact/1.0/Contact";

  // india stack api urls
  static String fleetSummary = "$fleet/1.0/UnifiedFleet/FleetSummary/v5";
  static String authenticateUrl = "$subscriptionPrefix/authenticate";
  static String assetSummary =
      "$utilization/1.0/api/v4/AssetOperation/AssetOperationDailyTotals";
  static String utlizationSummary = "$fleet/1.0/UnifiedFleet/Utilization/v5";
  static String utilizationSummaryV1 =
      "$fleet/1.0/UnifiedFleet/Utilization/Summary/v1";
  static String utilizationDetails =
      "$utilization/1.0/api/v1/Utilization/Details";
  static String utilizationAggregate =
      "$utilization/1.0/api/v1/Utilization/Details/Aggregate";
  static String assetoperationsegments =
      "$utilization/1.0/api/v4/AssetOperation/assetoperationsegments";
  static String locationSummary = "$locationMap/1.0/location/maps/v2";
  static String locationHistory = "$assetHistory/1.0/AssetLocationHistory/";
  static String assetCountSummary = "$fleet/1.0/UnifiedFleet/AssetCount/v1";
  static String assetCountSubscriptionSummary =
      "$fleet/1.0/UnifiedFleet/AssetCount/Subscription/v5";
  static String faultViewSummary = "$health/1.0/health/Faults/Search";
  static String assetViewSummary = "$health/1.0/health/Assets/FaultTotals";
  static String assetHealthSummary = "$health/1.0/health/Assets";
  static String assetViewDetailSummaryV1 = "$health/1.0/health/FaultDetails/v1";
  static String faultCountSummary = "$health/1.0/health/FaultCount/v1";
  static String accounthierarchy = "$accountSelection/1.0/v1/accounthierarchy";
  static String assetDetails = "$fleet/1.0/api/v1/AssetDetails";
  static String notes = "$assetMataData/1.0/AssetMetadata/Notes/v1";
  static String search = "$fleet/1.0/api/v1/Search";
  static String fuelBurnedCumulative =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives";
  static String runTimeCumulative =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives";
  static String runTimeTotalHours =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/hours/cumulatives/intervals";
  static String fuelBurnedTotalHours =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/fuelburned/cumulatives/intervals";
  static String idlePercent =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/idlepercent";
  static String fuelPercent =
      "$fleet/1.0/api/v2/UtilizationGraphs/summary/fuelburnrate";
  static String faultSummary = "$health/1.0/health/faultSummary/v1";
  static String assetSettings =
      "/osg-in/$assetSettingsMasterData/1.0/v1/assetsettings";
  static String assetSettingsTargetListData =
      "/osg-in/$assetSettingsMasterData/1.0/v1/assettargetsettings";
  static String assetProductivitySettings =
      "$assetSettingsMasterData/1.0/v1/assetproductivitysettings";
  static String assetSettingsFuelBurnrate =
      "/osg-in/$assetSettingsMasterData/1.0/v1/assetfuelburnratesettings";
  static String estimatedMileage =
      "/osg-in/$assetSettingsMasterData/1.0/v1/assetmileagesettings";
  static String getGeofenceData = "$geofence/1.0";
  static String savingSms = "$smsManagementSingleAsset/savingsms";
  static String smsManagementSingleAsset = "$subscriptionPrefix/scheduleSms";
  static String smsManagementScheduleReportSummary =
      "$subscriptionPrefix/scheduleSmsSummaryReport";
  static String deleteSmsScheduleReport =
      "$smsManagementScheduleReportSummary/deleteReport";
  static String getScheduleReportData =
      "$smsManagementScheduleReportSummary/download";
  static String masterSearchDeviceId =
      "$subscriptionPrefix/masterSearch/smartSearch";
  static String getSearchModelResponse =
      "$subscriptionPrefix/subscriptionSave/device/";
  static String getReplaceDeviceIdModel = "$subscriptionPrefix/oemdetails";
  static String saveNewDeviceId = "$subscriptionPrefix/subscriptionSave/save";
  static String getReportOfReplacement =
      "$subscriptionPrefix/subscriptionSave/replacementHistory";
  static String downloadReplacementData = "$getReportOfReplacement/download";
  static String estimatedTargetSettingsData =
      "/osg-in/$accountSelection/1.0/v1/assettargetsettings";
  static String estimatedfuelBurnRateData =
      "/osg-in/$accountSelection/1.0/v1/assetfuelburnratesettings";
  static String estimatedMileageData =
      "/osg-in/$accountSelection/1.0/v1/assetmileagesettings";
  static String assetIconData = "/osg-in/$accountSelection/1.0/v1/Asset/";
  static String deviceTypes = "/osg-in/$accountSelection/1.0/v1/devicetypes";
  static String userCountVL = "/t/trimble.com/vss-identityapi/2.0/Users/Count";
  static String assetCreationResetdata =
      "$subscriptionPrefix/assetDetail/asset/activate/";
  static String downloadResetData =
      "$subscriptionPrefix/assetDetail/asset/activate/";
  static String getAddGroupSaveData = "/t/trimble.com/vss-groupservice/1.0";
  static String getEditGroupData = "/t/trimble.com/vss-groupservice/1.0/";
  static String addReportSaveData = "/frame-reports/1.0/ScheduledReports";
  static String contactSearchData = "/frame-contact/1.0/Contact";
  static String groupListData = "/frame-fleet-map/1.0/api/v1/assetlist";
  static String countReportData = "/frame-reports/1.0/ScheduledReports/Count";
  static String loginTokenStaged =
      "/oauth/token?grant_type=client_credentials&scope=OSG-IN-EQUIPMENT-WORKS-APP-DEV";

  //application url constants
  static String accountSelection = "/frame-masterdata";
  static String fleet = "/frame-fleet";
  static String utilization = "/frame-utilization";
  static String assetHistory = "/frame-assethistory";
  static String health = "/frame-fault";
  static String locationMap = "/frame-fleet-map";
  static String assetMataData = "/frame-assetmetadata";
  static String identity = "/frame-identity";
  static String assetSettingsMasterData = "/frame-masterdata";
  static String geofence = "/frame-geofence";
  static String subscriptionPrefix = "/osg-frame/frame-api/2.0";

  // static String accountSelection = "/npulse-masterdataapi-in";
  // static String fleet = "/npulse-fleet-in";
  // static String utilization = "/npulse-utilization-in";
  // static String assetHistory = "/npulse-vassethistory-in";
  // static String health = "/npulse-unifiedservice-in";
  // static String locationMap = "/npulse-fleet-in";
  // static String assetMataData = "/npulse-fleetassetmeta-in";
  // static String identity = "/npulse-identitymanager-in";

  //application name space constants
  static String nameSpace = "/osg-in";

  // static String nameSpace = "/CTSPulseIndiastg";

  // india stack api service header strings
  static String vMasterdata = "in-vlmasterdata-api-vlmd-customer";
  static String vfleetPrefix = "in-vfleet-uf-webapi";
  static String vutilizationPrefix = "in-vutilization-utz-webapi";
  static String vfleetMapPrefix = "in-vfleet-uf-map-api";
  static String faultPrefix = "in-fault-us-fault-api";
  static String fleetMapPrefix = "in-vassethistory-ah-webapi";
  static String assetprefix = "in-vassetmetadata-am-webapi";
  static String assetSettingsPrefix = "in-vlmasterdata-api-vlmd-assetsettings";
  static String userCountPrefix = "in-identitymanager-identitywebapi";
  static String notificationPrefix = "in-notification-nvapi";

  //subscription
  static String subscriptionResults = "/osg-frame/frame-api/2.0/oemdetails";
  static String singleAssetRegistration =
      "/osg-frame/frame-api/2.0/subscriptionSave/save";
  static String serialNumberSearch =
      "/osg-frame/frame-api/2.0/assetDetail/asset/model/";

  static String singleAssetTransferDeviceId =
      "/osg-frame/frame-api/2.0/hierarchy/getDealerAssets";

  static String singleAssetSearchDeviceIdData =
      "/osg-frame/frame-api/2.0/masterSearch/singleAsset";

  static String singleAssetSerchBySerialNo =
      "/osg-frame/frame-api/2.0/assetDetail/asset/hmr";

  static String getExistingCustomerDetails =
      "/osg-frame/frame-api/2.0/customer/";

  //plant
  static String plantHierarchyAssetsResult =
      "/osg-frame/frame-api/2.0/hierarchy";

  //subscription
  static String subscriptionResult = "/osg-frame/frame-api/2.0/subscription";
  static String transferHistoryResult =
      "/osg-frame/frame-api/2.0/transferView/gettransferstatus";
  static String plantAssetCreationResult =
      "/osg-frame/frame-api/2.0/assetDetail/asset/model";

// notification
  static String mainNotificationUrl =
      "/t/trimble.com/vss-notification/1.0/Notification/1";

  static String indiaStackMainNotificationUrl =
      "/frame-notification/1.0/Notification/1";

  static String notificationDetails =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetDetails/v1";

  static String deleteNotification =
      "/t/trimble.com/vss-notification/1.0/Notification";
  // static String deleteManageNotification =
  //     "/t/trimble.com/vss-alertsmanager/2.0/AlertConfigs/";
  static String deleteManageNotificationVL =
      "/t/trimble.com/vss-alertsmanager/2.0/AlertConfigs/";

  static String deleteManageNotification =
      "/frame-alertsmanager/2.0/AlertConfigs/";

//subnotification

  static String manageNotificationsDataVL =
      "/t/trimble.com/vss-alertsmanager/2.0/AlertConfigs/AlertConfigMetaData/1/20";

  static String manageNotificationsData =
      "/frame-alertsmanager/2.0/AlertConfigs/AlertConfigMetaData/";

  static String getNotificationTypesVL =
      "/t/trimble.com/vss-alertsmanager/2.0/NotificationTypes/AlertTypes";

  static String getNotificationTypes =
      "/frame-alertsmanager/2.0//NotificationTypes/AlertTypes";
  static String loginAudit = "${nameSpace + identity}/2.0/UserLogin/loginAudit";

  static String getCustomerZonesVL =
      "/t/trimble.com/vss-alertsmanager/2.0/zone/customer";

  static String getCustomerZones = "/frame-alertsmanager/2.0/Zone/Customer";

  static String createZone = "/frame-alertsmanager/2.0/Zone";

  static String getCustomerEmailAddress =
      "/t/trimble.com/vss-contact/1.0/Contact";

  static String checkIfNotificationNameExistsVL =
      "/t/trimble.com/vss-alertsmanager/2.0/AlertConfigs/AlertTitleExists";
  static String checkIfNotificationNameExists =
      "/frame-alertsmanager/2.0/AlertConfigs/AlertTitleExists";
  static String saveNewNotificationDataVL =
      "/t/trimble.com/vss-alertsmanager/2.0/AlertConfigs/";

  static String saveNewNotificationData =
      "/frame-alertsmanager/2.0/AlertConfigs";
  static String getMaintenanceViewDataVL =
      "/t/trimble.com/vss-plannedmaintenance/1.0/summary";

  static String getMaintenanceList =
      "/osg-in/maintenance-equipmentworks/1.0/maintenance/list";

  static String getMaintenanceAssetList =
      "/osg-in/maintenance-equipmentworks/1.0/maintenance/assetlist";

  static String getMaintenanceAssetData =
      "/t/trimble.com/vss-plannedmaintenance/1.0/assetcentric";
  static String getMaintenaceServiceData =
      "/t/trimble.com/vss-plannedmaintenance/1.0/asset";
  static String getCompleteData =
      "/t/trimble.com/vss-plannedmaintenance/1.0/occurrences/complete";

  static String getServiceCheckListData =
      "/t/trimble.com/vss-plannedmaintenance/1.0/checklists";

  // Staging Environment

  static String indiaStackClientIdStaging =
      "cecd72f9-e512-4875-9a71-fc602d525cf5";
  static String tataHitachiRedirectUriStaging =
      "https://osg-in-qa-pulse.frame-oesolutions.com/auth";
  static String tataHitachiApplicationNameStaging = "OSG-IN-PULSE-APP-QA";

  static getV4LoginUrlStaging(state, codeChallenge) {
    // Logger().e(state);
    //Logger().v(codeChallenge);
    Logger().i("indiaStack");
    String url = "$idTokenBaseUrlStaging/oauth/authorize?response_type=code" +
        "&client_id=$indiaStackClientIdStaging&state=$state" +
        "&redirect_uri=$tataHitachiRedirectUriStaging&scope=openid $tataHitachiApplicationNameStaging" +
        "&code_challenge=$codeChallenge&code_challenge_method=S256" +
        "&nonce=$state&navigationRedirectUri=https://osg-in-qa-pulse.frame-oesolutions.com/";
    print(url);
    return url;
  }
}
