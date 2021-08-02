class Urls {
  static String unifiedFleetBaseUrl = "https://unifiedfleet.myvisionlink.com";
  static String unifiedServiceBaseUrl =
      "https://unifiedservice.myvisionlink.com";
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

  static String fleetSummary =
      "https://unifiedfleet.myvisionlink.com/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/FleetSummary/v2";
  static String assetSummary =
      "/t/trimble.com/vss-assetutilization/1.1/AssetOperationDailyTotals";
  static String utlizationSummary =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/Utilization";
  static String locationSummary =
      "/t/trimble.com/vss-unifiedfleetmap/1.0/location/maps/v1";
  static String locationHistory =
      "/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/";
  static String assetCountSummary =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/v1";
  static String assetCountSubscriptionSummary =
      "/t/trimble.com/vss-unifiedfleet/1.0/UnifiedFleet/AssetCount/Subscription/v1";
  static String faultViewSummary =
      "/t/trimble.com/vss-service/1.0/health/Faults/Search";
  static String assetViewSummary =
      "/t/trimble.com/vss-service/1.0/health/Assets/FaultTotals";
}
