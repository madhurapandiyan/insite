class Urls {
  static String unifiedFleetBaseUrl =
      "https://cloud.api.trimble.com/CTSPulseIndiastg";

  static String unifiedServiceBaseUrl =
      "https://unifiedservice.myvisionlink.com";

  static String administratorBaseUrl = "https://administrator.myvisionlink.com";
  static String idTokenBaseUrl = "https://id.trimble.com";
  static String idTokenBaseUrlStaging = "https://stage.id.trimblecloud.com";
  static String idTokenKey = "Basic MTMwNTEwYmQtOGE5MC00Mjc4LWI5N2EtZDgxMWRmNDRlZjEwOmJmM2UzYmI4MGE3ODQ2Yjg5ZTFhMWU1Mzc5NDUxMmEw";
  static String idTokenKeyStaging = "Basic N2JlNzU5YjEtYWZjNS00YTRhLThhODYtYmRhNWUwNDVhNTA4OjY3NjdkYTcxZDliMzQ1YzM4ODZhZWExMmE4ZjNmNmZl";

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

  //sample
  static String unifiedFleetV4LoginUrl =
      "https://id.trimble.com/oauth/authorize?response_type=code" +
          "&client_id=$indiaStackClientId&state=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y" +
          "&redirect_uri=$tataHitachiRedirectUri&scope=openid InsiteFleet-2.0" +
          "&code_challenge=sbJmXLvS3LhVV88tdkRx1HDXhLazEfUH3jhDsMyMRSw&code_challenge_method=S256" +
          "&nonce=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y&navigationRedirectUri=/";

  static getV4LoginUrl(state, codeChallenge) {
    String url = "https://id.trimble.com/oauth/authorize?response_type=code" +
        "&client_id=$indiaStackClientId&state=$state" +
        "&redirect_uri=$tataHitachiRedirectUri&scope=openid InsiteFleet-2.0" +
        "&code_challenge=$codeChallenge&code_challenge_method=S256" +
        "&nonce=$state&navigationRedirectUri=/";
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
  //     "https://d1z5qa8yc2uhnc.cloudfront.net/auth";
  static String tataHitachiRedirectUri =
      "https://d1pavvpktln7z7.cloudfront.net/auth";
  static String localRedirectUri = "http://localhost:4200/auth";

  static String indiaStackAdminmoduleAppClientId =
      "a2f1b5a5-5b42-4488-9c19-555944c54578";
  // static String indiaStackClientId = "8945245d-5970-4015-86d3-404976b9af5f";
  static String indiaStackClientId = "fe148324-cca6-4342-9a28-d5de23a95005";
  static String tenantDomain = "Trimble.com";

  static getV4LogoutUrl(String token, redirecturi) {
    String url = Urls.idTokenBaseUrl +
        "/oauth/logout?id_token_hint=$token&post_logout_redirect_uri=$redirecturi";
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
  static String adminManagerUserSumary =
      "/npulse-identitymanager-in/1.0/2.0/Users";
  static String adminRolesVL =
      "/t/trimble.com/vss-useraccessmanager/1.0/Applications";
  static String adminRoles =
      "/t/trimble.com/vss-useraccessmanager/1.0/Applications";

  // india stack api urls
  static String fleetSummary = "/npulse-fleet-in/1.0/api/v2/FleetSummary";
  static String assetSummary = "/npulse-utilization-in/1.0/AssetOperation";
  static String utlizationSummary =
      "/npulse-fleet-in/1.0/UnifiedFleet/Utilization";
  static String utilizationSummaryV1 =
      "/npulse-fleet-in/1.0/UnifiedFleet/Utilization/Summary/v1";
  static String utilizationDetails =
      "/npulse-utilization-in/1.0/api/v1/Utilization/Details";
  static String utilizationAggregate =
      "/npulse-utilization-in/1.0/api/v1/Utilization/Details/Aggregate";
  static String assetoperationsegments =
      "/npulse-utilization-in/1.0/assetoperationsegments";
  static String locationSummary = "/npulse-fleet-in/1.0/location/maps/v1";
  static String locationHistory =
      "/npulse-vassethistory-in/1.0/AssetLocationHistory/";
  static String assetCountSummary =
      "/npulse-fleet-in/1.0/UnifiedFleet/AssetCount/v1";
  static String assetCountSubscriptionSummary =
      "/npulse-fleet-in/1.0/UnifiedFleet/AssetCount/Subscription/v1";
  static String faultViewSummary =
      "/npulse-unifiedservice-in/1.0/health/Faults/Search";
  static String assetViewSummary =
      "/npulse-unifiedservice-in/1.0/health/Assets/FaultTotals";
  static String assetHealthSummary =
      "/npulse-unifiedservice-in/1.0/health/Assets";
  static String assetViewDetailSummaryV1 =
      "/npulse-unifiedservice-in/1.0/health/FaultDetails/v1";
  static String faultCountSummary =
      "/npulse-unifiedservice-in/1.0/health/FaultCount/v1";
  static String accounthierarchy =
      "/npulse-masterdataapi-in/1.0/v1/accounthierarchy";
  static String assetDetails = "/npulse-fleet-in/1.0/api/v1/AssetDetails";
  static String notes = "/npulse-fleetassetmeta-in/1.0/AssetMetadata/Notes/v1";
  static String search = "/npulse-fleet-in/1.0/api/v1/Search";

  // india stack api service header strings
  static String vMasterdata = "in-vlmasterdata-api-vlmd-customer";
  static String vfleetPrefix = "in-vfleet-uf-webapi";
  static String vutilizationPrefix = "in-vutilization-utz-webapi";
  static String vfleetMapPrefix = "in-vfleet-uf-map-api";
  static String faultPrefix = "in-fault-us-fault-api";
  static String fleetMapPrefix = "in-vassethistory-ah-webapi";
  static String assetprefix = "in-vassetmetadata-am-webapi";

  //subscription
  static String subscriptionResults = "/osg-frame/frame-api/2.0/oemdetails";
}
