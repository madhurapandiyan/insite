import 'helper_methods.dart';

class Urls {
  static String unifiedFleetBaseUrl =
      "https://cloud.api.trimble.com/CTSPulseIndiastg";
  static String unifiedServiceBaseUrl =
      "https://unifiedservice.myvisionlink.com";
  static String unifiedFleetV4BaseUrl = "https://d1pavvpktln7z7.cloudfront.net";
  static String unifiedFleetV4IdTokenUrl = "https://id.trimble.com";

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

  static String unifiedFleetV4LoginUrl =
      "https://id.trimble.com/oauth/authorize?response_type=code" +
          "&client_id=fe148324-cca6-4342-9a28-d5de23a95005&state=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y" +
          "&redirect_uri=https://d1pavvpktln7z7.cloudfront.net/auth&scope=openid InsiteFleet-2.0" +
          "&code_challenge=sbJmXLvS3LhVV88tdkRx1HDXhLazEfUH3jhDsMyMRSw&code_challenge_method=S256" +
          "&nonce=-vZVJb_tePeeslxPnRdOLLaEwP2JSHcocLtD9TKJijx_y&navigationRedirectUri=/";

  static getV4LoginUrl(state, codeChallenge) {
    String url = "https://id.trimble.com/oauth/authorize?response_type=code" +
        "&client_id=fe148324-cca6-4342-9a28-d5de23a95005&state=$state" +
        "&redirect_uri=https://d1pavvpktln7z7.cloudfront.net/auth&scope=openid InsiteFleet-2.0" +
        "&code_challenge=$codeChallenge&code_challenge_method=S256" +
        "&nonce=$state&navigationRedirectUri=/";
    return url;
  }

  static getVRLogoutUrl(String token, redirecturi) {
    String url = Urls.unifiedFleetV4IdTokenUrl +
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
  static String logoutURLV4 = "";

  static String fleetSummary = "/npulse-fleet-in/1.0/api/v2/FleetSummary";
  static String assetSummary = "/npulse-utilization-in/1.0/AssetOperation";
  static String utlizationSummary =
      "/npulse-fleet-in/1.0/UnifiedFleet/Utilization";
  static String utilizationSummaryV1 =
      "/npulse-fleet-in/1.0/UnifiedFleet/Utilization/Summary/v1";
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
      "npulse-masterdataapi-in/1.0/v1/accounthierarchy";
  static String assetDetails = "/npulse-fleet-in/1.0/api/v1/AssetDetails";
  static String notes = "/npulse-fleetassetmeta-in/1.0/AssetMetadata/Notes/v1";
  static String search = "/npulse-fleet-in/1.0/api/v1/Search";

  static String vMasterdata = "in-vlmasterdata-api-vlmd-customer";
  static String vfleetPrefix = "in-vfleet-uf-webapi";
  static String vutilizationPrefix = "in-vutilization-utz-webapi";
  static String vfleetMapPrefix = "in-vfleet-uf-map-api";
  static String faultPrefix = "in-fault-us-fault-api";
  static String fleetMapPrefix = "in-vassethistory-ah-webapi";
  static String assetprefix = "in-vassetmetadata-am-webapi";
}
